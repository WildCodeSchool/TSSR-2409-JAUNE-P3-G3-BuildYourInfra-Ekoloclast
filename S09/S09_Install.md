# Ekoloclast

## Création d'un serveur VPN avec des clés partagées

Dans "VPN" et "OpenVPn", aller dans l'onglet "Servers", puis cliquer sur *Add*.  

Dans l'ordre, rentrer :  
- Description : **EKO-VPN avec Pharmgreen**  
- Server Mode : **Peer to Peer (Shared Key)**  
- Device Mode : **tun**  
- Protocol : **UDP on IPv4 only**  
- Interface : **WAN**  
- Local Port : **1194**  
- Shared key : **Check Automatically generate a shared key**  
- Tunnel Network : **10.3.100.0/30**
- Remote network : **10.15.0.0/16** (adresse de réseau LAN de Pharmgreen)  

Sauvegarder et retourner dans l'édition de ce serveur : copier la clé et la partager à Pharmgreen (de façon sécurisée).  
De son côté, Pharmagreen doit effectuer les démarches pour configurer son VPN Client. 

Il faut mettre à jour les règles de pare-feu.  
Dans l'interface WAN :  
![Règle WAN](/Ressources/S09_RegleWAN.png)  
Dans l'interface OpenVPN : (c'est une solution temporaire, il faudra sécuriser)  
![Règle OpenVPN](/Ressources/S09_RegleVPN.png)    
Il faut également ajouter les règles sur la LAN, pour ajouter le port 22222 par exmple (utilisé par l'autre société).  

Tester la configuration en lançant un ping vers les machines de la société Pharmgreen.  

---

## Création d'un serveur OPENVPN en TLS

### Ajouter l'annuaire LDAP à PfSense
Dans l'AD, ajouter le groupe "GrpUsers_AccessPfSense" dans l'OU "CompteDedie".  
Dans la même OU, créer l'utilisateur **PfSense** avec le SamAccountName **compte.pfsense** et ajouter_le au groupe nouvellement créé.  

**Dans l'interface GUI de PfSense :**
Dans "system", "User Manager" er"Authentication Servers", cliquer sur **Add**.  
Dans l'ordre, rentrer :  
- Descriptive name : *Eko.lan*
- Type : *LDAP*
- Hostame : *172.24.255.1* (mettre l'adresse de l'AD principal)  
- Port value : *389*  
- Transport : *Standart TCP*  
- Peer Certificate Authority : *Global Root CA List*  
- Protocol version : *3*  
- Server Timeout : *25*  
- Search scope : *Entire Subtree*  
- Base DN : *dc=eko,dc=lan*
- Authentication containers : *OU=Administrateurs,DC=eko,DC=lan* (l'OU contenant les admins)  
- Extended query : décoché  
- Bind anonymous : décoché  
- Bind credentials : *CN=PfSense,OU=CompteDedie,DC=eko,DC=lan* et le mot de passe associé  
- User naming attribute : *samAccountName*  
- Group naming attribute : *cn*
- Group member attribute : *memberof*
- RFC 2307 Groups : décoché
- Group object class : *group*  
- Shell Authentication Group DN : *CN=GrpUsers_AccessPfSense,OU=CompteDedie,DC=eko,DC=lan*  
- UTF8 Encode : décoché  
- Username Alterations : décoché  
- Allow unauthenticated bind : décoché  

Pour vérifier le bon fonctionnement, dans "Diagnostics" et "Authentication", choisir **ekko.lan** dans "Authentication Server". Rentrer les informations d'un compte admin appartenant à l'OU déclaré plus tôt. Puis cliquer sur "test".  
Le résultat devrait être comme sur l'image ci-dessous :  
![Test valide](/Ressources/S09_TestLDAP.png)  

Si le test ne fonctionne pas, il faut revérifier les "DistinguishedName". On peut également cocher l'option "set debug flag" dans le test, et vérifier dans les logs de PfSense.  

### Créer des certificats
Dans l'interface PfSense, dans "system","Certificates" puis "Authorities", cliquer sur **Add**.  
Dans l'ordre :
- Descriptive Name : *CA-EKO-OPENVPN*  
- laisser "create an internal certicate authority"  
- Common name : *eko*  
- Country Code : *FR*  
- Province or State : *Paris*  
- City : *Paris*  
- Organization : *Ekoloclast*  

![Certificat](/Ressources/S09_Certificat.png)

Dans "system","Certificates" puis "Certificate", cliquer sur **Add/Sign**. 
Dans l'ordre :
- "Create an internal certificate"  
- Descriptive name : *VPN-EKO*  
- Certificate authority : *CA-EKO-OPENVPN*  
- Common name : *vpn.eko.lan*  
- Country Code : *FR*  
- Province or State : *Paris*  
- City : *Paris*  
- Organization : *Ekoloclast*  
- Certificate Type : *Server Certificate*  
- Alternative Names : *FQND or Hostname* et *vpn.eko.lan*  

![Certificat](/Ressources/S09_Certificat2.png)  

Dans "system" et "User Manager", créer un utilisateur *compte.vpn* et cocher la case "create an user certificate". La CA doit être *CA-EKO-OPENVPN*. Ajouter un "descriptive name" comme *USER-COMPTEVPN*.  

![Compte VPN](/Ressources/S09_CompteVPN.png)

Le nouveau certificat de cet utilisateur est apparu.  
![Certificat de compte.vpn](/Ressources/S09_CompteVPN2.png)

---

## Installation et configuration du serveur web Wombat

Sur un CT Débian en 172.24.254.1 (avec une carte réseau vmbr640), entrer les commandes : 
```
apt update && apt upgrade -y
apt install apache2 -y
```

Puis aller dans **/var/www/html**. Le fichier à modifier pour personnaliser la page par défaut est **index.html**.  
Il existe des sites pour configurer des pages html sans connaissances, tel que **app.grapesjs.com**.  

Les fichiers de configuration de la page Ekoloclast se trouve à [ce lien](/Ressources/S09_PageEkoloclast.zip).  
Il faut les télécharger puis mettre les trois fichiers dans **/var/www/html**, en faisant une copie de la page "index.html" initiale.  
![Page Ekoloclast](/Ressources/S09_PageEkolo.png)

Le site est donc accessible, uniquement en interne, à l'adresse *http://172.24.254.1*. Il est conseillé de configurer un alias DNS.  

Si le site n'est pas accessible, merci de vérifier les règles de pare-feu concernant le LAN et la DMZ.  

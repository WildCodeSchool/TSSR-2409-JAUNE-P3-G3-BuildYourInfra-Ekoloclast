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

### Mise en place du site interne

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

### Mise en place du site externe Ekoloclast

Taper les commandes :  
```
# Création d'un nouveau dossier
mkdir /var/test
# Copie du fichier index.html
cp /var/www/html/index.html.bak /var/test/index.html
# Gestion des droits
chown -R $user:$user /var/test
chmod -R 755 /var/test
```

Modifier le fichier **/etc/apache2/ports.conf** et ajouter :
```
NameVirtualHost *:33888
Listen 33888
```  
![ports.conf](/Ressources/S09_Ports.png)  

Dans **/etc/apache2/sites-available/**, copier le fichier **OOO-default.conf** dans un nouveau fichier **test.conf**.  
Modifier ce nouveau fichier :  
```
<VirtualHost *:33888>  
    ServerAdmin webmaster@localhost  
    DocumentRoot /var/test
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
    <Directory "/var/test">
        Options FollowSymLinks
        AllowOverride ALl
        Order allow,deny
        Allow from all
        Require all granted
    </Directory>
</VirtualHost>
```  

Puis entrer les commandes ``a2ensite test``et ``systemctl reload apache2``.  

Vous pouvez désormais accèder à cette page en tapant **http://ekoloclast:33888**.  

Sur le pare-feu PfSense, dans "Firewall" et "NAT", créer une règle **Port Forward** :   
- Interface : *WAN*  
- Protocol : *TCP*  
- Destination : *WAN address*  
- Destination port range : *33888*  
- Redirect target IP : "Adress or Alias" et *172.24.254.1*  
- Redirect target port : *33888*  
- Description : *Accès Web Extérieur*  

![NAT](/Ressources/S09_NAT.png)  

Vérifier qu'une règle de pare-feu dans le WAN s'est bien créé.  

Vous pouvez accéder au site Ekoloclast extérieur en passant par l'adresse **httpp://10.0.0.2:33888**.  
![Web Extérieur](/Ressources/S09_WebExt.png)  


--- 
## Relation d'approbation avec Pharmgreen.lan

Sur le pare-feu, ajouter une réseau à l'interface LAN pour autoriser les connexions utilisant les ports AD du réseau LAN de Ekoloclast vers le réseau LAN de Pharmgreen.  

Sur le serveur DNS, dans "Conditional Forwarders", cliquer sur *New Conditional Forward*, avec **pharmgreen.lan** en domain DNS et **10.15.200.1** en adresse IP. Cocher la case "store the conditional forward in Active Directory", en laissant le choix par défaut.  
![DNS](/Ressources/S09_DNS.png)  

Dans "Active Directory Domains and Trusts", aller dans les propriétés de *eko.lan*. Dans l'onglet "Trusts", cliquer sur *New Trust*.  
Dans la nouvelle fenêtre, cliquer sur *Next* et entrer le nom de domaine **pharmgreen.lan**, puis cliquer de nouveau sur *Next.  
Choisir **External Trust**.  puis **Two-way** et enfin **Both this domain and the specified domain**.  
Entrer les coordonnées d'un compte administrateur de *pharmgreen.lan*.  
![Admin](/Ressources/S09_AdminPharm.png)  
Selectionner **Domain-wide authentication** deux fois.  
Cliquer deux fois sur *Next*.  
Selectionner **Yes, confirm the outgoing trust** puis **Yes, confirm the incoming trust**.
Cliquer sur *Finish* et fermer la fenêtre qui s'ouvre ensuite.  
![Trust](/Ressources/S09_Trust.png)  

De son côté, Pharmgreen doit également valider ce lien d'approbation.  
Pour vérifier le bon fonctionnement, se connecter avec un utilisateur de Pharmgreen.lan sur un machine du domaine Eko.lan et inversement.  
La relation d'approbation permet de visualiser et gérer l'AD de Pharmgreen. On peut même ajouter la forêt à la console *Group Policy Management*.   
![GPO](/Ressources/S09_GPOPharm.png)  

## installation Freepbx


1. Installation des Dépendances

apt update && apt upgrade -y
apt install -y wget curl nano sudo \
    gnupg2 network-manager libjansson-dev \
    build-essential git mariadb-server \
    mariadb-client apache2 php php-cli php-mbstring php-xml php-mysql php-curl \
    php-gd php-zip php-bcmath php-soap sox ffmpeg lame

2. Installation d'Asterisk

cd /usr/src
wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-20-current.tar.gz
tar xvf asterisk-20-current.tar.gz
cd asterisk-20.*/
contrib/scripts/install_prereq install
./configure && make menuselect
make -j$(nproc)
make install
make samples
make config
ldconfig
systemctl enable asterisk

3. Installation de FreePBX

cd /usr/src
wget http://mirror.freepbx.org/modules/packages/freepbx/freepbx-16.0-latest.tgz
tar xvf freepbx-16.0-latest.tgz
cd freepbx
./install -n

4. Configuration du Service FreePBX

chown -R asterisk:asterisk /var/lib/asterisk /var/www/html/
chown -R asterisk:asterisk /etc/asterisk /var/log/asterisk /var/spool/asterisk
systemctl restart asterisk
systemctl enable apache2 mariadb asterisk

5. Configuration de l'Intégration LDAP avec Active Directory

5.1. Installer et Activer le Module LDAP

Dans FreePBX, accédez à Admin > User Management > Directories et ajoutez un nouveau LDAP Directory.

5.2. Paramètres de Connexion LDAP

Nom : AD_LDAP

Serveur : ldap://addax.eko.lan

Port : 389 (ou 636 pour LDAPS)

Base DN : DC=eko,DC=lan

Bind DN : CN=admin.turchi,CN=Administrateus,DC=eko,DC=lan

Mot de passe : Azerty1*

Filtre Utilisateur : (objectClass=person)

Attributs d'Authentification : sAMAccountName

5.3. Tester et Appliquer la Configuration

Cliquez sur Test pour valider la connexion.

Sauvegardez et appliquez.

Dans User Management, synchronisez les utilisateurs AD.

6. Accès à FreePBX

Accédez à l'interface Web :

http://172.24.255.11/admin


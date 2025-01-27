# Ekoloclast

# Création d'un serveur OPENVPN Site à Site

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



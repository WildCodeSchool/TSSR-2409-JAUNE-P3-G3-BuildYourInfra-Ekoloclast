# Ekoloclast

## **Installation de Purple knight**

1. **Téléchargement**  
    - Rendez-vous sur le site officiel de **Semperis** et télécharge Purple Knight  [Lien officiel](https://www.purple-knight.com/)
    - Une fois le lien de téléchargement reçu par mail. Télécharger le fichier ZIP et extrait sur la machine.

2. **Installation**
    - Ouvrez le fichier décompresser et lancé `PurpleKnight.exe`.
    - Une erreur va apparaître, lancée PowerShell en mode Administrateur.
    - La commande pour Débloquer :

    `dir -Path (chemin du fichier) -Recurse | Unblock-file`
    - Une fois fait, lance une autre commande pour enlever la restriction :

    `Set-executionpolicy -executionpolicy unrestricted`
    - Puis fait `y`
    - Relance le fichier d'installation et Suivez les instructions d’installation.

3. **Exécution du scan**
    - Ouvrez **Purple Knight** en tant qu’administrateur.
    - Connectez-vous à votre **Active Directory**.
    ![PurpleKnight](/Ressources/s10_PurpleKnight_3.png)
    - Lancez un **scan** pour identifier les vulnérabilités.

4. **Analyse des résultats**
     - Une fois le scan terminé, Purple Knight génère un **rapport** avec des recommandations pour corriger les vulnérabilités.
    ![PurpleKnight](/Ressources/s10_PurpleKnight_4.png)


---
## **Audit de serverurs Linux avec Lynis**

Sur un serveur Linux, taper les commandes :  
```
apt-get update
apt-get install lynis -y
lynis audit system
```
Un rapport arrive. Il y a des "Warnings" à résoudre absolument et des "Suggestions" à remplir si possible.  
![Audit 1](/Ressources/S10_Audit.png)  

Taper les commandes suivantes (la première fois que vous lancez un audit) : 
```
apt-install fail2ban libpam-tmpdir apt-listbugs needrestart debsums apt-show-versions -y
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
apt-get update
apt-get upgrade -y
```

Modifier le fichier **/etc/login.defs** :
```
UMASK 027
PASS_MAX_DAYS 30
PASS_MIN_DAYS 1
SHA_CRYPT_MIN_ROUNDS 10000
SHA_CRYPT_MAX_ROUNDS 10000
```
Modifier le fichier **/etc/ssh/sshd_config** :
```
LogLevel VERBOSE
MaxAuthTries 3
MaxSessions 2
AllowAgentForwarding no
AllowTcpForwarding no
TCPKeepAlive no
Compression no
ClientAliveCountMax 2
```

S'il y a le warning **MAIL-8818** :  
```
postconf -e smtpd_banner=eko.NAME  
systemctl restart postfix 
```

S'il y a le warning **DBS-1820** , dans le fichier **/etc/mongod.conf**, ajouter les lignes :  
```
security:
    authorization: enabled
```

S'il y a le warning **NETW-2705**, dans le fichier **/etc/resolv.conf**, ajouter la ligne :
`` nameserver 172.24.255.1 ``  


S'il y a le warning **PKGS-7392** :  
```
apt-get update
apt-get upgrade -y
```  

Pour les autres warnings, se renseigner sur le site de Lynis et sur internet.   

Nous sommes passé d'environ 62%, 50 suggestions et 3 warnings en moyenne sur nos serveurs Linux, à 76%, 30 suggestions et 0 warning.  

![Résultat](/Ressources/S10_Warning.png)  

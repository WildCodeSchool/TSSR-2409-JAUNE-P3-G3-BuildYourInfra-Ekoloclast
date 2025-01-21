# Ekoloclast

## Installation et configuration du serveur de messagerie IRedMail, Manakin

### Dans une Débian :  
```
wget https://github.com/iredmail/iRedMail/archive/refs/tags/1.7.1.tar.gz
tar -xzf 1.7.1.tar.gz
cd iRedMail-1.7.1
bash iRedMail.sh
```
L'installation se lance. Laisser les deux premiers choix par défaut.  
Puis sélectionner "OpenLDAP" et rentrer **eko.lan**.  
Choisir le  mot de passe pour la base de donnée MySQL.  
Puis rentrer le nom du serveur mail **eko.lan** et choisir un mot de passse admin.  
Laisser les choix par défaut et attendre la fin de l'installation.  
Enfin, répondre aux deux questions concernant le SSH et redémarrer.  

### Sur une machine graphique :   
Se connecter à la page administration **http://172.24.255.7/iredadmin** grâce au compte *postmaster@eko.lan*.    
En cliquant sur **Ajouter** puis **Utilisateurs**, ajouter les différents adresses mail.  

### Sur un serveur Active Directory :    
Créer une GPO **C_Software_Computer_InstallThunderbird** appliquée sur l'OU *Ordinateurs*, avec les paramètres User désactivés.  
Télécharger le fichier d'installation MSI à ce [lien](https://www.thunderbird.net/fr/download/) et le placer dans un dossier partagé.  
Puis sélectionner ce fichier dans *Computer*, *Policies* et *Software*.

## Mise à jour du fichier RH

Pour les changements de noms et/ou d'emplacements des services et départements, cela est fait manuellement.
Il ne faut pas oublier : 
- changer le nom d'OU  
- changer le nom de groupe  
- deplacer l'OU et son groupe  
- supprimer les utilisateurs du groupe de leur ancien emplacement  
- modifier les noms et les autorisations des dossiers partagés de Fuligule  
- modifier les GPO de mappage J et mappage K  

La modification des utilisateurs se fait grâce à [ce script](/Ressources/S07_CreationUtilisateurs).   


## Instalaltion Redmine

1. Il faut installer mariadb `apt install mariadb-server`
2. on test la conenction à la base de donnée en root avec `mysql -u root -p`
   - création base de donnée -> create database redmine character set utf8mb4;
   - création de l'utilisateur -> grant all privileges on redmine.* 'redmine'@'localhost' identified by 'Azerty1*';
   - on echarge les privilèges des tables de droits -> flush privileges;
   - exit
3. on s'assure de la présence de la base de donnée dans le système `mysql -u redmine -p`
4. Il faut ensuite installer apache `apt install apache2 libapache2-mod-passenger`
5. On installe Redmine `apt install redmine redmine-mysql`. Une fenêtre apparait yes et on rentre le mot de passe.
6. On install Gem bundler `gem install bundler`
7. on crée une copie du fichierapache -> cp /usr/share/doc/redmine/examples/apache2-passenger-host.conf /etc/apache2/sites-avaible/redmine.conf
8. On va configurer ce fichier -> nano /etc/apache2/sites-avaible/redmine.conf
   -ServerName eko.lan
9. ln -s /usr/share/redmine/public /var/www/html/redmine
10. On active redmine sur apache `a2ensite redmine.conf` puis systemctl reload apache2
11. on se conencte avec l'adresse ip du serveur.



# Installation de Passbolt sur le conteneur Debian 12

## Configuration du dépôt de paquets

Pour faciliter les tâches d'installation et de mise à jour, Passbolt fournit un dépôt de paquets que vous devez configurer avant de télécharger et d'installer Passbolt CE.

### Étape 1. Téléchargez le script d'installation des dépendances :

`curl -LO https://download.passbolt.com/ce/installer/passbolt-repo-setup.ce.sh`

### Étape 2. Téléchargez SHA512SUM pour le script d'installation :

`curl -LO https://github.com/passbolt/passbolt-dep-scripts/releases/latest/download/passbolt-ce-SHA512SUM.txt`

### Étape 3. Vérifiez que le script est valide et exécutez-le :


`sha512sum -c passbolt-ce-SHA512SUM.txt && sudo bash ./passbolt-repo-setup.ce.sh || echo "Mauvais checksum. Abandon" && rm -f passbolt-repo-setup.ce.sh`


## Installation du paquet Linux officiel passbolt


`sudo apt install passbolt-ce-server`

## Configuration de MariaDB

Si vous n'êtes pas informé, le paquet Debian passbolt installera mariadb-server localement. Cette étape vous aidera à créer une base de données mariadb vide que passbolt peut utiliser.


Le processus de configuration vous demandera les identifiants de l'utilisateur administrateur de MariaDB pour créer une nouvelle base de données. Par défaut, dans la plupart des installations, le nom d'utilisateur administrateur serait `root` et le mot de passe serait vide.

Maintenant, vous devez créer un utilisateur mariadb avec des autorisations réduites pour que passbolt se connecte. Ces valeurs seront également demandées ultérieurement sur l'outil de configuration Web de passbolt, veuillez donc les garder à l'esprit.

![image](/Ressources/s07_image1.png)

![image](/Ressources/s07_image2.png)

Enfin,vous devez créer une base de données que passbolt peut utiliser, pour cela vous devez la nommer :

![image](/Ressources/s07_image03.png)



## Configuration de Nginx pour servir HTTPS

En fonction de vos besoins, il existe deux options pour configurer Nginx et SSL en utilisant le paquet Debian :

- Automatique (Utilisation de Let's Encrypt)
- Manuel (Utilisation de certificats SSL fournis par l'utilisateur)

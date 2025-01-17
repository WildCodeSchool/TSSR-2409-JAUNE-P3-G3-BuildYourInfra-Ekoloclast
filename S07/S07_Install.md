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


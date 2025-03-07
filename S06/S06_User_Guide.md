# Ekoloclast


## Utilisation du stockage partagé
À l'ouverture de votre session, vous trouverez trois raccourcis : un pour le dossier partagé de votre département, un pour le dossier partagé de votre service et un pour votre dossier individuel. 
Il est fortement conseillé de stocker vos données sur ces trois dossiers, tout en respectant la chartee informatique de Ekoloclast. Votre limite de stockage de votre dossier individuel est de 2Go. En cas de problème d'accès, merci de remonter un ticket au service Informatique.  
![Dossier Bureau](/Ressources/S06_DossierBureau.png)  


## Désactivation des services collecteurs de données et télémétrie.

**Sur le Windows Serveur 2022 :**  

### Création d'une GPO pour désactiver cortona

Ouvrir la console "Gestion de stratégie de groupe" et aller sur "Group Policy Objets" puis clic droit sur "New" pour créer une nouvelle GPO.

Nommer La nouvelle GPO par exemple : C_Settings_Computer_Désactivation_de_Cortona

Sur "Ordinateurs" clic droit "link an Existing GPO" pour lié la nouvelle GPO.

Faire un clic droit sur la GPO et sélectionner "edit".

Computer Configuration > Policies > Administration Templates > Windows Components > Search > Allow Cortona > Disabled

![GPO Télémétrie1](/Ressources/S06_GPO_Télémétrie_1.png)

Une fois fait, désactiver dans "détails" GPO Satus : "User configuration settings disabled" (car on n'en na pas besoins)

### Création d'une GPO pour désactiver l’envoie du nom du PC à Microsoft.

Toujours dans "Group Policy Objets", clic droit sur "New" pour créer une nouvelle GPO.

Nommer La nouvelle GPO par exemple : C_Settings_Computer_Désactivation_de_l'envoie_du_nom_PC

Sur "Ordinateurs" clic droit "link an Existing GPO" pour lié la nouvelle GPO.

Faire un clic droit sur la GPO et sélectionner "edit".

Computer Configuration > Policies > Administration Templates > Windows Components > Data Collection and Preview Builds > Allow device name to be sent in Windows diagnostic data > Disabled

![GPO Télémétrie3](/Ressources/S06_GPO_Télémétrie_3.png)

Une fois fait, désactiver dans "détails" GPO Satus : "User configuration settings disabled" (car on n'en na pas besoins)

**Sur le PC client Windows 10 :**

Dans CMD, mettre à jour la stratégie : gpupdate /force

Redémarrer le PC pour prendre en compte les nouveaux paramètres.

En allant sur Cortona, elle est bien désactivée.

![GPO Télémétrie2](/Ressources/S06_GPO_Télémétrie_2.png)

---

## GPO de Restriction Horaire
Il faut créer un groupe d'exception pour ces horaires. Donc créer un nouveau groupe de sécurité dans l'OU *Utilisateurs* nommé *GrpUsers_LogonHoursBypass*.  

Pour mettre à jour les plages horaires de chaque utilisateur Ekoloclast, télécharger le script [ici](/Ressources/S06_ScriptLogonHours.ps1)
La plage horaire autorisée pour se connecter est de **6h à 19h** du **lundi au samedi**.  
![Restriction horaire normale](/Ressources/S06_RestrictionHoraire.png)

Il faut lancer ce script régulièrement en utilisant **Task Scheduler** :  
- Créer une nouvelle tâche "MàJ Plage Horaire utilisateurs"
- *Action* : "Start a programme", écrire "Powershell" et donner l'emplacement du script en paramètre    
- *Triggers* : "daily" à "5:00am"  
![Trigger](/Ressources/S06_TaskSchedulerLogon.png)

Il faut maintenant créer la GPO *C_Security_Computer_RestrictedHoursAccess*.  
Pour cela :  
- désactiver la configuration Utilisateurs  
- ajouter les groupes de sécurité *GrpComputers_Ekoloclast*  
- dans *Computer*, *Policies*, *Windows Settings*, *Security Settings*, *Local Poliicies* et *Security Options*, sélectionner **Network security : Force logoff when logon hours expire**  
- lier à la GPO à l'OU *Ordinateurs*  

---

## Configuration du dashboard PfSense

![Dashboard](/Ressources/S06_PfSense_Dashboard.png)  

Afin d'obtenir ce résultat, il faut aller sur la page *Dashboard* à l'adresse **http://pfsense**.  
Les widgets à rajouter (en cliquant sur le "+" de "Status/Dashboard" et sur le "=" des Widgets à ajouter) sont :
- **Traffic Graphs**  
- **Service Status**  
- **Firewall Logs**  
- **System Information** : il faut retirer des informations moins importantes en cliquant le symbole d'outil.
- **Interfaces**
- **Disk**
- **S.M.A.R.T Status**  : cela sert à surveiller la santé du disque dur de la machine.  
- **Interface Statistics** : il faut retirer les informations concernant les paquets.

Pour avoir un affichage à 4 colonnes, aller dans *System* puis *General Setup* puis **Dashboard Columns**.  

## Création backup Addax et Fuligule

- Pour installer Windows Server Backup, nous allons dans ajout de fonctionnalités puis nous choisissons dans fonctionnalités `windows server backup` .
- Ensuite il faut lancer windows server backup dans tools.
- Clique droit sur Local Backup puis on sélectionne `Backup Schedule`.
- On poursuis en cliquant sur suivant.
- On sélectionne `Full server`
- Ensuite on définit l'heure et la fréquence de sauvegarde, nous allons  sélectionner `daily` et `23:00`.
- Pour pouvoir migrer la sauvegarde ailleurs, nous sélectionnons `Back up to a volume`.
- Pour l'étape suivante, on choisit le disque ou va être stocké la sauvegarde, ici nous utilisons le second disque du serveur.
- On arrive sur le résumer et on valide.

### Migration sauvegarde Addax et Fuligule sur Saola

1. On crée sur Saola un utilisateur toto
   - Adduser toto
2. On autorise l'utilisateur sans Samba
   - smbpasswd -a toto
3. On ajoute les droits de lecture et ecriture a l'utilisateur
   - chmod -R 777 /mnt/backups
4. sur chaque serveur windows, on crée un lecteur mappé à destination de Saola et leur dossier respectif.
   - Clique droit sur `this pc` -> `Map network drive`
   - On choisit la lettre souhaitée, puis on tappe le chemin vers Saola \\Saola\Backups\Addax
   - Une fenêtre apparait et on rentre les logs de toto.
5. On va créer une sauvegarde incrementielle en allandans clique droit sur démarrer -> computer management -> Task Scheduler library -> Microsoft -> Windows -> backup
   - clique droit sur `create new task`
     1. **General**
        - Cocher `run with hightest privileges`
     2. **Triggers**
        - New et on choisis daily et l'heure soulaitée.
     3. **Actions**
        - New
        - Program/script : robocopy
        - Add arguments : "F:\WindowsImageBackup" "\\Saola\backups\Fuligule" /E /XO /LOG:C:\Log\log.txt
     4. **Conditions**
        - on coche `wake the computer to run this task`
        
     5. **Settings**
        - On coche `Allow task to be run on demand`




## Migration de la sauvegarde Fuligule vers Saola


### Étapes pour automatiser Robocopy avec le Planificateur de tâches :

1. **Ouvrir le Planificateur de tâches** :
    - Cliquez sur le menu **Démarrer** et tapez **Planificateur de tâches** puis ouvrez-le.
2. **Créer une nouvelle tâche** :
    - Dans le Planificateur de tâches, cliquez sur **Créer une tâche** dans le panneau de droite.
3. **Configurer la tâche** :
    
	- **Onglet Général** :
        - On donne un nom à la tâche robocopy_fuligule_incrementielle.
        - Cochez l'option **Exécuter avec les autorisations les plus élevées**.
	- **Onglet Déclencheurs** :
        - Cliquez sur **Nouveau** pour ajouter un déclencheur.
        - Choisissez **Chaque jour** et définissez l'heure à laquelle vous souhaitez que la copie se fasse.
        - Cliquez sur **OK**.
	- **Onglet Actions** :
          - Cliquez sur **Nouveau** pour ajouter une action.
        - Dans **Programme/script**, tapez `robocopy`.
        - Dans **Ajouter des arguments**, entrez votre commande Robocopy sans le mot robocopy: "E:\Backup_Fuligule" "\\Saola\Backup\Fuligule" /E /XO /LOG:C:\log\Log.txt
  
## Backup Galago et migration vers Saola

### création backup Galago

1. **création du dossier**
     - Mkdir /mnt/backup
     - mount /dev/mvg/raid_backup
2. **création backup**
     - Rsync -aAXv --exclude=/mnt /mnt/backup

### Migration backup Galago vers Saola

1. **droit d'accès**
     - chmod -R 777 <nom backup>
2. **migration backup**
     - rsync -avz --no-t -e 'ssh -p 22' /mnt/backup/ toto@172.24.255.9:/mnt/backups/galago
   

## Utilisation de PRTG

Lorsque vous utilisez PRTG, plusieurs options s'offrent à vous.

![PRTG](/Ressources/S06_PRTG4.png)

Ici on va `ajouter un équipement`.

![PRTG](/Ressources/S06_PRTG5.png)

- Donnez un nom à l'équipement
- Sélectionnez ipv4 ou ipv6
- Donnez une adresse ip
- Décocher l'option SNMP et ajouter le nom **Eko** à la communauté.



![PRTG](/Ressources/S06_PRTG6.png)

Lorsque vous avez vos différents équipements,vous pouvez `ajouter un capteur` pour une meilleure supervison.


![PRTG](/Ressources/S06_PRTG7.png)

![PRTG](/Ressources/S06_PRTG8.png)

Vous pouvez choisir votre capteur en choisissant vos options,ici on prendra le `ping`.

![PRTG](/Ressources/S06_PRTG9.png)

Lorsque vous avez sélectionné votre capteur vous devrez le créér et attendre quelques secondes.


![PRTG](/Ressources/S06_PRTG10.png)

Votre capteur est désormais actif sur votre équipement.

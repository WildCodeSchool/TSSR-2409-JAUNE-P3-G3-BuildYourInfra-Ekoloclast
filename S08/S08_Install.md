 # Ekoloclast

 ## Transfert des rôles FSMO
Sur le serveur AD principal, Addax, lancer ``ntdsutil.exe`` et entrer ``role``.

Pour transférer le rôle de **RID Master** :
```
Connections
Connect to server axolotl
q
transfer RID master
```
Puis cliquer sur "Yes" dans la fênetre qui s'ouvre.  
![Visuel transfert RID](/Ressources/S08_TransfertRID.png)

Pour transférer le rôle de **Schema Master** :
```
Connections
Connect to server anolis
q
transfer schema master
```
Puis cliquer sur "Yes" dans la fênetre qui s'ouvre.  
![Visuel transfert schema](/Ressources/S08_TranfertSchema.png)

Pour vérifier que les rôles sont bien répartis, dans une invite de commande, taper ``netdom query /Domain:eko.lan FSMO``.  
Le résultat devrait être comme sur l'image ci-dessous :  
![Vérification transfert](/Ressources/S08_TransfertVerification.png)


---

## Placement Automatique des PC dans les bonnes OU

Il faut créer une nouvelle OU : **PCEnAttente**. Cela sera la place des PC dont le nom ne figure pas ddans la liste des PC connus. Il faudra donc aller régulièrement vérifier. 

Il faut télécharger ce [script](/Ressources/S08_ScriptPlacementPC.ps1) et le placer dans le dossier "Script" sur Addax.  

Il faut ensuite créer une tache dans **Task Scheduler** qui se lance quotidiennement à 3h00, en lancant le programme "Powershell" , en option "C:\Script\S08_ScriptPlacementPC.ps1".  

Le script range automatiquement les PC autorisés dans l'OU PC portable dans l'OU Paris. Cela sera à modifier en cas de changement de l'infrastructure.  

---

## Installation et configuration de WSUS

### Les Prérequis :
-  Serveur configuré (Renommer, IP, Horaire, Ajouter au Domaine, Active Directory).
- Ajouté un disque avec un espace de 30 Go formatée qui se nomme WSUS.
- Sur ce disque, créer un dossier WSUS

### Installation du rôle WSUS sur le serveur WSUS :
- Installée le rôle Windows Server Update Services.
- Valide les fonctionnalités supplémentaires qui vont s'ajouter automatiquement.
- Sélectionne WID Connectivity et WSUS Service.
- Indique le dossier que tu as créer pour l'emplacement du stockage des mises à jour.
- Termine l'installation et redémarre le serveur.

### Configuration du service WSUS :
- Une fois le serveur redémarré, lance la tâche Post Deployment Configuration for WSUS dans le Server Manager.
- Ensuite, dans la fenêtre de gauche, vas dans WSUS.
(Mettre une image)
- Avec le bouton droit sélectionne Windows Server Update Services cela va lancer automatiquement l'assistant de configuration.

![WSUS](/Ressources/s08_WSUS_ConfigurationduService.png)

##### Une fois l’assistance lancée :

- Décoche la case « Yes, I would like to join the Microsoft Update Improvement Program »
- Laisse sélectionné la case « Synchronize from Microsoft Update »
- Ne mets pas de proxy
- À la fin, clic sur « Start Connecting ». 
- Après, sélectionne les langues « English » et « French »
- Sélectionne une mises à jour pour Windows 10 et une mises à jour pour Windows serveurs 2022
- Pour les classifications laisse les choix par défaut
- Pour la synchronisation, choisi 4 synchronisations par jour, à partir de 2h.
- Enfin coche la case « Begin initial synchronization » et clic sur "Finish"
- Clic sur le nom de ton du serveur dans la fenêtre, et tu as l'état de la synchronisation avec le widget Synchronization Status.
- La Synchronization peu durée environs 1 heure.

- Une foix fait, va dans Options, puis Automatic Approvals.
- Dans l'onglet Update Rules, cocher Default Automatic Approval Rule.
- Cliquer sur Run Rules puis Cliquer sur Apply et OK

### Configuration sur WSUS
- Va dans Options, puis Computers.
- Coche l'option Use Group Policy... et valide

![WSUS](/Ressources/s08_WSUS_ConfigurationSurWSUS.png)

Dans l'arborescence des ordinateurs, sous All Computers, créer 2 groupes avec Add Computer Group :
- Grp-CLIENT-COMPUTER
- Grp-SERVER

![WSUS](/Ressources/s08_WSUS_ConfigurationSurWSUS2.png)

### Création des GPO clients et serveur :
#### GPO client :

Sur ton serveur WSUS, vas dans Tools > Group Policy Management > Group Policy Objet puis  créer une GPO : C_Settings_Comupter_WSUS_Clients

Va dans Computer Configuration > Policies > Administrative Templates > Windows Components > Windows update

Va dans `Specify intranet Microsoft update service location`, qui indiquera où est le serveur de mise à jour.
- Coche `Enabled`
- Dans les options, pour les 2 premiers champs, mettre l'URL avec le nom du serveur sous sa forme FQDN, ajouter le numéro du port 8530
- Valide la configuration

Va dans `Do not connect to any Windows Update Internet locations` qui bloque la connexion aux serveurs de Microsoft
- Coche `Enabled` et valide la configuration
- Le paramétrage ci-dessous est spécifique à cette GPO :
- Va dans `Configure Automatic Updates`
- Coche `Enabled`
Dans les options mets :
- Dans `Configure automatic updating » sélectionne « 4- Auto Download and schedule the install`
- Dans `Scheduled install day` mets `0 - Every day`
- Dans `Scheduled install time` mets `09:00`
- Cocher `Every week`
- Cocher `Install updates for other Microsoft Products`

Aller dans `Enable client-side targeting` qui fait la liaison avec les groupes crées dans WSUS
- Coche `Enabled`
- Dans les options, mettre le nom du groupe WSUS pour les ordinateurs cible, donc Grp-CLIENT-COMPUTER
- Valide la configuration

Aller dans `Turn off auto-restart for updates during active hours` qui permet d'empêcher les machines de redémarrer après l'installation d'une mise à jour pendant leurs heures d'utilisations
- Coche `Enabled`
- Dans les options, mettre (par exemple) `8 AM - 6 PM`

#### Une foix la GPO configurer :
- Relier l’OU à la GPO (Ordinateurs)
- ajouter le groupe concerner (Domaine Computer(EKO\DomaineCumputers)
- Désactiver dans Details  : User Configuration settings disabled

#### GPO serveur :
- Fais la même chose avec une GPO « C_Settings_Comupter_WSUS_Servers » mais en modifiant la cible du groupe WSUS (Grp-SERVER).
Pour copier une GPO avec Powershell  : 
- Copy-GPO -SourceName C_WSUS_Config -TargetName C_WSUS_Config_TEST
Une fois la GPO configurer :
- Relier l’OU à la GPO (Domaine Controllers)
- ajouter le groupe concerner (Domaine Controllers(EKO\ Domaine Controllers)
- Désactiver dans Details  : User Configuration settings disabled

### Vérification des GPO :
- Sur chaque client, exécuter la commande avec le compte administrateur local `gpupdate /force`.
- On peut vérifier si les GPO sont appliquée avec la commande `gpresult /R`.

### Gestion des mises à jour :
- Sur le serveur WSUS, va dans la partie Updates et sélectionne Security Updates.
- Sélectionne des mises à jour et ouvre le menu d'approbation avec le bouton droit de la souris puis Approve.
- Tu vas retrouver les groupes que tu as créer sous l'arborescence All Computers.
- Tu peux pour chacun des groupes appliquer les différentes mises à jour ou bien les bloquer.

![WSUS](/Ressources/s08_WSUS_GestionDesMisesAJour.png)

---

## Étape 1 : Installation des dépendances

   1. **Installer MariaDB et Apache2**  
    Ouvrez un terminal et exécutez les commandes suivantes pour installer MariaDB et Apache2 :
    
    
    
    apt install mariadb-server
    apt install apache2
   2. **Télécharger le script d'installation de FreePBX**  
    Accédez au répertoire `/tmp` et téléchargez le script d'installation de FreePBX :
    
    cd /tmp
    wget https://github.com/FreePBX/sng_freepbx_debian_install/raw/master/sng_freepbx_debian_install.sh -O /tmp/sng_freepbx_debian_install.sh

   3. Exécutez le script d'installation avec la commande suivante :

    bash /tmp/sng_freepbx_debian_install.sh


   ## Étape 2 : Configuration via l'interface web

   1. **Accéder à l'interface web**  
    Ouvrez un navigateur web et entrez l'adresse IP de votre serveur `172.24.255.11`.

   2. **Connexion à FreePBX**
    
   Cliquez sur `FreePBX Administration`.
        
   Connectez-vous avec vos identifiants.

   Ignorer l'activation et les offres commerciales
    
   Cliquez sur `Skip` pour ignorer l'activation du serveur et les offres commerciales.
   Laissez tous les paramètres par défaut et cliquez sur `Submit`.
   À la fenêtre d'activation du firewall, cliquez sur `Abort`.
   À la fenêtre de l'essai de SIP Station, cliquez sur `Not Now`.
   Allez dans `Menu` puis `System Admin`.
   Un message indique que le système n'est pas activé. Cliquez sur `Activation`, puis `Activate` et de nouveau `Activate`.
        

## Étape 3 : Lier FreePBX à l'Active Directory (AD)

1. **Accéder à la gestion des utilisateurs**
    
    - Allez dans `Admin` -> `User Management` puis `Directories`.
        
2. **Ajouter un annuaire LDAP**
    
    - Cliquez sur `Add` et remplissez les champs comme suit (en utilisant les informations de votre AD) :
        
        - **Directory name** : Nom que vous souhaitez donner à votre base de données.
            
        - **Hosts** : `172.24.255.2` (adresse IP du serveur AD).
            
        - **Port** : `389`.
            
        - **Username** : `Administrator`.
            
        - **Domain** : `eko.lan`.
            
        - **Base DN** : `dc=eko,dc=lan`.
            
3. **Vérification des utilisateurs**
    
    - Retournez dans `Users` pour voir la liste de vos utilisateurs AD.
   
    

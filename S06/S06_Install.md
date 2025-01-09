# Ekoloclast

## Configuration du serveur de fichiers Fuligule

## Mise en place des dossiers de partage Utilisateurs

Sur le disque dur dédié, créer un dossier "Utilisateurs".  
Faire un clic droit dessus, puis sélectionner "Properties", "sharing" et "Advanced Sharing".  
Cocher la case "Share this folder" et mettre "Utilisateurs$" en *ShareName*.  
Dans "Permissions", retirer "Everyone" et ajouter "Authenticated User", "GrpAdmins_Ekoloclast" et "Administrators" avec des droits *FullControl*.  
![Droits du dossier Utilisateurs](/Ressources/S06_DroitUtilisateurs.png)  
Dans l'onglet "Security", aller dans "Advanced", cliquer sur "disable inheritance" et ajuster les droits pour avoir le même résultat que sur l'image ci-dessous.  
![Sécurité du dossier Utilisateurs](/Ressources/S06_SécuritéUtilisateurs.png)  

Créer une nouvelle GPO : **U_Sharing_User_MappageLecteurI** qui sera appliquée sur l'OU Utilisateurs.  
Désactiver la configuration Ordinateur.  
Puis dans "Preferences" et "Windows Settings" :  
- "Drive Maps" : faire "new" et choisir "create" en *action*, "\\fuligule\Utilisateurs$"\%LogonUser%" en *location*, "I" en use et"DossierIndividuel" en *label*. Cocher les cases "Show all drives" et "reconnected". Enfin dans l'onglet "common", cocher " run in logged-on user security context".  
- "Folder" : choisir "replace" en *action* et "\\fuligule\Utilisateurs$"\%LogonUser%" en *location*. Cocher "Archive". Enfin dans l'onglet "common", cocher " run in logged-on user security context".  
- "Shortcuts" : suivre les mêmes attributs que sur la photo ci-dessous.  
![GPO Utilisateurs ](/Ressources/S06_GPOUtilisateurs.png)


## Mise en place des dossiers de partage Service et Département

Sur le disque dur dédié, créer un dossier "Service" et un dossier "Département".  

Créer, dans le bon dossier, de nouveaux dossiers aux noms des différents services et départements.

Pour chaque sous-dossier :
- Faire un clic droit dessus, puis sélectionner "Properties", "sharing" et "Advanced Sharing".
- 
- Cocher la case "Share this folder" et mettre le nom du dossier suivi d'un "$" en *ShareName*.

- Dans "Permissions", retirer "Everyone" et ajouter le groupe de sécurité concerné par ce dossier, "GrpAdmins_Ekoloclast" et "Administrators" avec des droits *FullControl*.  
![Droits du dossier UService](/Ressources/S06_DroitsService.png)

- Dans l'onglet "Security", aller dans "Advanced", cliquer sur "disable inheritance" et ajuster les droits pour avoir le même résultat que sur l'image ci-dessous.  
![Sécurité du dossier UService](/Ressources/S06_SécuritéService.png)  

Créer deux nouvelles GPO : *U_Sharing_User_MappageLecteurJ* et *U_Sharing_User_MappageLecteurK* qui seront appliquées sur l'OU Utilisateurs.  
Désactiver la configuration Ordinateur.  
Puis dans "Preferences", "Windows Settings" et "Drive Maps", pour chaque sous-dossier :
- faire "new" et choisir "replace" en *action*, le chemin réseau du sous-dossier en *location*, "J" (pour les dossiers de service) ou "K" (pour les départements) en *use* et "Dossier de Service" ou "Dossier de Département" en *label*.   
-  Cocher les cases "Show all drives" et "reconnected".   
-  Dans l'onglet "common", cocher " run in logged-on user security context" et "Item-level targeting".  
-  Cliquer sur "targeting..." et choisir, dans "New Item", "Security Group".  
-  Choisir le groupe de sécurité concerné.  
![GPO Service](/Ressources/S06_GPOService.png)

Dans "Preferences", "Windows Settings" et "Shortcuts" : faire "new" et mettre les mêmes attributs que sur l'image ci-dessous. 
Enfin dans l'onglet "common", cocher " run in logged-on user security context".  
![GPO Service Shortcut](/Ressources/S06_GPOService2.png)

![GPO Service Résumé](/Ressources/S06_GPOService3.png)  

## Configuration de LAPS

Il faut tout d'abord télécharger le fichier **LAPS.x64.msi** à ce [lien](https://www.microsoft.com/en-us/download/details.aspx?id=46899) et placer ce document dans le partage du serveur AD.  
Puis, sur le contrôleur de domaine **FSMO Maitre RID** (Addax), lancer l'installation de la même manière que sur l'image suivante :  
![Installation LAPS sur le serveur](/Ressources/S06_InstallationLAPS.png)  

Dans une console PowerShell, exécuter les commandes suivantes :
```
Import-Module AdmPwd.PS  
Update-AdmPwdADSchema  
Set-AdmPwdComputerSelfPermission -OrgUnit "OU=Ordinateurs,DC=eko,DC=lan"  
Set-AdmPwdReadPasswordPermission -Identity "OU=Ordinateurs,DC=eko,DC=lan" -AllowedPrincipals "GrpAdmins_Ekoloclast"  
Set-AdmPwdResetPasswordPermission -Identity "OU=Ordinateurs,DC=eko,DC=lan" -AllowedPrincipals "GrpAdmins_Ekoloclast"  
Copy-Item -Recurse -Force -Path "C:\PolicyDefinitions" -Destination "C:\Windows\SYSVOL\sysvol\eko.lan\Policies"  
```  

Créer deux nouvelles GPO **C_Security_Computer_LAPS**  et **C_Software_Computer_InstallLAPS**, liées à l'OU *Ordinateurs*, avec la configuration *User* désactivée. 
Retirer le "Authenticated User" et rajouter "Domain Computer" et "GrpComputers_Ekoloclast".  

Pour **C_Security_Computer_LAPS**, dans *Computer Configuration*, *Administrative Template* et *LAPS* :  
- *Password Settings* : mettre "Enabled" et "32" en *Password Length*  
- *Do not allow password expiration* : mettre "Enabled"
- *Enable local  admin password* : mettre "Enabled"  

Pour **C_Software_Computer_InstallLAPS**, dans *Computer Configuration*, *Policies*, *Software Settings* et *Software Installation* :  
- Faire "New"
- Choisir le fichier "LAPS.x64.msi" présent sur le dossier partagé

# Configuration  Graylog:
## Sur le PC Windows 10, Configurer Graylog pour recevoir les logs Windows :
- Entrer le lien sur un navigateur web pour se connecter au serveur Graylog : http://172.24.255.10:9000

Mètre le compte admin et le mdp :
- Username : admingraylog
- Password : Azerty1*

Créer un input NXLog dans Graylog :
- cliquez sur le menu Système puis > Inputs >  Select input > GELF UDP > Launch new input.
- Ajouter un titre et laisser le port par défaut (12201). Le reste doit être laisser pars défaut.

![GraylogInput](/Ressources/S06_GraylogCréationInput.png)
- Puis valider avec “Launch Input“

## Sur le Windows Serveur 2022, installer et configurer NXLog :
- Pour télécharger l'agent NXLog aller sur le lien : https://nxlog.co/downloads/nxlog-ce#nxlog-community-edition
- Puis faite NXLog Community Edition > logo Windows > Windowz x86-64 > Download.

![GraylogAgent](/Ressources/S06_GraylogAgentNxlog.png)
- Cliquez sur le fichier téléchargé et lancer l’installation.
- Puis faite Next X3 > install.

Configurer NXLog pour Graylog :
NXLog étant installé sur la machine, nous pouvons éditer son fichier de configuration situé à l'emplacement suivant :
- C:\Program Files\nxlog\conf\nxlog.conf

En complément de la configuration déjà présente dans le fichier "nxlog.conf", on vas ajouter ces lignes à la fin :
```
<Input in>
    Module      im_msvistalog
</Input>

# Déclarer le serveur Graylog (selon input)
<Extension gelf>
    Module        xm_gelf
</Extension>

<Output graylog_udp>
    Module        om_udp
    Host          172.24.255.10
    Port	  12201
    OutputType    GELF_UDP
</Output>

# Routage des flux in vers out
 <Route 1>
     Path        in => graylog_udp
 </Route>
```
Sauvegardez les changements et redémarrez le service NXLog à partir d'une console PowerShell ouverte en tant qu'administrateur :
- Restart-Service nxlog

## Sur le PC Windows 10, recevoir les journaux Windows dans Graylog :
- les journaux doivent désormais être envoyés vers Graylog. Pour le vérifier, cliquez simplement sur "Search" dans le menu de Graylog.

![GraylogSearch](/Ressources/S06_GraylogMenuSearch.png)

- Si On clique sur un log dans la liste, vous pouvez visualiser son contenu. Cela revient à consulter le journal à partir de l'Observateur d'événements de Windows.
- Pour rafraichir la liste automatiquement toutes les 5 secondes. Aller sur "Not updating".


## Installation PRTG

Dans un premier temps vous devrez vous rendre sur ce lien:
[PRTG](https://www.paessler.com/prtg/download)
Vous pourrez ensuite télécharger la version gratuite de PRTG.



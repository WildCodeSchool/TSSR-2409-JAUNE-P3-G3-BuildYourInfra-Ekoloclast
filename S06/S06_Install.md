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

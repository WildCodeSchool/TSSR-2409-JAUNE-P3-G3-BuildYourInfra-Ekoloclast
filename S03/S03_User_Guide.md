# Ekoloclast

## Ajout de nouveaux utilisateurs
Il faut créer un fichier .csv sur le modèle de ce [document](Ressources/S03_ListeEmployes.csv), puis, sur le serveur **Addax**, lancer ce [script](Ressources/S03_CreationUtilisateurs.ps1) qui va gérer la création de l'utilisateur dans les bonnes OU, la rentrée d'informations et l'ajout dans les groupes principales (utilisateurs, localisation, département et service).  
Le script ne gère pas l'ajout du manager dans la fiche Utilisateur.


## Les GPO
Nous avons créé 13 GPO pour le moment. Elles ont été nommées selon la convention de nommage.  
![Résumé des GPO](/Ressources/S03_RésuméGPO.png)  

Si la GPO commence par un U, le statut de la GPO est en "Computer Configuration settings disabled" et les changements ne concerneront que l'utilisateur. La cible sera donc un groupe d'utilisateurs et la GPO Sera liée à une OU utilisateur.  
Inversement, si la GPO commence par un C, le statut de la GPO est en "User Configuration settings disabled" et les changements ne concerneront que l'ordinateur. La cible sera donc un groupe d'ordinateurs et la GPO Sera liée à une OU ordinateur.  

### GPO pour imposer une politique de mot de passe pour chaque ordinateur
Elle se nomme "C_Security_Computer_PasswordPolicy". Elle est liée à l'OU Ordinateur et est filtré par le groupe GrpComputer_Ekoloclast.  
Il faut modifier de la même manière les paramètres sur la photo ci-dessous.
![GPO mot de passe](/Ressources/S03_GPOPassword.png)  

### GPO pour imposer une veille au bout de 10 minutes et une sortie de veille avec mot de passe
Elle se nomme "C_Security_Computer_SleepModePassword". Elle est liée à l'OU Ordinateur et est filtré par le groupe GrpComputer_Ekoloclast.  
Il faut modifier de la même manière les paramètres sur la photo ci-dessous.
![GPO veille](/Ressources/S03_GPOVeille.png)  

### GPO pour interdire l'installation de logiciel à des non-administrateurs
Elle se nomme "C_Security_Computer_SoftwareInstallationBlocked". Elle est liée à l'OU Ordinateur et est filtré par le groupe GrpComputer_Ekoloclast.  
Il faut modifier la GPO en allant dans "Computer Configuration" - "Policies" - "Windows Settings" - "Security Settings" - " Software Restriction Policies".  
Avec un clic droit, il faut créer une nouvelle restriction. 
Dans "Security Levels", puis "Basic User", modifiez-le en choisissant "Set as Default".
Dans "Enforcement", choisissez "All users except local administrators".

### GPO pour retirer l'animation de l'installation à la première connexion
Elle se nomme "C_Setting_Computer_désactivation-animation-installation". Elle est liée à l'OU Ordinateur et est filtré par le groupe GrpComputer_Ekoloclast.  
Il faut modifier, dans le menu "Computer Configuration" - "Policies" - "Administratives Templates" - "System" - "Logon", le paramètre "Show first sign-in animation" en "disabled".  

### GPO pour installer Chrome
Elle se nomme "C_Setting_Computer_InstallChrome". Elle est liée à l'OU Ordinateur et est filtré par le groupe GrpComputer_Ekoloclast.  
Il faut créer, dans le menu "Computer Configuration" - "Policies" - "Software POlicies" - "System" - "Power Management", une politique pour Chrome, en ajoutant le fichier .msi de Chrome, placé sur un emplacement réseau (un dossier partagé au groupe cible).  
Le fichier se trouve [ici](https://chromeenterprise.google/intl/fr_fr/download/?utm_source=adwords&utm_medium=cpc&utm_campaign=2024-H2-chromebrowser-paidmed-paiddisplay-other-chromebrowserent&utm_term=downloadnow-chrome-browser-enterprise-download&utm_content=GCOB&brand=GCOB&gad_source=1&gclid=Cj0KCQiAu8W6BhC-ARIsACEQoDBWm9X5zlpeRWxJEWhO6EB5pybTsdhdNJ9luNb3f8EoTrZezfh66ikaAqa2EALw_wcB&gclsrc=aw.ds#windows-tab)].  

### GPO pour installer GLPI Client
Elle se nomme "C_Setting_Computer_AgentGLPI". Il faut faire exactement comme la GPO Chrome en choisissant le fichier GLPI qui se trouve [ici](https://github.com/glpi-project/glpi-agent/releases/tag/1.7).  

### GPO pour bloquer l'invit de commande aux utilisateurs
Elle se nomme "U_Security_User_CommandPromptBlocked". Elle est liée à l'OU Utilisateur et est filtré par le groupe GrpUsers_Ekoloclast.  
Il faut modifier, dans le menu "User Configuration" - "Policies" - "Administratives Templates" - "System" , le paramètre "Prevent access to the command prompt" en "enabled".  

### GPO pour bloquer le panneau de configuration aux utilisateurs
Elle se nomme "U_Security_User_ControlPanelBlocked". Elle est liée à l'OU Utilisateur et est filtré par le groupe GrpUsers_Ekoloclast.  
Il faut modifier, dans le menu "User Configuration" - "Policies" - "Administratives Templates" - "Control Panl" , le paramètre "Prohibit access to control panel and PC settings" en "enabled".  

### GPO pour bloquer l'éditeur de registre aux utilisateurs
Elle se nomme "U_Security_User_RegistryBlocked". Elle est liée à l'OU Utilisateur et est filtré par le groupe GrpUsers_Ekoloclast.  
Il faut modifier, dans le menu "User Configuration" - "Policies" - "Administratives Templates" - "System" , le paramètre "Prevent access to the regestry editing tools " en "enabled".  

### GPO pour changer l'arrière-plan
Elle se nomme "U_Setting_User_Desktop". Elle est liée à l'OU Utilisateur et est filtré par le groupe GrpUsers_Ekoloclast.  
Il faut modifier, dans le menu "User Configuration" - "Policies" - "Administratives Templates" - "Desktop" - "Desktop", le paramètre "Desktop wallpaper" et choisir une image sur un emplacement réseau (dont le groupe cible a les droits de lecture).    

### GPO pour ajouter un lecteur sur le groupe Marketing
Elle se nomme "U_Sharing_Marketing_mapageLecteur". Elle est liée à l'OU DirectionMarketing et est filtré par le groupe GrpUsers_DirectionMarketing.  
Il faut créer, dans le menu "User Configuration" - "Preferences" - "Windows Settings" - "Drive Maps" , un nouveau lecteur en choisssant "create", la lettre du lecteur (M:\) et un emplacement réseau accesible au grouep Marketing.  

### GPO pour bloquer Windows Media Player aux utilisateurs
Elle se nomme "U_Settings_User_BlockWMlayer". Elle est liée à l'OU Utilisateur et est filtré par le groupe GrpUsers_Ekoloclast.  
Il faut modifier, dans le menu "User Configuration" - "Policies" - "Administratives Templates" - "System" , le paramètre "Don't run specified Windows applications" et choisir "wmplayer.exe".  


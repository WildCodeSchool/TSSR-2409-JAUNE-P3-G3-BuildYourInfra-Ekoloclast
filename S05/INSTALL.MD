# TSSR-2402-P3-G3-EKOLOCLAST

## installation serveur Fuligule

1. On utilise le modèle 698-WindowsServer2022 pour le clone (full clone)
2. On ajoute : - une carte réseau
               - Deux disques hdd (32Go)
3. On lance la Vm, on change dans un premier temps le nom de l'odinateur par Fuligule.


## Install guide Infrastructure sécurisée pour Ekoloclast

### 1 - Mettre en place des dossiers réseaux pour les utilisateurs

#### Stockage

Pour commencer, on ajoute un disque dur virtuel à la vm filigule. Le disque est formaté et se nomme Ad_stockage.

#### Mappage du lecteur réseau i
![](S05/S05_Gpomap.png)

1. Nous créons un dossier dans le disque installé, qui nous nommerons Utilisateurs. Clique droit sur le dossier et on selectionne `propriétés`.
2. Aller sur l'onglet sharing et selectionner  partage avancé

#S05_adancesharing
![](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S05/S05_advancesharing.png)

3. Dans la case nom de partage mettre `Utilisateurs$` (le symbole $ permet de masquer le dossier pour les utilisateurs.
4. Ensuite on clique sur permissions, `supprimer` pour retirer les utilisateurs ayant accès au dossier et on ajoute `Administrateur` et `Utilisateur authentifiés`, puis leurs donner  le contrôle 
totale.

#S05_permissionUser
![](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S05/S05_permissionUser.png)

5. Ensuite on se rend sur l'onglet `sécurité` puis `avancé` pour configurer les droits ntfs sur le dossier.

6. Cliquer sur `désactiver héritage` pour désactiver l'héritage des droits sur le dossier, et comfirmer le choix.

#S05_héritage
![](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S05/S05_h%C3%A9ritage.png)

7. Cliquer sur le bouton `ajouter` et autoriser `créateur propriétaire`, `Système`, `Administrateurs`, `GrpUsers_Ekoloclast`. Leurs donner le contrôle totale, puis valider.
8. Nous allons ensuite dans `groupe policy management`, pour GPO.

#S05_grpPolicyManagement
![](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S05/S05_grpPolicyManagement.png)

9. Clique droit sur `group policy management` et selectionner `nouvelle GPO` et nous allons la nommer "U_Sharing_Users_mappageReseau_I"
10. En premier, nous allons nous rendre dans `Configuration utilisateur` -> ` Preferences` -> `Paramètres Windows` -> `Dossier`
  • Il faut clique droit dans la fenêtre de droite, et dans ènouveauè on selectionne `dossier`.

#S05_gpoDossier  
![](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P3-G3-BuildYourInfra-Ekoloclast/blob/main/S05/S05_gpoDossier.png)
  
• Complétez la fenêtre en spécifiant bien l’emplacement où seront créés les dossiers utilisateurs (cet
    emplacement correspond à l’espace de partage précédemment configuré).
  • Cliquer l’onglet « Commun » et activez la case « Exécuter dans le contexte de sécurité de l’utilisateur
    connecté (option de stratégie utilisateur) » et validez vos choix.

#S05_ConfigGpoDossier

11. En second, nous allons nous rendre dans `Configuration utilisateur` -> ` Preferences` -> `Paramètres Windows` -> `lecteur mappé`
  • Completer la fenêtre ainsi :
    
    • %LogonUser% permet de créer un dossier partagé avec l'identifiant de l'utilisateur
    • Cocher la case Reconnect permet de reconnecter automatiquement le lecteur en cas de déconnexion.
    • afficher ce lecteur et afficher tous les lecteurs permettra d'afficher le lecteur dans l'arborescence de fichiers

#S05_gpoMap

l'onglet `Commun` et cliquez la case `Exécuter dans le contexte de sécurité` et valider.

12. Nous allons ajouter un raccourci sur le bureau de l’utilisateur connecté. Ce raccourci pointera directement vers son
espace personnel sur le serveur.
    • nous allons nous rendre dans `Configuration utilisateur` -> ` Preferences` -> `Paramètres Windows` -> `raccourcis`
    • Sélectionner « Raccourcis » et faire un clic droit dans la fenêtre de droite, Cliquer `Nouveau`-> `Raccourci`
    • Completer la fenêtre ainsi :

    • Cliquer l’onglet « Commun » et activez la case « Exécuter dans le contexte de sécurité de l’utilisateur
    connecté (option de stratégie utilisateur) » et validez vos choix.

#S05_gpoRaccourcie



### 2 - Mettre en place du RAID 1 sur le volume système des serveurs

1. On installe deux disques HHD sur le serveur.
2. Clique droit sur le menu démarrer, et selectionner `gestionnaire de disque`.
3. Clique droit sur le disque et selectionner `nouveau volume en mirroir`.\
![](/Ressources/S05_raid1.1.png)
4. Ajouter le deuxième disque, puis cliquer sur suivant pour selectionner la lettre du lecteur, cliquer sur suivant encore pour nommer le lecteur et valider.\
![](/Ressources/S05_raid1.2.png)\

5. Attendre la fin du formatage du disque.\
![](/Ressources/S05_raid1.3.png)

### 3 - Mettre en place une sauvegarde du volume qui contient les dossiers partagés des utilisateurs

### 4 - Mise en place de LAPS

### 5 - Automatisation du placement dans la bonne OU

### 2 Installation RAiD1




## installation serveur Fuligule

1. On utilise le modèle 698-WindowsServer2022 pour le clone (full clone)
2. On ajoute : - une carte réseau
               - Deux disques hdd (32Go)
3. On lance la Vm, on change dans un premier temps le nom de l'odinateur par Fuligule.


## Install guide Infrastructure sécurisée pour Ekoloclast

### 1 - Mettre en place des dossiers réseaux pour les utilisateurs

### 2 - Mettre en place du RAID 1 sur le volume système des serveurs

### 3 - Mettre en place une sauvegarde du volume qui contient les dossiers partagés des utilisateurs

### 4 - Mise en place de LAPS

### 5 - Automatisation du placement dans la bonne OU

### 2 Installation RAiD1

1. On installe deux disques HHD sur le serveur.
2. Clique droit sur le menu démarrer, et selectionner `gestionnaire de disque`.
3. Clique droit sur le disque et selectionner `nouveau volume en mirroir`.\
![](/Ressources/S05_raid1.1.png)
4. Ajouter le deuxième disque, puis cliquer sur suivant pour selectionner la lettre du lecteur, cliquer sur suivant encore pour nommer le lecteur et valider.\
![](/Ressources/S05_raid1.2.png)\

5. Attendre la fin du formatage du disque.\
![](/Ressources/S05_raid1.3.png)

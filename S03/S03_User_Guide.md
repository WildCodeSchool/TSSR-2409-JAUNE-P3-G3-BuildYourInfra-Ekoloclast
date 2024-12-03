# Ekoloclast

## Ajout de nouveaux utilisateurs
Il faut créer un fichier .csv sur le modèdle de ce [document](Ressources/S03_ListeEmployes.csv), puis, sur le serveur **Addax**, lancer ce [script](Ressources/S03_CreationUtilisateurs.ps1) qui va gérer la création de l'utilisateur dans les bonnes OU, la rentrée d'informations et l'ajout dans les groupes principales (utilisateurs, localisation, département et service).  
Le script ne gère pas l'ajout du manager dans la fiche Utilisateur.

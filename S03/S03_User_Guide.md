# Ekoloclast

## Ajout de nouveaux utilisateurs
Il faut créer un fichier .csv sur le modèdle de ce [document](Ressources/S03_ListeEmployes.csv), puis, sur le serveur **Addax**, lancer ce [script](Ressources/S03_CreationUtilisateurs.ps1) qui va gérer la création de l'utilisateur dans les bonnes OU, la rentrée d'informations et l'ajout dans les groupes principales (utilisateurs, localisation, département et service).  
Le script ne gère pas l'ajout du manager dans la fiche Utilisateur.


## Création GPO pour mappé un lecteur réseau

1. créer la GPO
2. Modifiez la GPO créer, et parcourir l'arborescence de cette façon : Configuration utilisateur -> Préférences -> Paramètres Windows -> Mappages de lecteur.
3. Sur la droite, faire un clique droit : nouveau -> lecteur mappé.
4. Dans - action : choisir mettre à jour,
        - emplacement : Mettre le chemin serveur du dossier a partager (\\addax\marketing)
        - choisir la lettre du lecteur et valider



## Création GPO pour installer Chrome

1. La première étape consiste à se rendre sur le site de google pour télécharger le package MSI : Download Chrome[[www.google.fr](https://chromeenterprise.google/intl/fr_fr/download/?utm_source=adwords&utm_medium=cpc&utm_campaign=2024-H2-chromebrowser-paidmed-paiddisplay-other-chromebrowserent&utm_term=downloadnow-chrome-browser-enterprise-download&utm_content=GCOB&brand=GCOB&gad_source=1&gclid=Cj0KCQiAu8W6BhC-ARIsACEQoDBWm9X5zlpeRWxJEWhO6EB5pybTsdhdNJ9luNb3f8EoTrZezfh66ikaAqa2EALw_wcB&gclsrc=aw.ds#windows-tab)]

2. Créer un dossier de partage à la racine du C:
3. clique droit sur le dossier, on va dans les propriétés, partage-> partage avancé : il faut cocher partager ce dossier et mettre  en ,nom du partage le nom du dossier et un $ à la fin.
en suite dans l'onget sécurité, on ajoute les ordinateurs du domaines avec pour droit de lecture seulement.
4. Mettre le fichier MSI dans le dossier
5. Dans l'éditeur de gestion des stratégies de groupe, il faut créer une GPo puis l'éditer, Configuration ordinateur->paramètred du logiciel->nouveau->package
6. il faut indiquer le chemin vers le fichier MSI. **N'utilisez pas le chemin local, mais le chemin réseau vers le partage pour rechercher le fichier MSI.**
7. cochez "attribué" et valider.

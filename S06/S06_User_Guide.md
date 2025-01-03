## Sure le Windows Serveur 2022 :

### Configuration paramètres pour l'ordinateur

Ouvrez la console "Gestion de stratégie de groupe" et aller sur "Group Policy Objets" puis clic droit sur "New" pour créer une nouvelle GPO.

Nommer La nouvelle GPO par exemple : C_Settings_Users_Désactivation_Télémétrie

Faite un clic droit sur la GPO et sélectionner "edit".

Aller dans Configuration Utilisateur > Modèles d'administration > Composants Windows > Collecte de données et versions d'aperçu > Autoriser la télémétrie?

![GPO Télémétrie1](/Ressources/S06_GPO_Télémétrie_1.png)

Une foix fait,  désactiver dans "détails" GPO Satus : "User configuration settings disabled" (car on n'en na pas besoins)


### Sure le PC client Windows 10

Dans CMD, mettre à jour la stratégie : gpupdate /force

Redémarré le PC pour prendre en compte les nouveaux paramètre.

En allant sur Cortona, elle et bien désactivé.

![GPO Télémétrie2](/Ressources/S06_GPO_Télémétrie_2.png)

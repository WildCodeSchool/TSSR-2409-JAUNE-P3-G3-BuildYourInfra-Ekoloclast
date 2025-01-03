## Sure le Windows Serveur 2022 :

### Crétion d'une GPO pour désactiver cortona

Ouvrez la console "Gestion de stratégie de groupe" et aller sur "Group Policy Objets" puis clic droit sur "New" pour créer une nouvelle GPO.

Nommer La nouvelle GPO par exemple : C_Settings_Computer_Désactivation_de_Cortona

Sur "Ordinateurs" clic droit "link an Existing GPO" pour lié la nouvelle GPO.

Faite un clic droit sur la GPO et sélectionner "edit".

Computer Configuration > Administration Templates > Windows Components > Search > Allow Cortona > Disabled

![GPO Télémétrie1](/Ressources/S06_GPO_Télémétrie_1.png)

Une foix fait,  désactiver dans "détails" GPO Satus : "User configuration settings disabled" (car on n'en na pas besoins)


### Sure le PC client Windows 10

Dans CMD, mettre à jour la stratégie : gpupdate /force

Redémarré le PC pour prendre en compte les nouveaux paramètre.

En allant sur Cortona, elle et bien désactivé.

![GPO Télémétrie2](/Ressources/S06_GPO_Télémétrie_2.png)

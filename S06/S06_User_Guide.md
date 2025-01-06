# Ekoloclast

## Désactivation des services collecteurs de données et télémétrie.

**Sur le Windows Serveur 2022 :**  

### Création d'une GPO pour désactiver cortona

Ouvrir la console "Gestion de stratégie de groupe" et aller sur "Group Policy Objets" puis clic droit sur "New" pour créer une nouvelle GPO.

Nommer La nouvelle GPO par exemple : C_Settings_Computer_Désactivation_de_Cortona

Sur "Ordinateurs" clic droit "link an Existing GPO" pour lié la nouvelle GPO.

Faire un clic droit sur la GPO et sélectionner "edit".

Computer Configuration > Administration Templates > Windows Components > Search > Allow Cortona > Disabled

![GPO Télémétrie1](/Ressources/S06_GPO_Télémétrie_1.png)

Une fois fait, désactiver dans "détails" GPO Satus : "User configuration settings disabled" (car on n'en na pas besoins)

### Création d'une GPO pour désactiver l’envoie du nom du PC à Microsoft.

Toujours dans "Group Policy Objets", clic droit sur "New" pour créer une nouvelle GPO.

Nommer La nouvelle GPO par exemple : C_Settings_Computer_Désactivation_de_l'envoie_du_nom_PC

Sur "Ordinateurs" clic droit "link an Existing GPO" pour lié la nouvelle GPO.

Faire un clic droit sur la GPO et sélectionner "edit".

Computer Configuration > Administration Templates > Windows Components > Data Collection and Preview Builds > Allow device name to be sent in Windows diagnostic data > Disabled

![GPO Télémétrie3](/Ressources/S06_GPO_Télémétrie_3.png)

Une fois fait, désactiver dans "détails" GPO Satus : "User configuration settings disabled" (car on n'en na pas besoins)

**Sur le PC client Windows 10 :**

Dans CMD, mettre à jour la stratégie : gpupdate /force

Redémarrer le PC pour prendre en compte les nouveaux paramètres.

En allant sur Cortona, elle est bien désactivée.

![GPO Télémétrie2](/Ressources/S06_GPO_Télémétrie_2.png)

---

## GPO de Restriction Horaire
Il faut créer un groupe d'exception pour ces horaires. Donc créer un nouveau groupe de sécurité dans l'OU *Utilisateurs* nommé *GrpUsers_LogonHoursBypass*.  

Pour mettre à jour les plages horaires de chaque utilisateur Ekoloclast, télécharger le script [ici](/Ressources/S06_ScriptLogonHours.ps1)
La plage horaire autorisée pour se connecter est de **6h à 19h** du **lundi au samedi**.  
![Restriction horaire normale](/Ressources/S06_RestrictionHoraire.png)

Il faut lancer ce script régulièrement en utilisant **Task Scheduler** :  
- Créer une nouvelle tâche "MàJ Plage Horaire utilisateurs"
- *Action* : "Start a programme" et donner l'emplacement du script  
- *Triggers* : "daily" à "5:00am"  
![Trigger](/Ressources/S06_TaskSchedulerLogon.png)

Il faut maintenant créer la GPO *C_Security_Computer_RestrictedHoursAccess*.  
Pour cela :  
- désactiver la configuration Utilisateurs  
- ajouter les groupes de sécurité *GrpComputers_Ekoloclast*  
- dans *Computer*, *Policies*, *Windows Settings*, *Security Settings*, *Local Poliicies* et *Security Options*, sélectionner **Network security : Force logoff when logon hours expire**  
- lier à la GPO à l'OU *Ordinateurs*  




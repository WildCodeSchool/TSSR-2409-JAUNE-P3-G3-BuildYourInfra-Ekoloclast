# Ekoloclast

## Création d'un serveur GLPI
### Sur le serveur Debian
- Mettre une adresse IP fixe et avoir internet.
- Télécharger les mises à jour et les installés (apt update && apt upgrade -y)
- Installation de Apache2
- Installation et configuration de Mariadb
- Installation de GLPI
- Installation et configuration de PHP 8.3
- Une foi l'installation et la configuration terminer. Faire un redémarrage du PC ou un sudo systemctl restart apache2 pour bien prendre en compte les paramètres.

### Sur le PC client Windows 10
- Entrer le lien sur un navigateur web pour se connecter au serveur GLPI : http://172.24.255.6/glpi.eko.lan/
- Sur la page d'installation :

Langue : **Français**\
Cliquer sur **Installer**\
Corriger éventuellement les **requis**\
Serveur SQL : 127.0.0.1 ou localhost\
Utilisateur : glpi\
Mot de passe : Azerty1*\

![GLPI installation](/Ressources/S03_GlpiInstallation.png)

- Une foi connectée avec le compte administrateur glpi, vous arriver sur le menu de Glpi.
![GLPI menu](/Ressources/S03_GlpiMenu.png)

- Pour faire le lien entre GLPI et l'AD.(Utilisateurs et Administrateur)
- Aller dans Configuration > Authentification > Annuaire LDAP > ajouter > Preconfiguration : Active Directory
![GLPI annuaire](/Ressources/S03_GlpiAnnuaireLDPA.png)

- Pour ajouter les utilisateurs et les Administrateurs à GLPI.
- Aller dans Administration > Utilisateurs > Liaison annuaire LDAP > Importation de nouveaux utilisateurs > Mode expert > Choisir l'annuaire et modifier le BaseDN si nécessaire.
![GLPI ajout](/Ressources/S03_GlpiAjoutDesUtilisateursetAdmin.png)

### Pour ajouter des ordinateurs à GLPI 
- Activer l'inventaire dans GLPI :

Cliquez sur "Administrateur" dans le menu latéral

Cliquez sur "Inventaire"

- Cochez l'option "Activer l'inventaire" et "Créer un ordinateur pour les machines virtuelles"
- Enregistrez la modification en cliquant sur le bouton "Sauvegarder" en bas de page

## Sure le serveur Windows,
### Télécharger et partager le package MSI de l'agent GLPI
- Créé un répertoire partagé et les permissions de partage sont définies comme suit :

Groupe "Ordinateurs du domaine" en lecture seule
Groupe "Admins du domaine" en contrôle total

- Télécharger package MSI de l'agent GLPI et le mettre sur le répertoire partagé.
- Création du partage SMB (partage de fichiers réseau)
- Depuis le Gestionnaire de serveur > Services de fichiers et de stockage > Partages > Tâches (en haut à gauche pour créé le partage SMB)
![GLPI partage](/Ressources/S03_ServeurPartageGlpi2.png)

### Installer l'agent GLPI par GPO
- Ouvrez la console "Gestion de stratégie de groupe" et créez une nouvelle GPO.
- Une fois la GPO créée, éditer via un clic droit sur son nom puis "Modifier".
- Configuration ordinateur > Stratégies > Paramètres du logiciel > Installation de logiciel
- Effectuez un clic droit puis : Nouveau > Package.
![GLPI agent](/Ressources/S03_GpoGlpiAgent.png)

### Configurer l'agent GLPI dans le Registre Windows
- clic droit sur la GPO Glpi puis "Modifier"
- Configuration ordinateur > Préférences > Paramètres Windows > Registre
- clic droit puis cliquez sur Nouveau > Elément Registre.
![GLPI registre](/Ressources/S03_GlpiRegistry.png)

![GLPI registre1](/Ressources/S03_GlpiRegitre2.2.png)

![GLPI registre2](/Ressources/S03_GlpiRegitre3.2.png)
### Tester la GPO :
- Première étape, mettre à jour les GPO sur la machine client : gpupdate /force
- Ouvrir un navigateur afin d'accéder à l'interface de l'agent GLPI à partir de l'URL suivante : http://localhost:62354
- Cliquez sur "Force an inventory".
![GLPI lient](/Ressources/S03_GlpiLient.png)

Sure GLPI aller sur > Parc > Ordinateurs. Le PC client doit apparaître.
![GLPI ordinateur](/Ressources/S03_GlpiOrdinateur3.png)

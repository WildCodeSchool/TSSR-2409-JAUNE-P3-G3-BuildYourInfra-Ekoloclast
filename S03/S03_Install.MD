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
- Suivre les indications demandées.

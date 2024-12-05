# Ekolocast

## La liste de matériels nécessaires
La liste des matériels se trouve [ici](Ressources/S02_ListeMatériels)  et comprend le matériel que nous avons besoin afin de créer un réseau fonctionnel.

## L'installation d'une machine cliente
Sur votre machine cliente, il faut nommer le PC selon la convention de nommage (dans notre cas, Pxxxx, x étant un chiffre).  
Il faut ensuite configurer l'adresse IP : en DHCP et avec un DNS correspondant à un serveur DNS (dans notre cas, Addax et Axolotl).  
![Windows10](/Ressources/S02_Changement_DNS.png)  
Après avoir reçu une adresse IP dans le réseau, il faut se connecter au domaine **Eko**.  
![Windows10](/Ressources/S02_Ajout_au_domaine.png)  


## L'installation et configuration du Serveur Wwindows Serveur 2022 AD/DNS/DHCP - Addax

Dans un premier temps, il faut configurer une adresse IP fixe, nommer le serveur et faire les mises à jour. Puis, on installe les rôles AD-DS, DHCP et DNS.

En second, on configure les plages DHCP, selon l'adressage IP convenu.
![ServeurGrafique](/Ressources/S02_WindowsServerGraphique.png)
![ServeurCore](/Ressources/S02_WindowsServerGraphiqueDHCP.png)


Il faut ensuite créer les unités d'organisation au sein de l'AD, selon la convention de nommage.
![ServeurGrafique](/Ressources/S02_WindowsServerGraphiqueADDS.png)


![ServeurCore](/Ressources/S02_WindowsServerGraphiqueDNS.png)
## L'installation et configuration du Serveur Core AD/DNS - Axolotl

Configurer un nom de domaine pour le serveur core
![ServeurCore](/Ressources/S02_WindowsServerCore.png)


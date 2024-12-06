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

Pré-requis

Nous avons besoin de :

   - une Vm Windows server 2022 (GUI)
       
       - Nom de compte : `Administrator`
       - Mot de passe : `Azerty1*`
       - Adresse ip : `172.24.255.1`

  
   
  Les deux VM seront installées sur Proxmox, à partir de modèle pré-configurés, voici comment en installer une :
  
  Selectionner le template voulu dans l'arborescence située sur la gauche de l'écran
    - Faire un clic-droit sur la VM voulu, puis cliquer sur Clone
    - Pour VM ID, mettre un nom bre entre 630-650
    -Dans Name, mettre un nom avec la nomenclature suivante : TSSR-P3-G3-"Nom de la VM"
    -Dans Ressource Pool, selectionner TSSR-2409-Jaune-P3-G3
    -Dans la rubrique Mode, selectionner Full Clone
    -Et enfin, cliquer sur Clone

Une fois créer, dans hardawre selectionner `add` puis `network device`.
Pour bridge : 625, modele : E1000, et il faut décocher firewall.



En second, on configure les plages DHCP, selon l'adressage IP convenu.
![ServeurGrafique](/Ressources/S02_WindowsServerGraphique.png)
![ServeurCore](/Ressources/S02_WindowsServerGraphiqueDHCP.png)


Il faut ensuite créer les unités d'organisation au sein de l'AD, selon la convention de nommage.
![ServeurGrafique](/Ressources/S02_WindowsServerGraphiqueADDS.png)


![ServeurCore](/Ressources/S02_WindowsServerGraphiqueDNS.png)
## L'installation et configuration du Serveur Core AD/DNS - Axolotl

  - Une VM Windows server 2022 (core)

      - Nom de compte : `Administrator`
       - Mot de passe : `Azerty1*`
       - Adresse ip : `172.24.255.2`

Configurer un nom de domaine pour le serveur core
![ServeurCore](/Ressources/S02_WindowsServerCore.png)


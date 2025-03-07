# TSSR-2409-JAUNE-P3-G3-BuildYourInfra-Ekoloclast

## 0- Récapitulatif des documentations
## Convention

| Sujet | Lien | État |
| :--: | :--: | :--: |
| Convention de nommage | [lien](./Ressources/S01_ConventionNommage.md) | À jour (S07) |
| Adressage IP | [lien](./Ressources/S01_AdressageIP.md) | À jour (S08) |
| Table de routage | [lien](./Ressources/S01_TableDeRoutage.md) | À jour (S03) |
| Liste des matériels | [lien](./Ressources/S02_ListeMateriels) | À jour (S09) |


## Fichiers d'installation 

| Sujet | Lien | État |
| :--: | :--: | :--: |
| Serveur AD - DHCP - DNS | [lien](./S02/S02_Install.md) | À jour (S07) |
| Serveur AD Core | [lien](./S02/S02_Install.md) | A jour (S07) |
| Serveur GLPI | [lien](./S03/S03_Install.MD) | A jour (S07) |
| Client | [lien](./S02/S02_Install.md) | À jour (S07) |
| GPO | [lien](./S03/S03_User_Guide.md) | À jour (S07) |
| Ajout d'utilisateur AD | [lien](./S03/S03_User_Guide.md) | À jour (S07) |
| Routeur VyOS | [lien](./S04/S04_Install.md) | A jour (S07) |
| PfSense | [lien](./S04/S04_Install.md) | À jour (S09) |
| Mise en place du stockage avancé | [lien](./S05/S05_Install.md) | A jour (S07) |
| Serveur de fichier | [lien](./S06/S06_Install.md) | A jour (S07) |
| Configuration GrayLog | [lien](./S06/S06_Install.md) | A jour (S07) |
| Configuration PRTG | [lien](./S06/S06_Install.md) | A jour (S07) |
| GPO Télémétrie et restriction horaire | [lien](./S06/S06_User_Guide.md) | À jour (S07) |
| Utilisation PRTG| [lien](./S06/S06_User_Guide.md) | À jour (S07) |
| Dashboard PfSense | [lien](./S06/S06_User_Guide.md) | À jour (S07) |
| Serveur de sauvegarde | [lien](./S06/S06_User_Guide.md) | À jour (S07) |
| Serveur de messagerie | [lien](./S07/S07_Install.md) | À jour (S07) |
| Modification liste RH | [lien](./S07/S07_Install.md) | À jour (S07) |
| Transfert des rôles FSMO | [lien](./S08/S08_Install.md) | À jour (S08) |
| Bureau à distance - SSH | [lien](./S08/S08_UserGuide.md) | À jour (S08) |
| Serveur de mots de passe | [lien](./S07/S07_Install.md) | À jour (S08) |
| Transfert des rôles FSMO | [lien](./S08/S08_Install.md) | À jour (S08) |
| Rangement des PC dans les OU | [lien](./S08/S08_Install.md) | À jour (S08) |
| Serveur WSUS | [lien](./S08/S08_Install.md) | À jour (S09) |
| Serveur Téléphonie | [lien](./S08/S08_Install.md) | À jour (S09) |
| Serveur Web | [lien](./S09/S09_Install.md) | À jour (S09) |
| VPN avec PharmGreen | [lien](./S09/S09_Install.md) | À jour (S09) |
| Relation d'approbation avec PharmGreen | [lien](./S09/S09_Install.md) | À jour (S09) |
| Audit Windows avec PurpleKnight | [lien](.S10/S10_Install.md) | À jour (S10) |
| Audit Linux avec Lynis | [lien](./S10/S10_Install.md) | À jour (S10) |

## Fichiers d'utilisation pour les utilisateurs
| Sujet | Lien | État |
| :--: | :--: | :--: |
| Connexion à un compte utilisateur| [lien](./S07/S07_UserGuide.md) | À jour (S07) |
| Ticket d'incident | [lien](./S03/S03_User_Guide.md) | À jour (S07) |
| Utilisation de la messagerie | [lien](./S07/S07_UserGuide.md) | À jour (S07) |
| Utilisation du stockage partagé | [lien](./S06/S06_User_Guide.md) | À jour (S11) |
| Utilisation du serveur web | [lien](./S09/S09_UserGuide.md) | À jour (S11) |



## 1- Présentation du projet, objectifs finaux
L'objectif de ce projet est de créer un réseau pour une entreprise en partant d'une base plutôt vide. Nous devrons donc : 
- Définir les besoins
- Sélectionner les équipements
- Planifier la topologie du réseau
- Configurer les paramètres du réseau
- Installer les équipements
- Tester et sécuriser le réseau
- Gérer et maintenir le réseau

## 2- Introduction : mise en contexte
Nous sommes une équipe de 4 techniciens Système et Réseau, qui venont d'être embauchés par la start-up Ekoloclast, dans le but de créer un réseau interne.  
**Ekoloclast** est une entreprise innovante, fondée en 2022, dans le 8ème arrondissement de Paris. Elle a pour ambition de révolutionner l'approche de l'écologie.   
Son fondateur aspire à introduire des pratiques, produits et services écologiques novateurs qui bénéficient à la fois à l'environnement et aux individus.   
Elle est orientée vers les marchés professionnels (B2B) et consommateurs (B2C).  
La société comprend actuellement 187 personnes réparties dans 10 départements.    
  

## 3- Les 12 Sprints
### Le Sprint 1 - 18/11/2024 au 24/11/2024

| Équipe   | Rôle   | Planification des sprints | Schéma du réseau | Convention de nommage | Table de routage | Liste de matériels |
| :--: | :--: | :--: | :--: | :--: | :--: | :--: |
| | | Principal | Principal | Secondaire | Secondaire | Secondaire |
|  Lamine  | Membre | X | X |  |  |  |
| Baudouin | Membre | X | X |  |  | X |
| Charlène |   PO   | X |  | X | X | |
| Anthony  |   SM   | | | X | X | |
| | | 100% le 20/11 | 100% le 21/11 | 100% le 20/11 | 75% au 22/11 | 25% au 22/11 |

Nous avons fait le choix de créer une VLAN par département et de les relier par un Switch 3L.   
Nous avons eu quelques difficultés à écrire une planification des futurs sprints car cela a nécessité de nombreuses recherches. Le résultat se trouve [ici](Ressources/S01_PlanificationSprint.csv).  

### Le Sprint 2 - 25/11/2024 au 01/12/2024

| Équipe   | Rôle   | Création d'un domaine AD | Gestion de l'aborescence AD | Création d'une VM cliente | Table de routage | Liste de matériels | Intégration des utilisateurs AD |
| :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: |
| | | Principal | Principal | Principal | Secondaire | Secondaire | Secondaire |
|  Lamine  | SM |  | X | X |  |  |  |
| Baudouin | PO | X |  |  | | X |  |
| Charlène | Membre |  |  |  | X |  | X |
| Anthony  | Membre | X | X |  |  | |  |
| | | 100% le 27/11 | 100% le 27/11 | 100% le 28/11 | 100% le 26/11 | 100% le 28/11 | 25% au 29/11 |

Nous avons eu des difficultés à connecter les serveurs et le client, principalement à cause du DHCP. Nous avons donc créé une plage d'adresses IP temporaires sur la VLAN 255, en attendant la mise en place du routeur.  Nous avons également eu des problèmes d'horloge entre les deux serveurs. Le problème revient occasionnellement lors du démarrage des serveurs : les serveurs restent maintenant allumés en continu.   

### Le Sprint 3 - 02/12/2024 au 08/12/2024

| Équipe   | Rôle   | GPO de sécurité - Création | GPO standard - Création | Intégration des utilisateurs AD | Serveur de gestion de parc - Installation de GLPI | Création d'un 2e AD Core | Mettre en place un routeur VyOS |
| :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: |
| | | Principal | Principal | Principal | Secondaire | Secondaire | Secondaire |
|  Lamine  | PO |  |  |  |  |  |  |
| Baudouin | SM |  |  |  | X | X |  |
| Charlène | Membre | X |  | X |  |  |  |
| Anthony  | Membre |  | X |  |  | | X |
| | | 100% le 05/12/2024 | 100% le 05/12 | 100% le 03/12 | 75% au 06/12 | 0% au 06/12 | 25% au 06/12 |

La synchronisation des différentes GPO a pris plus de temps que nous ne l'avions prévu. Cela a ainsi retardé la configuration du serveur GLPI et empêché l'installation d'un troisème serveruAD.

### Le Sprint 4 - 09/12/2024 au 15/12/2024

| Équipe   | Rôle   | Gestion d'un firewall pfSense | Serveur de gestion de parc - Installation de GLPI  | Création d'un 2e AD Core | Mise en place d'un routeur VyOS |
| :--: | :--: | :--: | :--: | :--: | :--: |
| | | Principal | Principal | Secondaire | Secondaire |
|  Lamine  | Membre |  |  |  |  |
| Baudouin | Membre |  | X |  |  |
| Charlène | SM | X |  |  | X |
| Anthony  | PO | | X | X |  |
| | | 50% au 12/12 | 100% le 11/12 | 25% au 12/12 | 75% au 12/12 |

La configuration des VLAN et du trunk des routeurs VyOS n'a pas été faite. Les règles de pare-feu n'ont pas pu être testé car nous avons un problème dans la configuration des routeurs.  

### Le Sprint 5 - 16/12/2024 au 22/12/2024

| Équipe   | Rôle   | Gestion d'un firewall pfSense | Création d'un 2e AD Core | Mise en place de deux routeurs VyOS | Mise en place du RAID 1 sur un serveur | Mise en place des dossiers réseaux | GPO Télémétrie | Mise en place de LAPS | GPO Restriction d'utilisation | Déplacement automatique des PC dans les OU |
| :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: |
| | | Principal | Secondaire | Principal | Principal | Principal | Secondaire | Secondaire | Secondaire | Optionnel |
|  Lamine  | Membre |  |  |  |  |  |  |  |  |  |
| Baudouin | Membre |  |  |  | X | X | X |  | X |  |
| Charlène | PO | X |  | X |  |  |  | X |  |  |
| Anthony  | SM |  | X |  | X | X |  |  |  |  |
| | | 100% le 18/12 | 25% au 19/12 | 100% le 17/12 | 100% le 17/12 | 25% au 22/12/2024 |  | 75% au 22/12/2024 |  |  |

Nous avons un problème de SID avec le Windows Server Core. Cela a entrainé une panne de notre Active Directory. Nous avons donc effacé et recréé trois nouveaux serveurs AD.

### Le Sprint 6 - 02/01/2025 au 10/01/2025

| Équipe   | Rôle  | Sauvegarde de données | Nouveau fichier utilisateurs | Surveillance du pare-feu pfsense | Gestion des logs centralisée | Supervision de l'infrastructure réseau | Mise en place des dossiers réseaux | GPO Télémétrie | Mise en place de LAPS | GPO Restriction d'utilisation | Déplacement automatique des PC dans les OU |
| :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: |
| | | Principal | Secondaire | Secondaire | Secondaire | Principal | Principal | Secondaire | Secondaire | Secondaire | Optionnel |
|  Lamine  | SM |  |  |  |  | X |  |  |  |  | |
| Baudouin | PO |  |  |  | X |  |  | X |  |  |  |
| Charlène | Membre |  | X | X |  |  | X |  | X | X | X |
| Anthony  | Membre | X |  |  |  |  | X |  |  |  | |
| | | 50% au 10/01 | 50% au 10/01 | 100% au 07/01 | 75% au 10/01 | 100% au 09/01 | 100% le 05/01 | 100% le 06/01 | 100% le 06/01 | 100% le 06/01 | 75% au 10/01 |

Pour le serveur PRTG, nous avons choisi le protocole SNMP car il est multi-OS. Nous n'avons pas encore réussi à déployer SNMP sur une Débian.  
Le serveur de sauvegarde Saloa devait être un Bareos, mais suite à trop de complications, nous avons migré sur un Samba. Cela a retardé notre avancée dans cet objectif principal.  

### Le Sprint 7 - 11/01/2025 au 17/01/2025

| Équipe   | Rôle  | Sauvegarde de données | Nouveau fichier utilisateurs | Gestion des logs centralisée | Mise en place d'un serveur de messagerie | Mise en place gestion des mdp | Installation suivi de projet | Déplacement automatique des PC dans les OU |
| :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: |
| | | Principal | Secondaire | Secondaire | Principal | Secondaire | Optionnel | Optionnel |
|  Lamine  | PO |  |  |  |  | X |  |  |
| Baudouin | Membre |  |  | X |  |  |  |  |
| Charlène | SM |  | X |  | X |  |  |  |
| Anthony  | Membre | X |  |  |  |  |  |  |
| | | 100% le 16/01 | 100% au 17/01 | 100% le 15/01 | 100% le 15/01 | 75% au 17/01 | 0% au 16/01 | 75% au 17/01 |

Nous avons choisi iRedMail et Thunderbird pour leur Open Source et leur popularité.  Nous n'avons pas réussi à ajouter l'AD à iRedMail suite à de nombreuses erreurs LDAP.   

### Le Sprint 8 - 18/01/2025 au 24/01/2025

| Équipe   | Rôle  | Transfert des rôles FSMO | Mise en place serveur WSUS | Gestion des connexions à distance | Mise en place d'un serveur FreePBX | Mise en place gestion des mdp | Installation suivi de projet | Déplacement automatique des PC dans les OU |
| :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: |
| | | Principal | Principal | Secondaire | Secondaire | Secondaire | Optionnel | Optionnel |
|  Lamine  | Membre |  |  | X |  | X |  |  |
| Baudouin | SM |  | X | X |  |  |  |  |
| Charlène | PO | X |  |  |  |  |  | X |
| Anthony  | Membre |  |  |  | X |  | X |  |
| | | 100% le 20/01 | 75% au 24/01 | 100% le 23/01 | 75% au 24/01 | 100% le 21/01 | 100% le 21/01 | 100% le 21/01 |

 Nous avons des erreurs concernant le serveur RPC. Nous n'avons pas encore réussi à les résoudre. Cela a peut être engendré les erreurs sur Passbolt, qui n'arrive plus à envoyer des mails par notre serveur SMTP.  

 ### Le Sprint 9 - 25/01/2025 au 31/01/2025

| Équipe   | Rôle  | Mise en place serveur WSUS | Mise en place d'un serveur FreePBX | Mise en place d'un serveur Web | VPN site à site | PARTENARIAT D'ENTREPRISE - Active Directory | PARTENARIAT D'ENTREPRISE - Stockage | 
| :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: |
| | | Principal | Principal | Secondaire | Principal | Secondaire | Optionnel |
|  Lamine  | SM |  |  | X |  |  | X |
| Baudouin | Membre | X |  |  |  | X |  |
| Charlène | Membre | |  | X | X |  | X |
| Anthony  | PO | X | X |  |  | X | |
| | | 100% le 29/01 | 100% le 30/01 | 100% le 30/01 | 100% le 29/01 | 100% le 30/01 |  |

Notre société entame un partenariat avec l'entreprise Pharmgreen.  

 ### Le Sprint 10 - 01/02/2025 au 07/02/2025

| Équipe | Rôle  | Audit SERVEURS LINUX - Utilisation de Lynis | Audit ACTIVE DIRECTORY - Utilisation de Purple Knight  | Mise en place d'un PC d'administration | SERVEUR RADIUS - Utilisation de Free Radius | PARTENARIAT D'ENTREPRISE - Stockage | 
| :--: | :--: | :--: | :--: | :--: | :--: | :--: |
| | | Secondaire | Principal | Principal |  Optionnel | Optionnel |
|  Lamine  | PO | X |  |  |  | X |
| Baudouin | Membre |  | X |  | X |  |
| Charlène | Membre | X |  | X |  | X |
| Anthony  | SM |  | X |  |  | X | |
| | | 100% le 05/02 | 100% le 05/02 | 100% le 04/02 | |  |

 ### Le Sprint 11 - 08/02/2025 au 14/02/2025

| Équipe | Rôle  |  SÉCURITÉ - Utilisation d'un IDS/IPS et d'une machine d'attaque | SERVEUR RADIUS - Utilisation de Free Radius | PARTENARIAT D'ENTREPRISE - Stockage | 
| :--: | :--: | :--: | :--: | :--: |
| | | Optionnel |  Optionnel | Optionnel |
|  Lamine  | Membre | X |  |  |
| Baudouin | PO |  | X |  |
| Charlène | SM |  |  | X |
| Anthony  | Membre |  | X |  |
| | | |  |  |

### Le Sprint 12 - 15/02/2025 au 21/02/2025
Ce sprint est destiné à finaliser ce projet. Les derniers objectifs ne seront pas réalisés.  

## 4- Améliorations possibles

Nous voyons beaucoup d'améliorations possible :  
- retablir le serveur de mots de passe
- finir les trois objectifs restants (IDS, Radius et stockage partagé avec Pharmgreen)
- augmenter le score d'audit
- finir le VPN d'accès à distance
- améliorer le syteème GLPI (template)   

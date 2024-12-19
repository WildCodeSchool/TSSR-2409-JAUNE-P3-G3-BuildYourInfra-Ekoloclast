# TSSR-2409-JAUNE-P3-G3-BuildYourInfra-Ekoloclast

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
| | | 100% le 18/12 | 25% au 19/12 | 100% le 17/12 | 100% le 17/12 |  |  |  |  |  |

Nous avons un problème de SID avec le Windows Server Core.


## 4- Améliorations possibles

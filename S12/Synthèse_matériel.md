| ID | Nom matériel dans la GUI proxmox | Nom matériel dans la machine | Type | OS | Fonction | Carte Réseau | IP | Nombre de disques | Taille Totale (en GO) | Espace libre (en GO) | Espace libre (en %) | RAM totale (en GO) | RAM utilisée (en %) | 
| :--: | :--: | :--: |:--: | :--: | :--: |:--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: |
| 610 | Johora | Johora  | CT| Debian | serveur de Journalisation | 625 | 172.24.255.10/24 | 1 | 31.20 | 1.6 | 5.18 |8 | 66.86  |  
| 611| Manakin | Manakin | CT|  Debian| serveur de messagerie |625|172.24.255.7/24 | 1 | 15.58 | 10.5 | 68 | 4 | 58.75 |  
 | 613 | Tigre | Tigre |CT | Debian |  serveur de téléphonie| 625 |172.24.255.11/24| 1 |9.75  | 2 |20.53  | 2 |  30|  
| 614 | Wombat | Wombat | CT |  Debian| serveur web | 625 |172.24.254.1/24|  1|  7.78|  6.63|  87.25| 1 |  5.67|  
|  620|  G3-PfSense | PfSense | VM| FreeBSD | Pare-feu| 1,625,640 |10.0.0.2/30,172.24.50.2/30, 172.24.254.254/24 | 1 | 7.4 | 6.5 |88  |  2|  45.32|  
| 621 |G3-PfSense-Backup|  | |  |  |  |  |  |  |  |  |  |  |  
| 622 |G3-routeur2-Backup  |  | |  |  |  |  |  |  |  |  |  |  |  
| 623 |G3-routeur3-Backup  |  | |  |  |  |  |  |  |  |  |  |  |  
| 624 |G3-Anolis  |Anolis  |VM | WindowsServer-2022-core | serveur AD (SCHEMA MASTER)|625  |  172.24.255.3/24  | 1 |  32|  |  | 2 |49.15|
| 625 |G3-Addax  |Addax  |VM |WindowsServer-2022|serveur AD principal|  625  |172.24.255.2/24 | 1 | 32 |  | |2  |39.21  |
|  626| G3-Axolotl |Axolotl  |VM |  WindowsServer-2022-core  |serveur AD (RID MASTER)  |625|172.24.255.1/24 | 1 | 31.3 |14.5  | 46.3 |  2|64.17  |
|627 | G3-Fuligule | Fuligule |VM |Windowsserver2022|  serveur de fichiers| 625 |172.24.255.8/24 | 1 | 31.3 |13.8  |  44|  4| 59.25 |  
| 628 |G3-Saola  |Saola  |VM |Debian  |serveur de sauvegarde  |625  |172.24.255.4/24 | 1 |32  |26  | 89 |  4| 39 |  
|  629| G3-Wallaby | Wallaby |VM | Windowsserver2022 | Serveur WSUS | 625 |172.24.255.4/24| 1 | 32 |15  |47  | 4 |  60.86|  
| 630 |G3-P0655  |  P0655| VM| Windows 10 Pro | PC client |625  |  172.24.2.50   |1  |50  | 5 |10  | 8 | 90.93 |
| 634 | G3-P0020 |  P0020|VM |Windows 10 Pro| PC client |  625|172.24.16.50 | 1 |49.4 | 7.18 |14.5  | 8 | 90.58 |  
| 635 | G3-routeur3|vyos|VM|vyos 1.5 |Routeur ||172.24.X.253(X allant de à 1 à 9),10.0.1.6 |  |  1|  3.7 | 1.8 | 51 |  2| 17.5 |  
|636 | G3-Galago|Galago |VM |Debian |Serveur GLPI|625 | 172.24.255.6/24 | 1|31 | 26|88 | 2|41.74|
|637 | G3-routeur2| vyos |VM |vyos 1.5 |Routeur ||10.0.1.1,10.0.1.5,172.24.255.253/24,172.24.16.253/24| | 1| 3.7|1.8 | 51| 2|18.3 |
|639 | G3-P001|P0001 |VM |Windows 10 Pro| Supervision |625 | 172.24.16.252 | 1| 49,4|11.7 |23|8|90.5 |

# Convention de nommage Ekoloclast 

## 1. Le domaine
Le **domaine** s'appelle "eko.lan" et le nom NETBIOS est "EKO".  
Dans le but de prévoir l'acquisition d'autres succursales, les différents **sous-domaines** seront nommés avec le nom de ville.  
Dans le cas actuel, le seul sous-domaine sera "paris.eko.lan".  

## 2. Les OU
L'architecture **OU** sera :  
- (OU) Serveurs  
- (OU) Ordinateurs  
	- (OU) Paris  
		- (OU) OrdinateursFixes  
		- (OU) OrdinateursPortables  
- (OU) Utilisateurs  
	- (OU) Extérieur 
	- (OU) Paris  
		- (OU) DSI  
		- (OU) Communication   
		- (OU) DirectionFinanciere  
		- (OU) DirectionGénérale  
		- (OU) DirectionMarketing
		- (OU) R&D  
		- (OU) RH  
		- (OU) ServiceGénérauc  
		- (OU) ServiceJuridique  
		- (OU) VentesEtDéveloppementCommercial  
- (OU) Administrateurs  
	- (OU) Paris  
	
## 3. Les groupes de sécurité
Les **groupes de sécurité** seront nommés du type "Grp"+Cible (User/Computer/Server/Admin)+"_"+Particularité.  

Par exemple, le groupe servant à gérer les managers sera "GrpUser_Manager".  
Celui pour gérer l'installation des logiciels des ordinateurs du service Communication sera "GrpComputer_SoftwareCommunication".  

Les employés seront dans des groupes locaux. La direction sera dans un groupe global. Les Administrateurs seront dans un groupe universel.  

## 4. Les ordinateurs
Les **ordinateurs clients** seront nommés avec la première lettre de la ville de localisation suivie de 4 chiffres.  
Les ordinateurs de Ekoloclast-Paris sont déjà nommés (par exemple P0064).  

Les **serveurs** seront nommés d'après un animal en danger d'extinction, la première lettre correspondra au rôle principal du serveur.  
Par exemple, Addax pour un serveur AD ou Saola pour un serveur SMTP.

## 5. Les utilisateurs
Les noms de compte **utilisateur** seront au format "Nom de famille (en retirant les espaces/tirets/apostrophe)"+"."+"3 premières lettres du prénom". Si ce nom est déjà utilisé, un chiffre sera ajouté à la suite.
Par exemple, Jean-Pierre De La Fontaine aura le nom de compte "delafontaine.jea" et le prochain Jean-Pierre de la Fontaine aura "delafontaine.jea1".

## 6. Les GPO
Chaque **GPO** doit commencer soit par "U_", si elle utilise la configuration User, soit par "C_", si elle utilise la configuration Computer.  
Ensuite, elle doit comporter le sujet de la GPO : Security, Settings, Software, ...  
Puis la cible de la GPO : Computer, User, Marketing, ...  
Et enfin des précisions, par exemple le nom du paramètre changé, du logiciel, de la règle instaurée, ...  

On aura donc, par exemple, C_Security_Computer_FirewallEnabled ou encore U_Settings_Manager_AccessPlanning.  






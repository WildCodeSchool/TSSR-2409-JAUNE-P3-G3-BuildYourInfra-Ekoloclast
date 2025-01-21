# Ekoloclast
## Connexion à son compte utilisateur

Votre login de connexion est le nom de famille que vous avez fourni à votre arrivée, sans les caractères spéciaux ni espace, suivi d'un point et des trois premières lettres de votre prénom.  
Par exemple, Jean-René Du Pré sera "dupre.jea".  
Votre mot de passe initial est Azerty1*. Vous devez le changer immédiatement pour un mot de passe plus sécurisé : u moins 9 caractères dont des caractères spéciaux. Il sera changé tous les 90 jours maximum et ne pourra pas être réutilisé.  
Vous pouvez vous renseigner aux bonnes pratiques à ce [lien](https://www.cybermalveillance.gouv.fr/tous-nos-contenus/bonnes-pratiques/mots-de-passe). 


## Utilisation du service de messagerie
Sur le bureau, se trouve le raccourci de Thunderbird.  
Pour se connecter, il faut rentrer son nom complet et entrer son adresse mail (votre identifiant de connexion suivi de @eko.lan).  
Le mot de passe initial est le même que le mot de passe initial de votre compte.  
Il est fortement recommandé de le changer pour un mot de passe fort et sécurisé.

Si le serveur n'est pas détecté, rentrer les mêmes informations que ci-dessous :  
![Thunderbird](/Ressources/S06_Thunderbird1.png)  
Selectionner "Confirmer l'exception de sécurité".   
![Thunderbird](/Ressources/S06_Thunderbird2.png)

Vous pouvez également vous connecter à l'adresse **http://manakin/mail** si vous souhaitez accèder à vos mails sur un compte qui n'est pas le votre.  
Cela n'est pas recommandé.  

## Les bonnes pratiques de la messagerie 
- Ne pas faire du stockage “longue durée” des emails.  
- Faire régulièrement le tri des emails et supprimer ceux qui ne sont plus nécessaires.  
- Utiliser des dossiers pour classer les emails par catégorie.  
- Ne pas garder d'emails sensibles ou confidentiels dans la BAL.  
- Sauvegarder régulièrement les emails importants pour éviter toute perte de données en cas de panne ou de suppression accidentelle.  
- Utiliser des mots de passe forts et uniques.  
- Être vigilant au contenu des emails : Pièces jointes et Liens.  
- Faire attention aux emails non sollicités (spam) et les messages provenant d'expéditeurs inconnus.
- Utiliser une adresse électronique professionnelle pour les communications d'entreprise.  
- Éviter d'envoyer des informations sensibles par courrier électronique.  
- Vérifier la liste des destinataires avant d'envoyer un email.
- Respecter la politique de courrier électronique de l’entreprise.  
- Éviter d'utiliser des termes inappropriés ou offensants dans les courriels professionnels.  
- Utiliser le courrier électronique de manière efficace et efficiente.  

# Configuration de passbolt

Avant de pouvoir utiliser l'application, vous devez la configurer. Dirigez votre navigateur vers le nom d'hôte / ip où passbolt peut être atteint. Vous accéderez à une page de démarrage.

![image](/Ressources/s07_image003.png)

La première page de l'assistant vous dira si votre environnement est prêt pour le boulon de passe. Résolvez les problèmes le cas échéant et cliquez sur "Démarrer la configuration" lorsque vous êtes prêt.


![image](/Ressources/s07_image3.png)

### 2.1 Base de données

Cette étape consiste à dire à passbolt quelle base de données utiliser. Entrez le nom d'hôte, le numéro de port, le nom de la base de données, le nom d'utilisateur et le mot de passe.

![image](/Ressources/s07_image4.png)

### 2.2 Clé GPG

Dans cette section, vous pouvez générer ou importer une paire de clés GPG. Cette paire de clés sera utilisée par l'API passbolt pour s'authentifier pendant le processus de poignée de main de connexion. Générez une clé si vous n'en avez pas.

![image](/Ressources/s07_image5.png)

### 2.3 Serveur de messagerie (SMTP)

À ce stade, l'assistant vous demandera d'entrer les détails de votre serveur SMTP.

![image](/Ressources/s07_image6.png)

Vous pouvez également tester que votre configuration est correcte en utilisant la fonction de test de messagerie à droite de votre écran. Entrez l'adresse e-mail à laquelle vous souhaitez que l'assistant vous envoie un e-mail de test et cliquez sur "Envoyer un e-mail de test".

![image](/Ressources/s07_image7.png)

### 2.4 Préférences

L'assistant vous demandera ensuite quelles préférences vous préférez pour votre instance de boulon. Les valeurs par défaut recommandées sont déjà pré-remplies, mais vous pouvez également les modifier si vous savez ce que vous faites.

![image](/Ressources/s07_image8.png)

### 2.5 Création première utilisateur

Vous devez créer le premier compte d'utilisateur administrateur. Ce premier utilisateur d'administration est probablement vous, alors entrez vos coordonnées et cliquez sur suivant.

![image](/Ressources/s07_image9.png)

### 2.6 Installation

Votre compte utilisateur est maintenant créé. Vous verrez une page de redirection pendant quelques secondes, puis vous serez redirigé vers le processus de configuration de l'utilisateur afin que vous puissiez configurer votre compte utilisateur.

![image](/Ressources/s07_image10.png)

### 2.7 Création nouvelle clé pour compte administrateur

Passbolt vous demandera de créer ou d'importer une clé qui sera utilisée plus tard pour vous identifier et crypter vos mots de passe. Votre clé doit être protégée par un mot de passe. Choisissez-le judicieusement, il sera le gardien de tous vos autres mots de passe.

![image](/Ressources/s07_image11.png)


### 2.8 Téléchargez votre kit de récupération

Cette étape est essentielle. Votre clé est le seul moyen d'accéder à votre compte et à vos mots de passe. Si vous perdez cette clé (en cassant ou en perdant votre ordinateur et en n'ayant pas de sauvegarde par exemple), vos données cryptées seront perdues même si vous vous souvenez de votre phrase secrète.

![image](/Ressources/s07_image12.png)


### 2.9 Définissez votre jeton de sécurité

Choisir une couleur et un jeton à trois caractères est un mécanisme de sécurité secondaire qui vous aide à atténuer les attaques de phishing. Chaque fois que vous effectuez une opération sensible sur le boulon de passage, vous devriez voir ce jeton.

![image](/Ressources/s07_image13.png)


Votre compte administrateur est configuré. Vous serez redirigé vers la page de connexion de passbolt. 

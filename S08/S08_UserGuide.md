## Utiliser le bureau à distance sur un Windows 10 ou Windows serveur 2022.
### Dans un premier temps, on va activer le bureau à distance :
- Aller dans Start  > Settings  > System > Remote Desktop, puis activez Activer "Enable Remote Desktop".
- Une Foix activée, taper dans la barre de recherche de Windows « Remote Desktop ».

### Sur le Remote Desktop Connection :
- Faire "Show Options" pour afficher toute la page.
- Sur le Remote Desktop Connection faire « Show Options » pour afficher toute la page.

![Remote](/Ressources/S08_Remote_Desktop.png)

Remarque : pour se connecter à distance, il faut avoir un compte avec les droits d’administrateur.
- Sure la partie « computer » il faut mettre le nom du PC ou du Serveur que vous voulez atteindre.
- Exemple : Axolotl.eko.lan ou Axolotl (fonctionne aussi).
- Sure la partie « User name » il faut mettre le domaine\le compte pour se connecter.
- Exemple : EKO\administrator


## Prendre le contrôle d'un serveur via SSH

Dans un premier temps rendez-vous dans le fichier `sshd_config` en faisant `nano /etc/ssh/sshd_config`.

Une fois dedans,il faudra faire les modifications comme sur la capture d'écran ci-dessous.


Vous pouvez désormais prendre le contrôle de votre machine serveur.


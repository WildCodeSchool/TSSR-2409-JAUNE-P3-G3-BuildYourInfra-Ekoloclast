
## **Installation de Purple knight**

1. **Téléchargement**  
    - Rendez-vous sur le site officiel de **Semperis** et télécharge Purple Knight  [Lien officiel](https://www.purple-knight.com/)
    - Une fois le lien de téléchargement reçu par mail. Télécharger le fichier ZIP et extrait sur la machine.

2. **Installation**
    - Ouvrez le fichier décompresser et lancé `PurpleKnight.exe`.
    - Une erreur va apparaître, lancée PowerShell en mode Administrateur.
    - La commande pour Débloquer :

    `dir -Path (chemin du fichier) -Recurse | Unblock-file`
    - Une fois fait, lance une autre commande pour enlever la restriction :

    `Set-executionpolicy -executionpolicy unrestricted`
    - Puis fait `y`
    - Relance le fichier d'installation et Suivez les instructions d’installation.

3. **Exécution du scan**
    - Ouvrez **Purple Knight** en tant qu’administrateur.
    - Connectez-vous à votre **Active Directory**.
    (Image)
    - Lancez un **scan** pour identifier les vulnérabilités.

4. **Analyse des résultats**
     - Une fois le scan terminé, Purple Knight génère un **rapport** avec des recommandations pour corriger les vulnérabilités.

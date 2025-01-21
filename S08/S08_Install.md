 # Ekoloclast

 ## Transfert des rôles FSMO
Sur le serveur AD principal, Addax, lancer ``ntdsutil.exe`` et entrer ``role``.

Pour transférer le rôle de **RID Master** :
```
Connections
Connect to server axolotl
q
transfer RID master
```
Puis cliquer sur "Yes" dans la fênetre qui s'ouvre.  
![Visuel transfert RID](/Ressources/S08_TransfertRID.png)

Pour transférer le rôle de **Schema Master** :
```
Connections
Connect to server anolis
q
transfer schema master
```
Puis cliquer sur "Yes" dans la fênetre qui s'ouvre.  
![Visuel transfert schema](/Ressources/S08_TranfertSchema.png)

Pour vérifier que les rôles sont bien répartis, dans une invite de commande, taper ``netdom query /Domain:eko.lan FSMO``.  
Le résultat devrait être comme sur l'image ci-dessous :  
![Vérification transfert](/Ressources/S08_TransfertVerification.png)


---

## Placement Automatique des PC dans les bonnes OU

Il faut créer une nouvelle OU : **PCEnAttente**. Cela sera la place des PC dont le nom ne figure pas ddans la liste des PC connus. Il faudra donc aller régulièrement vérifier. 

Il faut télécharger ce [script](/Ressources/S08_ScriptPlacementPC.ps1) et le placer dans le dossier "Script" sur Addax.  

Il faut ensuite créer une tache dans **Task Scheduler** qui se lance quotidiennement à 3h00, en lancant le programme "Powershell" , en option "C:\Script\S08_ScriptPlacementPC.ps1".  

Le script range automatiquement les PC autorisés dans l'OU PC portable dans l'OU Paris. Cela sera à modifier en cas de changement de l'infrastructure.  

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




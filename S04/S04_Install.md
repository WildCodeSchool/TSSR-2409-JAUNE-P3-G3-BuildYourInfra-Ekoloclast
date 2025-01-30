# Ekoloclast

## Configuration des deux routeurs VyOS

### Création des routeurs Vyos
- Créer deux clones du template Vyos.  
- Ajouter deux processeurs et 2Go de RAM.  
- Ajouter trois cartes réseaux à Routeur2 et dix cartes réseaux à Routeur3. 
- Changer les mots de passe administrateur grâce à ``set system login user vyos authentication plaintext-password Azerty1*``.  

### Configuration de Routeur2

- Entrer dans le mode configuration grâce à la commande ``config``  
- Configurer tout d'abord les adresses IP des interfaces :
```
set interface ethernet eth0 address 172.24.50.1/30  
set interface ethernet eth0 description "Lien Pare-feu"  
set interface ethernet eth1 address 172.24.50.5/30  
set interface ethernet eth1 description "Lien Routeur"  
set interface ethernet eth2 address 172.24.255.253/24  
set interface ethernet eth2 address 172.24.16.253/24  
set interface ethernet eth2 description "VLANS 255 et 16"  
commit  
save  
exit  
```

Pour vérifier, taper la commande  ``show interface`` et le résultat devrait être comme l'image suivante.  
![Routeur2](/Ressources/S05_Vyos_R3_Interface.png)  

- Configurer ensuite les routes, toujours dans le mode configuration :
```
set protocols static route 172.24.0.0/20 next-hop 172.16.50.6  
set protocols static route 0.0.0.0/0 next-hop 172.16.50.2  
commit  
save  
exit  
```

Pour vérifier, taper la commande  ``show ip route`` et le résultat devrait être comme l'image suivante.  
![Routeur2 Route](/Ressources/S05_Vyos_R2_Route.png)  

### Configuration de Routeur3

- Entrer dans le mode configuration grâce à la commande ``config``  
- Configurer tout d'abord les adresses IP des interfaces :

```
set interface ethernet eth0 address 172.24.50.6/30  
set interface ethernet eth0 description "Lien Routeur"  
set interface ethernet eth1 address 172.24.1.253/30  
set interface ethernet eth1 description "VLAN 1"  
set interface ethernet eth2 address 172.24.2.253/24
set interface ethernet eth2 description "VLAN 2"  
set interface ethernet eth3 address 172.24.3.253/24  
set interface ethernet eth3 description "VLAN 3"  
set interface ethernet eth4 address 172.24.4.253/24  
set interface ethernet eth4 description "VLAN 4"  
set interface ethernet eth5 address 172.24.5.253/24  
set interface ethernet eth5 description "VLAN 5"  
set interface ethernet eth6 address 172.24.6.253/24 
set interface ethernet eth6 description "VLAN 6"  
set interface ethernet eth7 address 172.24.7.253/24  
set interface ethernet eth7 description "VLAN 7"  
set interface ethernet eth8 address 172.24.8.253/24  
set interface ethernet eth8 description "VLAN 8"  
set interface ethernet eth9 address 172.24.9.253/24  
set interface ethernet eth9 description "VLAN 9"  
commit  
save  
exit
```

Pour vérifier, taper la commande  ``show interface`` et le résultat devrait être comme l'image suivante.  
![Routeur3](/Ressources/S05_Vyos_R3_Interface.png)  

- Configurer ensuite les routes, toujours dans le mode configuration :
```
set protocols static route 0.0.0.0/0 next-hop 172.16.50.5  
commit  
save  
exit  
```

Pour vérifier, taper la commande  ``show ip route`` et le résultat devrait être comme l'image suivante.  
![Routeur3_Route](/Ressources/S05_Vyos_R3_Route.png)  

### FAQ
Vyos ne trouve pas une interface réseau.  
-> Vérifiez dans ``/etc/config/config.boot`` qu'elle est bien présente et la rajouter si non. Puis redémarrer.  

Il y a une route en trop.  
-> ``delete protocols static route xx.xx.xx.xx/xx``

Il y a une adresse IP en trop.  
-> ``delete interface ethernet ethx address xx.xx.xx.xx/xx``

___

## Configuration du pare-feu PfSense
Sur une machine clonée du Template PfSense, dotée de trois cartes réseaux (vmbr1, vmbr625 et vmbr640) :


- Configurer les trois interfaces en suivant l'image ci-dessous :  
  ![PfSense Interface](/Ressources/S05_PfSense_Interface.png)  

- Se connecter en GUI sur une autre machine qui est sur le réseau d'une des interfaces, en tapant l'adresse de l'interface en question.  

- Changer le mot de passe administrateur en cliquant sur l'encart rouge.  

- Configurer une passerelle pour la LAN de manière à obtenir :  
  ![PfSense Passerelle](/Ressources/S05_PfSense_Passerelle.png)  

- Configurer les routes statiques : 
  ![PfSense Route statique](/Ressources/S05_PfSense_RouteStatique.png)  

- Configurer les alias :  
  ![PfSense Alias](/Ressources/S05_PfSense_Alias.png)
  ![PfSense Alias](/Ressources/S05_PfSense_AliasAD.png)

- Configurer les règles des trois interfaces : 
  ![PfSense LAN](/Ressources/S05_PfSense_LAN.png)  
  ![PfSense WAN](/Ressources/S05_PfSense_WAN.png)  
  ![PfSense DMZ](/Ressources/S05_PfSense_DMZ.png)  

- Appliquer les changements.  



# Variable 
$DomainDN = (Get-ADDomain).DistinguishedName
$ListPC= Import-CSV -Path "C:\Script\S06_ListeEmployes.csv" -Delimiter ";"  -Header "civilité","Prenom","Nom","Société","Site"`
    ,"Département","Service","Fonction","ManagerPrenom","ManagerNom","PC","DateNaissance","Telfixe","Telportable","Nomadisme"`
    | Select-Object "PC" # Document à changer

# Source et destination des OU
$OUinitial = "CN=Computers,$DomainDN"
$OUdefinitif = "OU=PCPortable,OU=Paris,OU=Ordinateurs,$DomainDN"
$OUattente = "OU=PCEnAttente,$DomainDN"


# Récupération de tous les PC dans l'OU initial
$Computers = Get-ADComputer -SearchBase $OUinitial -Filter *

# Bouger les PC s'ils appartiennent à la liste
foreach ($Computer in $Computers) {
    if ( $ListPC | Select-String $Computer.Name)
    {
        Move-ADObject -Identity $Computer -TargetPath $OUdefinitif
        Write-Output "$($computer.Name) a été déplacé dans $OUdefinitif."
    }
    else
    {
        # Les mettre en attente si leur nom n'est pas vérifié
        Move-ADObject -Identity $Computer -TargetPath $OUattente
        Write-host "$($computer.Name) n'est pas dans la liste des PC autorisé, merci de vérifier manuellement. Il se trouve dans l'OU PCEnAttente" -ForegroundColor Red
    }
}

######################################################################################################
#                                                                                                    #
#   Création USER automatiquement avec fichier (avec suppression protection contre la suppression)   #
#                                                                                                    #
######################################################################################################

$FilePath = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)

### Parametre(s) à modifier

$File = "$FilePath\S03_ListeEmployes.csv"

# Fonction pour retirer les espaces et les caractères spéciaux
Function FormatTxt {
    param ([string]$Texte)
	$Texte = [Text.Encoding]::ASCII.GetString([Text.Encoding]::GetEncoding("Cyrillic").GetBytes($Texte))
        $Texte = $Texte -replace "-","" -replace " ","" -replace "/", "" -replace "'","" -replace "&",""
        return $Texte
}

### Main program

Clear-Host
If (-not(Get-Module -Name activedirectory))
{
    Import-Module activedirectory
}

$Users = Import-Csv -Path $File -Delimiter ";" -Header "civilité","Prenom","Nom","Société","Site","Département","Service","Fonction","ManagerPrenom","ManagerNom","PC","DateNaissance","Telfixe","Telportable","Nomadisme"
$ADUsers = Get-ADUser -Filter * -Properties *
$count = 1
Foreach ($User in $Users)
{
    Write-Progress -Activity "Création des utilisateurs dans l'OU" -Status "%effectué" -PercentComplete ($Count/$Users.Length*100)
    $Name              = "$($User.Nom) $($User.Prenom)"
    $DisplayName       = "$($User.Nom) $($User.Prenom)"
    $Description       = $User.DateNaissance
    $SamAccountName    =  $((FormatTxt $User.Nom).ToLower()) + "." + $((FormatTxt $User.Prenom).substring(0,3).tolower())
    #Vérification qu'il n'y est pas déjà un autre utilisateur avec le même nom (si pas la même date de naissance, personne différente)
    $i=1
    while ($ADUsers | Where {$_.SamAccountName -eq $SamAccountName} | Where {$_.Description -ne $Description} -ne $Null)
    { 	$SamAccountName=$((FormatTxt $User.Nom).ToLower()) + "." + $((FormatTxt $User.Prenom).substring(0,3).tolower()) + $i
    	$i=$i+1
	}
    
    $UserPrincipalName = $SamAccountName + "@" + (Get-ADDomain).Forest
    $GivenName         = $User.Prenom
    $Surname           = $User.Nom
    $OfficePhone       = $User.Telfixe
    $EmailAddress      = $UserPrincipalName
    $Company           = $User.Société
    $Department        = "$($User.Département) -- $($User.Service)"
    $City              = $User.Site
    $Title             = $User.Fonction
    $Mobile            = $User.Telportable
    $Manager           = "$User.ManagerNom $User.ManagerPrenom"
    # Chemin en fonction de Extérieur ou employé
    if ($User.Société -ne "Ekoloclast")
    { $Path="ou=Extérieur,ou=Utilisateurs,dc=Eko,dc=lan" }
    else
    { $Path= "ou=$($User.Département),ou=Paris,ou=Utilisateurs,dc=Eko,dc=lan"}
    
    If (($ADUsers | Where {$_.SamAccountName -eq $SamAccountName}) -eq $Null)
    {
        New-ADUser -Name $Name -DisplayName $DisplayName -SamAccountName $SamAccountName -UserPrincipalName $UserPrincipalName `
        -GivenName $GivenName -Surname $Surname -OfficePhone $OfficePhone -EmailAddress $EmailAddress `
        -City $Location -Title $Title -MobilePhone $Mobile  `
        -Path $Path -AccountPassword (ConvertTo-SecureString -AsPlainText Azerty1* -Force) -Enabled $True `
        -OtherAttributes @{Company = $Company;Department = $Department} -ChangePasswordAtLogon $True
        # -Manager $Manager
        Write-Host "Création du USER $SamAccountName" -ForegroundColor Green
        
        # Ajout de l'utilisateur dans les groupes Utilisateurs / Paris / Département / Service (si existant)
        Add-ADGroupMember -Identity GrpUsers_Ekoloclast -Members $SamAccountName
        if ( $Company -eq "Ekoloclast")
        { Add-ADGroupMember -Identity GrpUsers_Paris -Members $SamAccountName}
        else { Add-ADGroupMember -Identity GrpUsers_Extérieur -Members $SamAccountName}
        Add-ADGroupMember -Identity GrpUsers_$(FormatTxt $User.Département) -Members $SamAccountName
        if ($User.Service -ne "-")
        {
        	Add-ADGroupMember -Identity GrpUsers_$(FormatTxt $User.Service) -Members $SamAccountName
        }
            
    }
    Else
    {
        Write-Host "Le USER $SamAccountName existe déjà" -ForegroundColor Black -BackgroundColor Yellow
    }
    $Count++
    sleep -Milliseconds 100
}

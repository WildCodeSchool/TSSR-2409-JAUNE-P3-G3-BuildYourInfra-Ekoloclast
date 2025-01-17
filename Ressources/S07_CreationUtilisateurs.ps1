######################################################################################################
#                                                                                                    #
#   Création USER automatiquement avec fichier (avec suppression protection contre la suppression)   #
#                                                                                                    #
######################################################################################################

$FilePath = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)

### Parametre(s) à modifier

$File = "C:\Script\S06_ListeEmployes.csv"

# Fonction pour retirer les espaces et les caractères spéciaux
Function FormatTxt {
    param ([string]$Texte)
    $Texte = [Text.Encoding]::ASCII.GetString([Text.Encoding]::GetEncoding("Cyrillic").GetBytes($Texte))
    $Texte = $Texte -replace "-", "" -replace " ", "" -replace "/", "" -replace "'", "" -replace "&", ""
    return $Texte
}

### Main program

Clear-Host
If (-not(Get-Module -Name activedirectory)) {
    Import-Module activedirectory
}

$Users = Import-Csv -Path $File -Delimiter ";" -Header "civilité", "Prenom", "Nom", "Société", "Site", "Département", "Service", "Fonction", "ManagerPrenom", `
    "ManagerNom", "PC", "DateNaissance", "Telfixe", "Telportable", "Nomadisme"
$ModifiedUsers = ""


$count = 1
Foreach ($User in $Users) {
    Write-Progress -Activity "Mise à jour des utilisateurs dans l'OU" -Status "%effectué" -PercentComplete ($Count / $Users.Length * 100)
    $Name = "$($User.Nom) $($User.Prenom)"
    $DisplayName = "$($User.Nom) $($User.Prenom)"
    $Description = $User.DateNaissance    
    $GivenName = $User.Prenom
    $Surname = $User.Nom
    $OfficePhone = $User.Telfixe
    $EmailAddress = $UserPrincipalName
    $Company = $User.Société
    $Department = "$($User.Département) -- $($User.Service)"
    $Location = $User.Site
    $Title = $User.Fonction
    $Mobile = $User.Telportable
    
    # Chemin en fonction de Extérieur ou employé
    $Path = "ou=$($User.Département),ou=Paris,ou=Utilisateurs,dc=Eko,dc=lan"
    if ($User.Société -ne "Ekoloclast")
    { $Path = "ou=Extérieur,ou=Utilisateurs,dc=Eko,dc=lan" }
    
    
    # Cherche si il existe un User avec le même prénom et DDN
    $ExistingUser = Get-ADUser -Filter { ((GivenName -eq $GivenName) -and (Description -eq $Description)) } -Properties Title
    if ($ExistingUser) {
        # Si même prenom et même DDN
        if ($ExistingUser.Surname -eq $Surname) {
            # Si même nom
            Set-ADUser -Identity $ExistingUser.SamAccountName -OfficePhone $OfficePhone -City $Location -Title $Title -MobilePhone $Mobile  -Company $Company -Department $Department
            Write-Host "Mise à jour de l'utilisateur $SamAccountName (pas de changement de nom)" -ForegroundColor Green
        }
        elseif ($ExistingUser.Title -like $Title) {
            # si pas même nom mais même travail
            Set-ADUser -Identity $ExistingUser.SamAccountName -DisplayName $DisplayName `
                -Surname $Surname -OfficePhone $OfficePhone -City $Location  -MobilePhone $Mobile `
                -Company $Company -Department $Department
            Write-Host "Création de l'utilisateur $SamAccountName (changement de nom)" -ForegroundColor Magenta
        }
        else {
            # doute sur même personne ou pas (même prenom et DDN mais travail et nom différents)
            Write-Host "Doute sur la personne $Name avec les utilisateurs : $ExistingUser " -ForegroundColor Red
            Write-Host "A traiter manuellement " -ForegroundColor Red
        }
        $SamAccountName = $ExistingUser.SamAccountName
        
    }
    else {
        # nouveau utilisateur
        # Génération du SamAccountName et du UserPrincipalName
        $SamAccountName = $((FormatTxt $User.Nom).ToLower()) + "." + $((FormatTxt $User.Prenom).substring(0, 3).tolower())
        #Vérification qu'il n'y est pas déjà un autre utilisateur avec le même nom (si pas la même date de naissance, personne différente)
        $i = 1
        while ($ADUsers | Where-Object { $_.SamAccountName -eq $SamAccountName } | Where-Object { $_.Description -ne $Description } -ne $Null) { 	
            $SamAccountName = $((FormatTxt $User.Nom).ToLower()) + "." + $((FormatTxt $User.Prenom).substring(0, 3).tolower()) + $i
            $i = $i + 1
        }
        $UserPrincipalName = $SamAccountName + "@" + (Get-ADDomain).Forest
        New-ADUser -Name $Name -DisplayName $DisplayName -SamAccountName $SamAccountName -UserPrincipalName $UserPrincipalName `
            -GivenName $GivenName -Surname $Surname -OfficePhone $OfficePhone -EmailAddress $EmailAddress `
            -City $Location -Title $Title -MobilePhone $Mobile -Description $Description `
            -Path $Path -AccountPassword (ConvertTo-SecureString -AsPlainText Azerty1* -Force) -Enabled $True `
            -OtherAttributes @{Company = $Company; Department = $Department } -ChangePasswordAtLogon $False
        
        Write-Host "Création de l'utilisateur $SamAccountName" -ForegroundColor Blue
    }

    #Ajout de l'utilisateur dans les groupes Utilisateurs / Paris / Département / Service (si existant)
    Add-ADGroupMember -Identity GrpUsers_Ekoloclast -Members $SamAccountName
    if ( $Company -eq "Ekoloclast")
    { Add-ADGroupMember -Identity GrpUsers_Paris -Members $SamAccountName }
    else { Add-ADGroupMember -Identity GrpUsers_Extérieur -Members $SamAccountName }
    Add-ADGroupMember -Identity GrpUsers_$(FormatTxt $User.Département) -Members $SamAccountName
    if ($User.Service -ne "-") {
        Add-ADGroupMember -Identity GrpUsers_$(FormatTxt $User.Service) -Members $SamAccountName
    }

    $ModifiedUsers = $ModifiedUsers + " " + $SamAccountName
    $Count++
    sleep -Milliseconds 100
}


$ADUsers = Get-ADUser -Filter * -SearchBase "ou=Utilisateurs,dc=eko,dc=lan"
foreach ($ADUser in $ADUsers) {
    if (!($ModifiedUsers | Select-String -Pattern $ADUser.SamAccountName)) {
        # L'utilisateur n'a pas été modifié donc ne fait plus partie de la liste
        Disable-ADAccount -Identity $ADUser
        Move-ADObject -Identity $ADUser -TargetPath "OU=CompteSuspendu,dc=eko,dc=eko" 
        Write-Host "Désactivation de l'utilisateur $ADUser" -ForegroundColor Yellow
    }
}

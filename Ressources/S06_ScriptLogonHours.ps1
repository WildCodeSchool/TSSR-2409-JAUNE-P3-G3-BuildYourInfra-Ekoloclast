## Script pour définir les plages horaires des utilisateurs AD

# Listes des utilisateurs normaux et des utilisateurs ByPass
$Utilisateurs=Get-ADUSer -SearchBase "OU=Utilisateurs,DC=eko,DC=lan" -Filter *
#### $UtilisateursBypass=Get-ADGroupMember -R -Identity "GrpUsers_LogonHoursBypass"

# Définition des horaires (6h à 19 du lundi au samedi OU illimité)
[byte[]]$Heures = @(0,0,0,224,255,3,224,255,3,224,255,3,224,255,3,224,255,3,224,255,3)
[byte[]]$HeuresBypass = @(255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255)

Foreach $Utilisateur in $Utilisateurs
{
    if (Get-ADGroupMember -R -Identity "GrpUsers_LogonHoursBypass" | Where-Object SamAccountName -eq $Utilisateur.SamAccountName)
    {
        Set-ADUser -Identity $Utilisateur -Replace @{logonhours = $HeuresBypass} -Server addax.eko.lan
    }
    else
    {
        Set-ADUser -Identity $Utilisateur -Replace @{logonhours = $Heures} -Server addax.eko.lan
    }
    
}

Import-Module ActiveDirectory
#
#
#
Get-ADUser XXXXX | Select-Object SurName GivenName

# Get-ADUser -Filter * -Property mail | select name, mail
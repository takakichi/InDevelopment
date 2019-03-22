#
# åpè≥ÇÃñ≥å¯âª
#
function SetAccessRuleProtection( $folder_name ) {
	$folder_name = 'c:\temp'
	$acl = Get-Acl $folder_name
	$acl.SetAccessRuleProtection( $true, $true )
	$acl | Set-Acl folder_name
}
SetAccessRuleProtection( "c:\temp" )

#
# Read Œ ŒÀ•t—^
#
Function SetPermReadOnly ( $folder_name, $params ) {
  $acl   = Get-Acl $folder_name
  $rule = New-Object System.Security.AccessControl.FileSystemAccessRule $params
  $acl.SetAccessRule($rule)
  $acl | Set-Acl $folder_name
}

$param = ( $user, "ReadAndExecute", "ContainerInherit, ObjectInherit", "None", "Allow" )
Set-Perm ( $folder, $param )
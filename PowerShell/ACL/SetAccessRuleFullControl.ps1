
Function SetPermReadOnly ( $folder_name, $user, $perms ) {

$fc_user_name = 'domain\username'
$acl = Get-Acl $folder_path
$permission = ($fc_user_name,"FullControl","ContainerInherit, ObjectInherit", "None","Allow")
# 引数：ユーザー名,アクセス権,下位フォルダへ継承,下位オブジェクトへ継承,継承の制限,アクセス許可
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl.SetAccessRule($accessRule)
$acl | Set-Acl $folder_path

}



Function SetPermReadOnly ( $folder_name, $user, $perms ) {

$fc_user_name = 'domain\username'
$acl = Get-Acl $folder_path
$permission = ($fc_user_name,"FullControl","ContainerInherit, ObjectInherit", "None","Allow")
# �����F���[�U�[��,�A�N�Z�X��,���ʃt�H���_�֌p��,���ʃI�u�W�F�N�g�֌p��,�p���̐���,�A�N�Z�X����
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl.SetAccessRule($accessRule)
$acl | Set-Acl $folder_path

}


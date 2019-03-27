

function ListACLFolder( [string] $folder_name ) {

    # $list = Get-ChildItem $folder_name -Force -Recurse | where { $_.mode -match "d" } | Select-object Fullname
    $list = Get-ChildItem $folder_name -Force -Recurse | where { $_.mode -match "d" }
    foreach($path in $list){ 
        write-host $path.fullname
        # $acls = Get-ACL $path.fullname | Select-object @{Label="Path";Expression={Convert-Path $_.Path}}
        $acls = Get-ACL -Path $path.fullname
        foreach($acl in $acls){ 
            $values = $acl.Access
            foreach($value in $values){ 
                write-host $value.IdentityReference + " " + $value.FileSystemRights  
            }
            write-host "--------"
        }
        write-host "================"
    }
}

ListACLFolder "c:\temp"

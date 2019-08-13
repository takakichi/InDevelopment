Add-PSSnapin Microsoft.SharePoint.Powershell -ErrorAction SilentlyContinue

#
# Rename SharePoint Document Library View
#
function DeleteDocumentLibraryView
{
 Param
 ( 
  [Microsoft.SharePoint.SPWeb]$Web,
  [String] $LibraryName,
  [String] $DeleteViewName
 )
    if ( ($web.Lists.TryGetList($LibraryName)) -eq $null ) {
        Write-Host "Not Exists Document Library '$LibraryName'" -f Red
    } else {
        $List = $Web.Lists[$LibraryName]
        $Views = $List.Views
        $View = $Views[$DeleteViewName]
        $guid = [System.Guid]($View.ID)
        $Views.Delete($guid)
        Write-Host "Delete Document Library '$LibraryName' View ['$DeleteViewName'] Successfully!" -f Green
    }
}
  
$web = Get-SPWeb "http://sample.com:17777/"
 
DeleteDocumentLibraryView $web "A00" "全ての資料"

Add-PSSnapin Microsoft.SharePoint.Powershell -ErrorAction SilentlyContinue

#
# Rename SharePoint Document Library View
#
function RenameDocumentLibraryViewName
{
 Param
 ( 
  [Microsoft.SharePoint.SPWeb]$Web,
  [String] $LibraryName,
  [String] $ViewName,
  [String] $NewViewName
 )
    if ( ($web.Lists.TryGetList($LibraryName)) -eq $null ) {
        Write-Host "Not Exists Document Library '$LibraryName'" -f Red
    } else {
        $List = $Web.Lists[$LibraryName]
        $Views = $List.Views
        $View = $Views[$ViewName]
        $View.Title = $NewViewName
        $view.Update()
        Write-Host "Rename Document Library '$LibraryName' View ['$ViewName' -> '$NewViewName'] Successfully!" -f Green
    }
}
  
$web = Get-SPWeb "http://sample.com:17777/"
 
RenameDocumentLibraryView $web "A00" "すべてのドキュメント" "全ての資料"

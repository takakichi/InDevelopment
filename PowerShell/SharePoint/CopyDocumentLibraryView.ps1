Add-PSSnapin Microsoft.SharePoint.Powershell -ErrorAction SilentlyContinue

#
# Copy SharePoint Document Library View
#
function CopyDocumentLibraryView
{
 Param
 ( 
  [Microsoft.SharePoint.SPWeb]$Web,
  [String] $LibraryName,
  [String] $ViewName,
  [String] $NewViewName
 )
    if(($Web.Lists.TryGetList($LibraryName)) -eq $null) {
        Write-Host "Not Exists Document Library '$LibraryName'" -f Red
    } else {
        $List = $Web.Lists($LibraryName)
        $Views = $List.Views
        $View = $Views[$ViewName]
        # -------------------------------------------------
        # Get Source View Attributes
        # -------------------------------------------------
        $RowLimit = $View.RowLimit
        $Paged = $View.Paged
        $Query = $View.ViewQuery
        $DefaultView = $View.DefaultView
        $ViewFieldCollection = $View.ViewFieldCollection
        # -------------------------------------------------
        # Set New View Attribute
        # -------------------------------------------------
        $NewViewFieldCollection = $ViewFieldCollection
        $NewDefaultView = $DefaultView
        $NewQuery = $Query
        $NewRowLimit = $RowLimit
        $NewPaged = $Paged
        $NewDefaultView = $False
        # -------------------------------------------------
        # Create New View
        # -------------------------------------------------
        $view = $Views.Add($NewViewName, $NewViewFieldCollection, $NewQuery, $NewRowLimit, $NewPaged, $NewDefaultView)
        Write-Host "Create Copy New View '$LibraryName' - '$NewViewName' Successfully!" -f Green
    }
}
  
#Get the Web
$web = Get-SPWeb "http://sample.com:17777/"
  
# Create Document Library
CopyDocumentLibraryView $web "A00" "All Documents" "All New Documents"

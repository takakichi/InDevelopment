Add-PSSnapin Microsoft.SharePoint.Powershell -ErrorAction SilentlyContinue

#
# Create SharePoint Document Library
#
function CreateDocumentLibrary
{
 Param
 ( 
  [Microsoft.SharePoint.SPWeb]$Web,
  [String] $LibraryName,
  [String] $LibraryTitle,
  [String] $Description
 )
    $ListTemplate = [Microsoft.Sharepoint.SPListTemplateType]::DocumentLibrary
   
    if(($web.Lists.TryGetList($LibraryName)) -eq $null)
    {
        $Web.Lists.Add($LibraryName,$Description,$ListTemplate) > nil
    
        #Set Properties of Library such as OnQuickLaunch, etc
        $docLib =  $Web.Lists[$LibraryName] 
        $docLib.OnQuickLaunch = $false
        $docLib.EnableVersioning = $false
        $docLib.EnableMinorVersions = $false
        $docLib.Update()
        Write-Host "Create Document library '$LibraryName' Successfully!" -f Green
    }
    else
    {
        Write-Host "Already Exists Document Library '$LibraryName'" -f Red
    }
}
  
#Get the Web
$web = Get-SPWeb "http://sample.com:17777/"
  
# Create Document Library
Create-DocumentLibrary $web "A00" "Sample Document List" "Sample Doument Library for A Team"

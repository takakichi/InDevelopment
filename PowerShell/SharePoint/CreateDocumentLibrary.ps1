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
  
# Execute Create Document Library
Create-DocumentLibrary $web "Team Documents" "Library to Share Team Documents"

#Read more: http://www.sharepointdiary.com/2015/02/create-document-library-in-sharepoint-using-powershell.html#ixzz5XUteeYeT

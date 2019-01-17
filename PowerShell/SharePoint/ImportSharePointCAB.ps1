#
# 
# URL : http://codecaching.blogspot.com/2012/09/
#
function ImportSharePointCAB {
    param(
        [Parameter(mandatory=$true)] [string]$webUrl,
        [Parameter(mandatory=$true)] [string]$fileName
    )    
 
    try
    {
        if (!(Test-Path $fileName)) 
        {
            write-host " ファイル名 $fileName が見つかりません。"
            return
        }
        $cabFile = $fileName.Replace(".cmp", ".cab")
        Copy-Item $fileName $cabFile
        write-host "$fileName を $cabFileto にコピーしました。"
 
        $cabFolder = "$(split-path $fileName -Parent)\$((Get-Item -path $fileName).basename)"
         
        if (Test-Path $cabFolder) { remove-item $cabFolder -recurse }
         
        New-Item -ItemType directory -Path $cabFolder
        # ---------------------------------------------------------------------
        # Creating CAB Files with Windows PowerShell
        # ---------------------------------------------------------------------
        $comObject = "Shell.Application"
        write-host "Creating $comObject"
        $shell = New-Object -Comobject $comObject
        if(!$?) { $(Throw "unable to create $comObject object")} 
        write-host "Creating CAB object for $cabFile"
        $sourceCab = $shell.Namespace($cabFile).items()
        write-host "Creating destination folder object for $cabFolder"
        $DestinationFolder = $shell.Namespace($cabFolder)
        write-host "Expanding $cabFile to $cabFolder"
        $DestinationFolder.CopyHere($sourceCab)

        # Search Manifest.xml for the following and replace "60354" with a valid year
        $findText = "Value=`"29 May 60354 05:36:10 -0000`""
        $replaceText = "Value=`"29 May 2019 05:36:10 -0000`""
         
        (Get-Content "$($cabFolder)\Manifest.xml") | 
            Foreach-Object {$_ -replace $findText, $replaceText} | 
            Set-Content "$($cabFolder)\Manifest.xml" -encoding UTF8

        import-spweb -identity $webUrl -path $cabFolder -force -UpdateVersions 2 -nofilecompression #-whatif
    }
    catch [Exception]
    {
        write-host $_.Exception.ToString() -ForegroundColor Red
    }
}
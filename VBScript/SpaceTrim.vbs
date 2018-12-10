' ==============================================================
' Name      : SpaceTrim.vbs
' Purpose   : Text File Trim Space Only Right
' Parameter : (0) ... Input File Name
' Reference : https://gallery.technet.microsoft.com/scriptcenter/42efb272-cf98-476c-ba2b-3c11c81e2e24
'
' Version 1.0.0 Initial
' ==============================================================
Dim fileName
Const FOR_READING = 1 
Const FOR_WRITING = 2 
 
if WScript.Arguments.Count = 0 then
    WScript.echo("SpaceTrim.vbs <fileName>")
    WScript.Quit(-1)
end if

fileName = WScript.Arguments(0)

Set objFSO = CreateObject("Scripting.FileSystemObject") 
Set objFile = objFSO.OpenTextFile(fileName, FOR_READING) 
 
Do Until objFile.AtEndOfStream 
    strLine = objFile.Readline 
    strLine = RTrim(strLine) 
    strNewContents = strNewContents & strLine & vbCrLf
Loop 
objFile.Close 
Set objFile = objFSO.OpenTextFile(fileName, FOR_WRITING) 
objFile.Write strNewContents 
objFile.Close 
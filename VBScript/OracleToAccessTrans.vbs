' ==============================================================
' Name      : OracleToAccessTrans.vbs
' Purpose   : OracleのテーブルデータをAccessにコピーする。
'             ※ Access VBAとして組み込むこと。
' Parameter : なし
' Reference : https://tkclown.hatenadiary.org/entry/20090115/1231998768
'
' Version 0.1.0 
' ==============================================================
' ---------------------------------------------
'
' ---------------------------------------------
Sub OracleToAccessTrans()

    Dim ConnectString As String = "Provider=OraOLEDB.Oracle;Data Source=<サーバ名>:1521/<SID名>;User ID=<ユーザ名>;Password=<パスワード>"

    Dim conn          As Object
    Dim rec           As Object
    Dim tableName     As String
    Dim strSQL        As String
    
    DoCmd.SetWarnings False
    Set conn = CreateObject("ADODB.Connection")
    conn.Open ConnectString
            
    strSQL = "SELECT table_name FROM user_tables WHERE partitioned = 'NO' ORDER BY table_name"
    Set rec = conn.Execute(strSQL)
    Do While Not rec.EOF
        tableName = rec.Fields("table_name").Value
        On Error Resume Next
        DoCmd.DeleteObject acTable, tableName
        On Error GoTo 0
        DoCmd.TransferDatabase acImport, "ODBC Database", _
            "ODBC; DSN=" & dsn & ";UID=" & user & ";PWD=" & pass & ";", _
            acTable, user & "." & tableName, tableName, False
        rec.MoveNext
    Loop
    
    conn.Close
    Set rec = Nothing
    Set conn = Nothing

End Sub
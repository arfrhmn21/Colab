Sub ImportCodeToTable_Full()

    Dim fullPath As String
    Dim fileNum As Integer
    Dim lines() As String
    Dim lineText As String
    Dim i As Long
    Dim rowCount As Long
    
    With Application.FileDialog(msoFileDialogFilePicker)
        .Title = "Pilih file kode"
        .Filters.Clear
        .Filters.Add "Code Files", "*.cpp;*.c;*.h;*.java;*.py;*.txt;*.html;*.css;*.js"
        .Filters.Add "All Files", "*.*"
        
        If .Show <> -1 Then Exit Sub
        
        fullPath = .SelectedItems(1)
    End With
    
    fileNum = FreeFile
    Open fullPath For Input As #fileNum
    
    rowCount = 0
    Do Until EOF(fileNum)
        Line Input #fileNum, lineText
        
        ' Pertahankan indentasi
        lineText = Replace(lineText, vbTab, "    ")
        
        rowCount = rowCount + 1
        ReDim Preserve lines(1 To rowCount)
        lines(rowCount) = lineText
    Loop
    
    Close #fileNum
    
    Dim tbl As Table
    Set tbl = ActiveDocument.Tables.Add( _
        Range:=Selection.Range, _
        NumRows:=rowCount, _
        NumColumns:=2)
    
    For i = 1 To rowCount
        tbl.Cell(i, 1).Range.Text = i
        tbl.Cell(i, 2).Range.Text = lines(i)
    Next i
    
    With tbl.Range.Font
        .Name = "Courier New"
        .Size = 10
    End With
    
    With tbl.Range.ParagraphFormat
        .LineSpacingRule = wdLineSpaceSingle
        .SpaceBefore = 0
        .SpaceAfter = 0
    End With
    
    tbl.Rows.AllowBreakAcrossPages = False
    
    tbl.AllowAutoFit = False
    tbl.Columns(1).Width = CentimetersToPoints(0.8)
    tbl.AutoFitBehavior wdAutoFitWindow
    
    tbl.Borders.Enable = False
    
    With tbl.Borders
        .OutsideLineStyle = wdLineStyleSingle
        .OutsideLineWidth = wdLineWidth050pt
    End With
    
    With tbl.Columns(1).Borders(wdBorderRight)
        .LineStyle = wdLineStyleSingle
        .LineWidth = wdLineWidth050pt
    End With
    
    MsgBox "Tabel berhasil dibuat!"

End Sub


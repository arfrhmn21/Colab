Sub GenerateFullReport()

    Dim folderPath As String
    Dim fso As Object
    Dim file As Object
    Dim doc As Document
    
    Set doc = ActiveDocument
    
    ' =========================
    ' PILIH FOLDER
    ' =========================
    folderPath = ActiveDocument.Path & "\"
    
    Set fso = CreateObject("Scripting.FileSystemObject")
    
    ' =========================================
    ' STYLE HEADING
    ' =========================================
    Selection.Style = wdStyleHeading2
    
    ' =========================================
    ' I. PRE TEST
    ' =========================================
    
    Selection.TypeText "Pre Test"
    Selection.TypeParagraph
    
    InsertImageWithCaption folderPath & "pre-test.jpeg", _
        14, _
        "Gambar 1.", _
        "Pre Test"
    
    Selection.TypeParagraph
    Selection.TypeParagraph
    
    ' =========================================
    ' II. HASIL PRAKTIKUM
    ' =========================================
    
    Selection.Style = wdStyleHeading2
    Selection.TypeText "Hasil Praktikum"
    Selection.TypeParagraph
    
    ' =========================================
    ' A. LUARAN PRAKTIKUM
    ' =========================================
    
    Selection.Style = wdStyleHeading3
    Selection.TypeText "Luaran Praktikum"
    Selection.TypeParagraph
    
    Dim i As Integer
    
    i = 1
    
    Do While fso.FileExists(folderPath & "laprak-" & i & ".cpp")
    
        ' =========================
        ' KODE LAPRAK
        ' =========================
        
        InsertCodeTable folderPath & "laprak-" & i & ".cpp"
        
        InsertCaptionCustom "Kode Program 2.", _
            "Laprak " & i
        
        Selection.TypeParagraph
        
        ' =========================
        ' OUTPUT LAPRAK
        ' =========================
        
        If fso.FileExists(folderPath & "laprak-" & i & ".png") Then
        
            InsertImageWithCaption _
                folderPath & "laprak-" & i & ".png", _
                15, _
                "Gambar 2.", _
                "Output Laprak " & i
        
        End If
        
        Selection.TypeParagraph
        
        ' =========================
        ' RAPTOR
        ' =========================
        
        If fso.FileExists(folderPath & "raptor-" & i & ".png") Then
        
            InsertImageWithCaption _
                folderPath & "raptor-" & i & ".png", _
                15, _
                "Gambar 2.", _
                "Raptor Laprak " & i
        
        End If
        
        Selection.TypeParagraph
        
        ' =========================
        ' KODE KUIS
        ' =========================
        
        If fso.FileExists(folderPath & "kuis-" & i & ".cpp") Then
        
            InsertCodeTable folderPath & "kuis-" & i & ".cpp"
            
            InsertCaptionCustom _
                "Kode Program 2.", _
                "Kuis " & i
            
            Selection.TypeParagraph
            
        End If
        
        ' =========================
        ' OUTPUT KUIS
        ' =========================
        
        If fso.FileExists(folderPath & "kuis-" & i & ".png") Then
        
            InsertImageWithCaption _
                folderPath & "kuis-" & i & ".png", _
                15, _
                "Gambar 2.", _
                "Output Kuis " & i
        
        End If
        
        Selection.TypeParagraph
        Selection.TypeParagraph
        
        i = i + 1
    
    Loop
    
    ' =========================================
    ' B. ULASAN PRAKTIKUM
    ' =========================================
    
    Selection.Style = wdStyleHeading3
    Selection.TypeText "Ulasan Praktikum"
    Selection.TypeParagraph
    Selection.TypeParagraph
    
    ' =========================================
    ' III. POST TEST
    ' =========================================
    
    Selection.Style = wdStyleHeading2
    Selection.TypeText "Post Test"
    Selection.TypeParagraph
    
    If fso.FileExists(folderPath & "post-test.cpp") Then
    
        InsertCodeTable folderPath & "post-test.cpp"
        
        InsertCaptionCustom _
            "Kode Program 3.", _
            "Post Test"
        
    End If
    
    Selection.TypeParagraph
    
    If fso.FileExists(folderPath & "post-test.png") Then
    
        InsertImageWithCaption _
            folderPath & "post-test.png", _
            15, _
            "Gambar 3.", _
            "Output Post Test"
    
    End If
    
    MsgBox "Laporan berhasil dibuat!"
    
End Sub


' ===================================================
' INSERT IMAGE
' ===================================================
Sub InsertImageWithCaption( _
    imagePath As String, _
    widthCM As Double, _
    labelName As String, _
    captionText As String)

    If Dir(imagePath) = "" Then Exit Sub

    On Error Resume Next
    CaptionLabels.Add Name:=labelName
    On Error GoTo 0

    Dim shp As InlineShape

    Set shp = Selection.InlineShapes.AddPicture( _
        fileName:=imagePath, _
        LinkToFile:=False, _
        SaveWithDocument:=True)

    ' Atur ukuran gambar
    shp.LockAspectRatio = True
    shp.Width = CentimetersToPoints(widthCM)
    
    ' Tengah
    Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter

    ' Pindahkan cursor keluar dari gambar
    Selection.MoveRight Unit:=wdCharacter, Count:=1
    Selection.TypeParagraph

    ' Insert caption
    Selection.InsertCaption _
        Label:=labelName, _
        Title:=" " & captionText, _
        Position:=wdCaptionPositionBelow
        
    ' Format caption
    Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    Selection.Font.Italic = True

    Selection.TypeParagraph

End Sub


' ===================================================
' INSERT CAPTION CUSTOM
' ===================================================
Sub InsertCaptionCustom( _
    labelName As String, _
    captionText As String)

    On Error Resume Next
    
    CaptionLabels.Add Name:=labelName
    
    On Error GoTo 0
    
    Selection.InsertCaption _
        Label:=labelName, _
        Title:=" " & captionText, _
        Position:=wdCaptionPositionBelow
    
    ' Format caption
    Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    Selection.Font.Italic = True
    
End Sub


' ===================================================
' INSERT CODE TABLE
' ===================================================
Sub InsertCodeTable(fullPath As String)

    Dim fileNum As Integer
    Dim lines() As String
    Dim lineText As String
    Dim i As Long
    Dim rowCount As Long
    
    fileNum = FreeFile
    Open fullPath For Input As #fileNum
    
    rowCount = 0
    
    Do Until EOF(fileNum)
    
        Line Input #fileNum, lineText
        
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

End Sub


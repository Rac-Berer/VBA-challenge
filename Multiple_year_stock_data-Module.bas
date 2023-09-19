Attribute VB_Name = "Module1"
Sub Multi_Stocks():

'Setting up parameters
Dim i As Long
Dim summary_index As Integer
Dim open_index As Long
Dim totalvolume As Double
Dim LR As Long
Dim percentchange As Double
Dim maxpc As Double
Dim maxpcTicker As String
Dim minpc As Double
Dim minpcTicker As String
Dim maxvol As Double
Dim maxvolTicker As String

totalvolume = 0
summary_index = 2
open_index = 2
maxpc = 0
minpc = 0
maxvol = 0


'Set on each sheet
For Each ws In Worksheets
ws.Activate


'set up last row
LR = Cells(Rows.Count, 1).End(xlUp).Row



'Inserting text
     Cells(1, 9).Value = "Ticker"
     Cells(1, 10).Value = "Yearly Change"
     Cells(1, 11).Value = "Percent Change"
     Cells(1, 12).Value = "Total Stock Volume"
     Cells(2, 15).Value = "Greatest % increase"
     Cells(3, 15).Value = "Greatest % decrease"
     Cells(4, 15).Value = "Greatest Total Volume"
     Cells(1, 16).Value = "Ticker"
     Cells(1, 17).Value = "Value"
     
'For Loops
For i = 2 To LR
    totalvolume = totalvolume + Cells(i, 7).Value
    
    If (Cells(i + 1, 1).Value <> Cells(i, 1).Value) Then
    
    
        Cells(summary_index, 9).Value = Cells(i, 1).Value
    
        Cells(summary_index, 10).Value = Cells(i, 6).Value - Cells(open_index, 3).Value
        If Cells(summary_index, 10).Value >= 0 Then
            Cells(summary_index, 10).Interior.ColorIndex = 4
            
        Else
            Cells(summary_index, 10).Interior.ColorIndex = 3
            
        End If
        
        percentchange = Cells(summary_index, 10).Value / Cells(open_index, 3).Value
        
        Cells(summary_index, 11).Value = percentchange
        
        Cells(summary_index, 11).NumberFormat = "0.00%"
        Cells(summary_index, 12).Value = totalvolume
        Cells(summary_index, 12).NumberFormat = "0"
        Cells(summary_index, 10).NumberFormat = "0.00"
        
        'ask about the second two ifs
        If percentchange > maxpc Then
            maxpc = percentchange
            maxpcTicker = Cells(i, 1).Value
            
        ElseIf percentchange < minpc Then
            minpc = percentchange
            minpcTicker = Cells(i, 1).Value
            
        ElseIf totalvolume > maxvol Then
            maxvol = totalvolume
            maxvolTicker = Cells(i, 1).Value
                     
        
            
        End If
        
        summary_index = summary_index + 1
        open_index = i + 1
        totalvolume = 0
    End If


Next i

'insertion of the greatest data
Cells(2, 17).Value = maxpc
Cells(2, 17).NumberFormat = "0.00%"
Cells(2, 16).Value = maxpcTicker
Cells(3, 17).Value = minpc
Cells(3, 17).NumberFormat = "0.00%"
Cells(3, 16).Value = minpcTicker
Cells(4, 17).Value = maxvol
Cells(4, 17).NumberFormat = "0"
Cells(4, 16).Value = maxvolTicker
Next ws


End Sub



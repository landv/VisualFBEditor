﻿'#########################################################
'#  frmFind.bas                                          #
'#  This file is part of VisualFBEditor                  #
'#  Authors: Xusinboy Bekchanov (bxusinboy@mail.ru)      #
'#           Liu XiaLin (LiuZiQi.HK@hotmail.com)         #
'#########################################################

#include once "frmFind.bi"
Dim Shared As frmFind fFind
pfFind = @fFind

'#Region "Form"
	
	Constructor frmFind
		This.Name = "frmFind"
		This.SetBounds 0, 0, 456, 92
		This.Opacity = 210
		This.Caption = ML("Find")
		This.DefaultButton = @btnFind
		#ifdef __USE_GTK__
			This.Icon.LoadFromFile(ExePath & "/Resources/VisualFBEditor.ico")
		#else
			This.BorderStyle = FormBorderStyle.FixedDialog
			This.Icon.LoadFromResourceID(1)
		#endif
		This.MinimizeBox = False
		This.MaximizeBox = False
		This.OnCreate = @Form_Create_
		This.CancelButton = @btnCancel
		This.OnShow = @Form_Show_
		This.Designer = @This
		'This.OnActivate = @Form_Activate_
		This.OnClose = @Form_Close_
		
		' lblFind
		lblFind.Name = "lblFind"
		lblFind.SetBounds 21, 4, 40, 18
		lblFind.Text = ML("Find") & ":"
		lblFind.Parent = @This
		
		' txtFind
		txtFind.Name = "txtFind"
		txtFind.Style = cbDropDown
		txtFind.SetBounds 66, 4, 142, 18
		txtFind.Anchor.Left = asAnchor
		txtFind.Text = ""
		txtFind.Parent = @This
		
		' txtReplace
		txtReplace.Name = "txtReplace"
		txtReplace.Style = cbDropDown
		txtReplace.Text = ""
		txtReplace.SetBounds 66, 35, 142, 18
		txtReplace.Anchor.Left = asAnchor
		txtReplace.Parent = @This
		
		chkMatchCase.Name = "chkMatchCase"
		chkMatchCase.SetBounds 283, 3, 34, 21
		chkMatchCase.Text = "Aa"
		chkMatchCase.Parent = @This
		
		' btnFind
		btnFind.Name = "btnFind"
		btnFind.Text = ">"
		btnFind.Default = True
		btnFind.SetBounds  359, 4, 40, 24
		btnFind.Parent = @This
		
		' btnFindPrev
		btnFindPrev.Name = "btnFindPrev"
		btnFindPrev.Text = "<"
		btnFindPrev.SetBounds  317, 4, 40, 24
		btnFindPrev.Parent = @This
		
		' btnCancel
		btnCancel.Name = "btnCancel"
		btnCancel.Text = ML("&Cancel")
		btnCancel.Anchor.Right = asAnchor
		btnCancel.SetBounds 250, 500, 100, 30
		btnCancel.Parent = @This
		btnFind.OnClick = @btnFind_Click_
		btnFindPrev.SubClass = False
		btnFindPrev.TabStop = True
		btnFindPrev.Grouped = False
		btnFindPrev.OnClick = @btnFindPrev_Click_
		btnCancel.OnClick = @btnCancel_Click_
		
		' lblTrack
		lblTrack.Name = "lblTrack"
		lblTrack.SetBounds  45, 22, 20, 17
		lblTrack.Parent = @This
		
		' TrackBar1
		TrackBar1.Name = "TrackBar1"
		TrackBar1.Text = "TrackBar1"
		TrackBar1.OnChange = @TrackBar1_Change_
		TrackBar1.MinValue = 150
		TrackBar1.MaxValue = 255
		TrackBar1.SetBounds  0, 22, 44, 14
		TrackBar1.Position = 210 ' This.Opacity
		TrackBar1.Parent = @This
		lblTrack.Text = WStr(CUInt(TrackBar1.Position/2.55))
		' lblReplace
		lblReplace.Name = "lblReplace"
		lblReplace.Text = ML("Replace") & ":"
		lblReplace.SetBounds 22, 42, 38, 18
		lblReplace.Parent = @This
		
		' btnReplace
		btnReplace.Name = "btnReplace"
		btnReplace.Text = ML("&Replace")
		btnReplace.SetBounds 215, 34, 99, 24
		btnReplace.Parent = @This
		
		' btnReplaceAll
		btnReplaceAll.Name = "btnReplaceAll"
		btnReplaceAll.Text = ML("Replace &All")
		btnReplaceAll.SetBounds 317, 34, 124, 24
		btnReplaceAll.Parent = @This
		
		' btnReplaceShow
		btnReplaceShow.Name = "btnReplaceShow"
		btnReplaceShow.Text = ">"
		btnReplaceShow.SetBounds 0, 0, 16, 24
		btnReplaceShow.Parent = @This
		
		btnReplace.Anchor.Left = AnchorStyle.asAnchor
		btnReplace.OnClick = @btnReplace_Click_
		btnReplaceAll.OnClick = @btnReplaceAll_Click_
		btnReplaceShow.OnClick = @btnReplaceShow_Click_
		
		' btnFindAll
		btnFindAll.Name = "btnFindAll"
		btnFindAll.Text = ML("All")
		btnFindAll.SetBounds 401, 4, 40, 24
		btnFindAll.OnClick = @btnFindAll_Click_
		btnFindAll.Parent = @This
		
		' cboFindRange
		With cboFindRange
			.Name = "cboFindRange"
			.Text = "cboFindRange"
			.AddItem ML("Procedure")
			.AddItem ML("Module")
			.AddItem ML("Project")
			.TabIndex = 17
			.SetBounds 215, 4, 62, 18
			.OnSelected = @cboFindRange_Selected_
			.Parent = @This
		End With
		
	End Constructor
	
	Private Sub frmFind.TrackBar1_Change_(ByRef Sender As TrackBar, Position As Integer)
		fFind.TrackBar1_Change(Sender, Position)
	End Sub
	
	Private Sub frmFind.btnFind_Click_(ByRef Sender As Control)
		fFind.btnFind_Click(Sender)
	End Sub
	
	Private Sub frmFind.btnFindAll_Click_(ByRef Sender As Control)
			fFind.btnFindAll_Click(Sender)
	End Sub
	
	Private Sub frmFind.btnFindPrev_Click_(ByRef Sender As Control)
		fFind.btnFindPrev_Click(Sender)
	End Sub
	
	Private Sub frmFind.btnReplace_Click_(ByRef Sender As Control)
		fFind.btnReplace_Click(Sender)
	End Sub
	
	Private Sub frmFind.btnReplaceAll_Click_(ByRef Sender As Control)
		fFind.btnReplaceAll_Click(Sender)
	End Sub
	
	Private Sub frmFind.btnReplaceShow_Click_(ByRef Sender As Control)
		fFind.btnReplaceShow_Click(Sender)
	End Sub
	
	Private Sub frmFind.btnCancel_Click_(ByRef Sender As Control)
		fFind.btnCancel_Click(Sender)
	End Sub
	
	Private Sub frmFind.Form_Show_(ByRef Sender As Form)
		fFind.Form_Show(Sender)
	End Sub
	
	Private Sub frmFind.Form_Close_(ByRef Sender As Control, ByRef Action As Integer)
		fFind.Form_Close(Sender, Action)
	End Sub
	
	Private Sub frmFind.Form_Create_(ByRef Sender As Control)
		fFind.Form_Create(Sender)
	End Sub
	
	Private Sub frmFind.cboFindRange_Selected_(ByRef Sender As ComboBoxEdit, ItemIndex As Integer)
		*Cast(frmFind Ptr, Sender.Designer).cboFindRange_Selected(Sender, ItemIndex)
	End Sub
	
	Destructor frmFind
		
	End Destructor
	
	#ifndef _NOT_AUTORUN_FORMS_
		fFind.Show
		App.Run
	#endif
'#End Region

Public Function frmFind.Find(Down As Boolean, bNotShowResults As Boolean = False) As Integer
	If txtFind.Text = "" OrElse mTabSelChangeByError Then Exit Function
	Dim tb As TabWindow Ptr = Cast(TabWindow Ptr, ptabCode->SelectedTab)
	If tb = 0 Then Exit Function
	Dim txt As EditControl Ptr = @tb->txtCode
	Dim Result As Integer
	Dim bMatchCase As Boolean = chkMatchCase.Checked
	Dim buff As WString Ptr
	Dim iStartChar As Integer, iStartLine As Integer
	Dim i As Integer
	If CInt(*gSearchSave <> txtFind.Text) Then FindAll plvSearch, 2,, True
	If Down Then
		If bNotShowResults Then
			iStartChar = 1
			iStartLine = 0
		Else
			Dim As Integer iSelStartLine, iSelEndLine, iSelStartChar, iSelEndChar
			txt->GetSelection iSelStartLine, iSelEndLine, iSelStartChar, iSelEndChar
			iStartChar = iSelEndChar + 1
			iStartLine = iSelEndLine
		End If
		For i = iStartLine To txt->LinesCount - 1
			buff = @txt->Lines(i)
			If bMatchCase Then
				Result = InStr(iStartChar, *buff, *gSearchSave)
			Else
				Result = InStr(iStartChar, LCase(*buff), LCase(*gSearchSave))
			End If
			If Result > 0 Then Exit For
			iStartChar = 1
		Next i
	Else
		If bNotShowResults Then
			iStartLine = txt->LinesCount - 1
			iStartChar = Len(txt->Lines(iStartLine))
		Else
			Dim As Integer iSelStartLine, iSelEndLine, iSelStartChar, iSelEndChar
			txt->GetSelection iSelStartLine, iSelEndLine, iSelStartChar, iSelEndChar
			iStartLine = iSelStartLine
			iStartChar = iSelStartChar
		End If
		For i = iStartLine To 0 Step -1
			buff = @txt->Lines(i)
			If i <> iStartLine Then iStartChar = Len(*buff)
			If bMatchCase Then
				Result = InStrRev(*buff, *gSearchSave, iStartChar)
			Else
				Result = InStrRev(LCase(*buff), LCase(*gSearchSave), iStartChar)
			End If
			If Result > 0 Then Exit For
		Next i
	End If
	If Result <> 0 Then
		txt->SetSelection i, i, Result - 1, Result + Len(*gSearchSave) - 1
		If txtFind.Contains(*gSearchSave)=False Then txtFind.AddItem *gSearchSave
		If plvSearch->ListItems.Count>0 Then
			This.Caption=ML("Find")+": "+  "1 of " + WStr(plvSearch->ListItems.Count)
		Else
			This.Caption=ML("Find")
		End If
	ElseIf bNotShowResults Then
		Return Result
	Else
		'If MessageBox(btnFind.Handle, @WStr("Izlash oxiriga yetdi, qaytadan izlashni xohlaysi"), @WStr("Izlash"), MB_YESNO) = IDYES Then
		'If MsgBox("Izlash oxiriga yetdi, qaytadan izlashni xohlaysi", "Izlash", MB_YESNO) = IDYES Then
		Result = Find(Down, True)
		If Result = 0 Then
			'ShowMessage("Izlanayotgan matn topilmadi!")
			This.Caption=ML("Find: No Results")
		End If
		'End If
	End If
	'txtFind.SetFocus 'David Change
	Return Result
End Function

Sub frmFind.FindInProj(ByRef lvSearchResult As ListView Ptr, ByRef tSearch As WString="", ByRef tn As TreeNode Ptr)
	Dim As WString * MAX_PATH f
	Dim As WString Ptr Buffout
	Dim As Integer Result, Pos1
	Dim As WString * 1024 Buff
	Dim As Integer iLine, iStart, Fn
	If tSearch = "" OrElse tn < 1 Then Exit Sub
	For i As Integer = 0 To tn->Nodes.Count - 1
		If FormClosing Then Exit For
		If tn->Nodes.Item(i)->ImageKey = "Opened" Then
			fFind.FindInProj lvSearchResult, tSearch, tn->Nodes.Item(i)
		Else
			If tn->Nodes.Item(i)->Tag <> 0 Then
				f = *Cast(ExplorerElement Ptr, tn->Nodes.Item(i)->Tag)->FileName
				If EndsWith(LCase(f), ".bas") OrElse EndsWith(LCase(f), ".bi") OrElse EndsWith(LCase(f), ".rc") OrElse EndsWith(LCase(f), ".inc") _
					OrElse EndsWith(LCase(f), ".txt") OrElse EndsWith(LCase(f), ".frm") OrElse EndsWith(LCase(f), ".html") _
					OrElse EndsWith(LCase(f), ".vfp") OrElse EndsWith(LCase(f), ".htm") OrElse EndsWith(LCase(f), ".xml") _
					OrElse EndsWith(LCase(f), ".c") OrElse EndsWith(LCase(f), ".h") OrElse EndsWith(LCase(f), ".cpp") OrElse EndsWith(LCase(f), ".java") Then
					Result = -1: Fn = FreeFile_
					Result = Open(f For Input Encoding "utf-8" As #Fn)
					If Result <> 0 Then Result = Open(f For Input Encoding "utf-16" As #Fn)
					If Result <> 0 Then Result = Open(f For Input Encoding "utf-32" As #Fn)
					If Result <> 0 Then Result = Open(f For Input As #Fn)
					If Result = 0 Then
						iLine = 0
						Do Until EOF(Fn)
							Line Input #Fn, Buff
							iLine += 1
							If chkMatchCase.Checked Then
								Pos1 = InStr(Buff, tSearch)
							Else
								Pos1 = InStr(LCase(Buff), LCase(tSearch))
							End If
							While Pos1 > 0
								ThreadsEnter
								lvSearchResult->ListItems.Add Buff
								lvSearchResult->ListItems.Item(lvSearchResult->ListItems.Count - 1)->Text(1) = WStr(iLine)
								lvSearchResult->ListItems.Item(lvSearchResult->ListItems.Count - 1)->Text(2) = WStr(Pos1)
								lvSearchResult->ListItems.Item(lvSearchResult->ListItems.Count - 1)->Text(3) = f
								pfrmMain->Update
								ThreadsLeave
								Pos1 = InStr(Pos1 + Len(tSearch), LCase(Buff), LCase(tSearch))
							Wend
						Loop
					Else
						'MsgBox ML("Open file failure!") &  " " & ML("in function") & " frmFindInFiles.Find"  & Chr(13,10) & "  " & Path & f
					End If
					CloseFile_(Fn)
				End If
			End If
		End If
	Next
End Sub

Private Sub frmFind.ReplaceInProj(ByRef tSearch As WString="", ByRef tReplace As WString="", ByRef tn As TreeNode Ptr)
	Dim BuffOut As WString Ptr
	Dim As WString * MAX_PATH FNameOpen, f
	Dim As Integer Result, Pos1
	Dim As WString * 1024 Buff
	Dim As Integer iLine, iStart
	Dim As Integer Fn
	Dim SubStr() As WString Ptr
	Dim As WString * 5 tML = WChr(77) & WChr(76) & WChr(40)& WChr(34)
	If tSearch = "" OrElse tn < 1 Then Exit Sub
	If LCase(tSearch) = LCase(tReplace) Then WLet(BuffOut, "File")
	For i As Integer = 0 To tn->Nodes.Count - 1
		If tn->Nodes.Item(i)->ImageKey = "Opened" Then
			fFind.ReplaceInProj tSearch, tReplace, tn->Nodes.Item(i)
		Else
			If tn->Nodes.Item(i)->Tag <> 0 Then
				f = *Cast(ExplorerElement Ptr, tn->Nodes.Item(i)->Tag)->FileName
				If EndsWith(LCase(f), ".bas") OrElse EndsWith(LCase(f), ".bi") OrElse EndsWith(LCase(f), ".rc") OrElse EndsWith(LCase(f), ".inc") _
					OrElse EndsWith(LCase(f), ".txt") OrElse EndsWith(LCase(f), ".log") OrElse EndsWith(LCase(f), ".lng") _
					OrElse EndsWith(LCase(f), ".vfp") OrElse EndsWith(LCase(f), ".vfs") OrElse EndsWith(LCase(f), ".xml") _
					OrElse EndsWith(LCase(f), ".c") OrElse EndsWith(LCase(f), ".h") OrElse EndsWith(LCase(f), ".cpp") OrElse EndsWith(LCase(f), ".java") Then
					If LCase(tML) <> LCase(tReplace) Then
						FNameOpen = GetBakFileName(f)
						'David Change https://www.freebasic.net/forum/viewtopic.php?f=2&t=27370&p=257529&hilit=FileCopy#p257529
						#ifdef __USE_GTK__
							FileCopy  f, FNameOpen  'Function FileCopy suport unicode file name in Linux, but And FileExist Do Not working properly.
						#else
							CopyFileW f, FNameOpen, False
						#endif
					Else
						FNameOpen = f
					End If
					Result = -1: Fn = FreeFile_
					Result = Open(FNameOpen For Input Encoding "utf-8" As #Fn)
					If Result <> 0 Then Result = Open(FNameOpen For Input Encoding "utf-16" As #Fn)
					If Result <> 0 Then Result = Open(FNameOpen For Input Encoding "utf-32" As #Fn)
					If Result <> 0 Then Result = Open(FNameOpen For Input As #Fn)
					If Result = 0 Then
						iLine = 0
						If LCase(tSearch) <> LCase(tReplace) Then WLet(BuffOut, "")
						Do Until EOF(Fn)
							Line Input #Fn, Buff
							iLine += 1
							If chkMatchCase.Checked Then
								Pos1 = InStr(Buff, tSearch)
							Else
								Pos1 = InStr(LCase(Buff), LCase(tSearch))
							End If
							If Pos1 > 0 Then
								If LCase(tSearch) = LCase(tReplace) Then
									Var NumS = StringSubStringAll(Buff,tML, WChr(34) & ")",SubStr())
									For i As Integer =0 To NumS-1
										If InStr(*BuffOut, Chr(13,10) & *SubStr(i))<=0 Then
											WAdd BuffOut, Chr(13,10) & *SubStr(i)
											If InStr(*SubStr(i), "&")>0 Then WAdd BuffOut, Chr(13,10) & Replace(*SubStr(i),"&","")
										End If
										Deallocate SubStr(i): SubStr(i)=0
									Next
									Erase SubStr
								Else
									If *BuffOut="" Then
										WLet(BuffOut, Replace(Buff, tSearch, tReplace, , , chkMatchCase.Checked))
									Else
										WAdd BuffOut, Chr(13,10) & Replace(Buff, tSearch, tReplace,,, chkMatchCase.Checked)
									End If
								End If
							ElseIf LCase(tSearch) <> LCase(tReplace) Then
								If *BuffOut="" Then
									WLet(BuffOut, Buff)
								Else
									WAdd BuffOut, Chr(13,10) & Buff
								End If
							End If
							While Pos1 > 0
								ThreadsEnter
								plvSearch->ListItems.Add Buff
								plvSearch->ListItems.Item(plvSearch->ListItems.Count - 1)->Text(1) = WStr(iLine)
								plvSearch->ListItems.Item(plvSearch->ListItems.Count - 1)->Text(2) = WStr(Pos1)
								plvSearch->ListItems.Item(plvSearch->ListItems.Count - 1)->Text(3) =  f
								pfrmMain->Update
								ThreadsLeave
								Pos1 = InStr(Pos1 + Len(tSearch), LCase(Buff), LCase(tSearch))
							Wend
						Loop
						If LCase(tSearch) <> LCase(tReplace) Then
							Var Fn1 = FreeFile_
							If Open(f For Output Encoding "utf-8" As #Fn1) = 0 Then
								Print #Fn1, *BuffOut
							Else
								MsgBox ML("Open file failure!") & " " & ML("in function") & " frmFindInFiles.ReplaceInFile" & Chr(13,10) & "  " & f
							End If
							CloseFile_(Fn1)
						End If
					End If
					CloseFile_(Fn)
				End If
			End If
		End If
	Next
	
	If LCase(tML) = LCase(tReplace) Then
		Fn = FreeFile_
		If Open(ExePath & "\Languages.txt" For Output Encoding "utf-8" As #Fn) = 0 Then
			Print #Fn, *BuffOut
		End If
		CloseFile_(Fn)
	End If
	Deallocate BuffOut
End Sub

Sub FindSubProj(Param As Any Ptr)
	MutexLock tlockToDo
	ThreadsEnter
	plvSearch->ListItems.Clear
	StartProgress
	With fFind
		.btnFind.Enabled = False
		.btnFindPrev.Enabled = False
		.btnReplace.Enabled = False 
		.btnReplaceAll.Enabled = False 
		ThreadsLeave
		If *gSearchSave = WChr(39) + WChr(84) + "ODO" Then
			.FindInProj plvToDo, *gSearchSave, Cast(TreeNode Ptr,Param)
		Else
			.FindInProj plvSearch, .txtFind.Text, Cast(TreeNode Ptr,Param)
		End If
		ThreadsEnter
		.btnFind.Enabled = True
		.btnFindPrev.Enabled = True
		.btnReplace.Enabled = True 
		.btnReplaceAll.Enabled = True
		StopProgress
		If *gSearchSave = WChr(39)+ WChr(84)+"ODO" Then
			ptabBottom->Tabs[3]->Caption = ML("TODO") & " (" & plvToDo->ListItems.Count & " " & ML("Pos") & ")"
			WLet(gSearchSave, "")
			.cboFindRange.ItemIndex = 2
		Else
			WLet(gSearchSave, .txtFind.Text)
			ptabBottom->Tabs[2]->Caption = ML("Find") & " (" & plvSearch->ListItems.Count & " " & ML("Pos") & ")"
		End If
		If .Visible Then 'David Change
			.Caption = ML("Find") + ": " + WStr(gSearchItemIndex + 1) + " of " + WStr(plvSearch->ListItems.Count)
		End If
	End With
	ThreadsLeave
	MutexUnlock tlockToDo
End Sub

Sub ReplaceSubProj(Param As Any Ptr)
	MutexLock tlockToDo
	ThreadsEnter
	plvSearch->ListItems.Clear
	StartProgress
	fFind.btnFind.Enabled = False
	fFind.btnFindPrev.Enabled = False
	fFind.btnReplace.Enabled = False
	fFind.btnReplaceAll.Enabled = False
	ThreadsLeave
	fFind.ReplaceInProj fFind.txtFind.Text, fFind.txtReplace.Text, Cast(TreeNode Ptr, Param)
	ThreadsEnter
	fFind.btnFind.Enabled = True
	fFind.btnFindPrev.Enabled = True
	fFind.btnReplace.Enabled = True
	fFind.btnReplaceAll.Enabled = True
	StopProgress
	WLet(gSearchSave, fFind.txtFind.Text)
	ptabBottom->Tabs[2]->Caption = ML("Replace") & " (" & plvSearch->ListItems.Count & " " & ML("Pos") & ")"
	ThreadsLeave
	MutexUnlock tlockToDo
End Sub

Private Sub frmFind.btnFind_Click(ByRef Sender As Control)
	If Trim(txtFind.Text) = "" Then Exit Sub
	If Not txtFind.Contains(txtFind.Text) Then
		txtFind.AddItem txtFind.Text
	End If
	If CInt(*gSearchSave <> txtFind.Text) Then FindAll plvSearch, 2, , False
	This.Caption = ML("Find: No Results")
	If plvSearch->ListItems.Count < 1 Then Exit Sub
	Dim As Integer preLine
	If gSearchItemIndex >= plvSearch->ListItems.Count - 1 Then
		gSearchItemIndex = 0: ActionReplace = 0: preLine = -1
	Else
		preLine= Val(plvSearch->ListItems.Item(gSearchItemIndex)->Text(1))
		gSearchItemIndex = gSearchItemIndex+1
	End If
	If plvSearch->ListItems.Count > 0 Then
		This.Caption = IIf(ActionReplace > 0, ML("Replace"), ML("Find")) + ": " + WStr(gSearchItemIndex + 1) + " of " + WStr(plvSearch->ListItems.Count)
		Dim Item As ListViewItem Ptr = plvSearch->ListItems.Item(gSearchItemIndex)
		If preLine = Val(Item->Text(1)) AndAlso ActionReplace > 0 Then
			SelectSearchResult (Item->Text(3), Val(Item->Text(1)), Val(Item->Text(2)) + ActionReplace * (Len(txtReplace.Text) - Len(txtFind.Text)), Len(*gSearchSave), item->Tag)
		Else
			ActionReplace = 0
			SelectSearchResult (Item->Text(3), Val(Item->Text(1)), Val(Item->Text(2)), Len(*gSearchSave), Item->Tag)
		End If
	End If
End Sub
Private Sub frmFind.btnFindPrev_Click(ByRef Sender As Control)
	If Trim(txtFind.Text) = "" Then Exit Sub
	If CInt(*gSearchSave <> txtFind.Text) Then FindAll plvSearch, 2,, False
	This.Caption=ML("Find: No Results")
	If plvSearch->ListItems.Count<1 Then Exit Sub
	If gSearchItemIndex = 0 Then
		gSearchItemIndex = plvSearch->ListItems.Count-1
	Else
		gSearchItemIndex -= 1
	End If
	If plvSearch->ListItems.Count>0 Then
		Dim Item As ListViewItem Ptr = plvSearch->ListItems.Item(gSearchItemIndex)
		SelectSearchResult(Item->Text(3), Val(Item->Text(1)), Val(Item->Text(2)), Len(*gSearchSave), Item->Tag)
		This.Caption=ML("Find")+": " + WStr(gSearchItemIndex+1) + " of " + WStr(plvSearch->ListItems.Count)
	End If
End Sub
Private Function frmFind.FindAll(ByRef lvSearchResult As ListView Ptr, tTabIndex As Integer =2, ByRef tSearch As WString ="", bNotShowResults As Boolean = False) As Integer
	If mTabSelChangeByError Then Return -1
	If Len(tSearch)>0 Then
		txtFind.Text = tSearch
		If Not txtFind.Contains(tSearch) Then txtFind.AddItem tSearch
		If Len(txtReplace.Text)>0 AndAlso (Not txtReplace.Contains(txtReplace.Text)) Then txtReplace.AddItem txtReplace.Text
	End If
	Dim Search As WString Ptr = @txtFind.Text
	If tTabIndex <> 4 AndAlso (Len(*Search)< 1 OrElse CInt(*gSearchSave = *Search)) Then Return -1
	If tTabIndex =2 Then
		ptabBottom->Tabs[tTabIndex]->Caption = ML("Find")
	Else
		ptabBottom->Tabs[tTabIndex]->Caption = ML("TODO")
	End If
	gSearchTabIndex = ptabCode->SelectedTabIndex
	pTabBottom->Tabs[tTabIndex]->SelectTab
	Dim As treenode Ptr tn = IIf(pTabLeft->SelectedTabIndex = 2, MainNode, MainNode)
	Dim bMatchCase As Boolean = chkMatchCase.Checked
	Dim As WString Ptr buff
	Dim As Integer Pos1=0
	If cboFindRange.ItemIndex = 2 Then
		If tn > 0 Then
			Dim As ExplorerElement Ptr ee = Tn->Tag
			If ee > 0 AndAlso *ee->FileName <> "" Then
				lvSearchResult->ListItems.Clear
				gSearchItemIndex = 0
				ThreadCreate_(@FindSubProj, Tn)
				wLet(gSearchSave, *Search)
			End If
		End If
	Else
		Dim tb As TabWindow Ptr = Cast(TabWindow Ptr, ptabCode->SelectedTab)
		If tb = 0 Then Return -1
		Dim As Integer iSelStartLine, iSelEndLine, iSelStartChar, iSelEndChar
		If cboFindRange.ItemIndex = 0 Then
			tb->txtCode.GetSelection iSelStartLine, iSelEndLine, iSelStartChar, iSelEndChar, True
		Else
			iSelStartLine = 0 : iSelEndLine = tb->txtCode.LinesCount - 1
		End If
		lvSearchResult->ListItems.Clear
		gSearchItemIndex = 0
		wLet(gSearchSave, *Search)
		For i As Integer = iSelStartLine To iSelEndLine
			buff = @tb->txtCode.Lines(i)
			If bMatchCase Then
				Pos1 = InStr(*buff, *Search)
			Else
				Pos1 = InStr(LCase(*buff), LCase(*Search))
			End If
			While Pos1 > 0
				If Not bNotShowResults Then
					lvSearchResult->ListItems.Add *buff
					lvSearchResult->ListItems.Item(lvSearchResult->ListItems.Count - 1)->Text(1) = WStr(i + 1)
					lvSearchResult->ListItems.Item(lvSearchResult->ListItems.Count - 1)->Text(2) = WStr(Pos1)
					lvSearchResult->ListItems.Item(lvSearchResult->ListItems.Count - 1)->Text(3) = tb->FileName
					lvSearchResult->ListItems.Item(lvSearchResult->ListItems.Count - 1)->Tag = tb
				End If
				If i < iSelStartLine Then gSearchItemIndex = lvSearchResult->ListItems.Count - 1
				If bMatchCase Then
					Pos1 = InStr(Pos1 + Len(*Search), *buff, *Search)
				Else
					Pos1 = InStr(Pos1 + Len(*Search), LCase(*buff), LCase(*Search))
				End If
			Wend
		Next
	End If
	
	If Not bNotShowResults Then
		ptabBottom->SelectedTabIndex = tTabIndex
		Dim i As Integer
		If lvSearchResult->ListItems.Count = 0 Then
			This.Caption=ML("Find: No Results")
		Else
			If lvSearchResult->ListItems.Count > 0 Then
				This.Caption=ML("Find")+": 1 of " + WStr(lvSearchResult->ListItems.Count)
			Else
				This.Caption=ML("Find")
			End If
		End If
		If tTabIndex =2 Then
			ptabBottom->Tabs[tTabIndex]->Caption = ML("Find") & " (" & lvSearchResult->ListItems.Count & " " & ML("Pos") & ")"
		Else
			ptabBottom->Tabs[tTabIndex]->Caption = ML("TODO") & " (" & lvSearchResult->ListItems.Count & " " & ML("Pos") & ")"
		End If
	End If
End Function

Private Sub frmFind.btnReplace_Click(ByRef Sender As Control)
	If Len(txtFind.Text)<1 Then Exit Sub
	Dim tb As TabWindow Ptr = Cast(TabWindow Ptr, ptabCode->SelectedTab)
	If tb = 0 Then Exit Sub
	Dim txt As EditControl Ptr = @tb->txtCode
	If LCase(txt->SelText) = LCase(txtFind.Text) Then
		ActionReplace += 1
		txt->SelText = txtReplace.Text
		This.btnFind_Click(Sender)
		If txtReplace.Contains(txtReplace.Text)=False Then txtReplace.AddItem txtReplace.Text
	Else
		This.btnFind_Click(Sender)
	End If
	This.Caption=Replace(This.Caption,ML("Find"),ML("Replace"))
	btnFind.SetFocus  'David Change
End Sub

Private Sub frmFind.btnReplaceAll_Click(ByRef Sender As Control)
	If Len(txtFind.Text)<1 Then Exit Sub
	Dim Result As Boolean
	Dim bMatchCase As Boolean = chkMatchCase.Checked
	Dim As WString Ptr buff
	Dim Search As WString Ptr =@txtFind.Text
	Dim tReplace As WString Ptr =@txtReplace.Text
	Dim As Integer Pos1 = 0, l = Len(*tReplace)
	If cboFindRange.ItemIndex = 2  Then
		Dim As TreeNode Ptr Tn =IIf(ptabLeft->SelectedTabIndex =2, MainNode, MainNode)
		If Tn > 0 Then
			Dim As ExplorerElement Ptr ee = Tn->Tag
			If ee > 0 AndAlso *ee->FileName <> "" Then
				ThreadCreate_(@ReplaceSubProj,Tn)
			End If
		End If
	Else
		Dim tb As TabWindow Ptr = Cast(TabWindow Ptr, ptabCode->SelectedTab)
		If tb = 0 Then Exit Sub
		Dim txt As EditControl Ptr = @tb->txtCode
		Dim As EditControlLine Ptr ECLine
		tb->txtCode.Changing "ReplaceAll"
		plvSearch->ListItems.Clear
		gSearchItemIndex = 0
		For i As Integer = 0 To tb->txtCode.LinesCount - 1
			buff = @tb->txtCode.Lines(i)
			ECLine = tb->txtCode.FLines.Items[i]
			If bMatchCase Then
				Pos1 = InStr(*buff, *Search)
			Else
				Pos1 = InStr(LCase(*buff), LCase(*Search))
			End If
			While Pos1 > 0
				plvSearch->ListItems.Add *buff
				plvSearch->ListItems.Item(plvSearch->ListItems.Count - 1)->Text(1) = WStr(i + 1)
				plvSearch->ListItems.Item(plvSearch->ListItems.Count - 1)->Text(2) = WStr(Pos1)
				plvSearch->ListItems.Item(plvSearch->ListItems.Count - 1)->Text(3) = tb->FileName
				plvSearch->ListItems.Item(plvSearch->ListItems.Count - 1)->Tag = tb
				WLet(ECLine->Text, ..Left(*buff, Pos1 - 1) & *tReplace & Mid(*buff, Pos1 + Len(*Search)))
				ECLine->Ends.Clear
				ECLine->EndsCompleted = False
				buff = @tb->txtCode.Lines(i)
				If bMatchCase Then
					Pos1 = InStr(Pos1 + Len(*tReplace), *buff, *Search)
				Else
					Pos1 = InStr(Pos1 + Len(*tReplace), LCase(*buff), LCase(*Search))
				End If
			Wend
		Next i
		tb->txtCode.Changed "ReplaceAll"
		If plvSearch->ListItems.Count=0 Then
			This.Caption=ML("Find: No Results")
		Else
			This.Caption=ML("Replace") + ": 1 of " + WStr(plvSearch->ListItems.Count)
		End If
	End If
	WLet(gSearchSave, *Search)
	btnFind.SetFocus  'David Change
End Sub
Private Sub frmFind.btnReplaceShow_Click(ByRef Sender As Control)
	'Sender.Center
	If pClipboard > 0 AndAlso Len(*gSearchSave) > 0 Then pClipboard->SetAsText *gSearchSave
	mFormFind = Not mFormFind
	If mFormFind = True Then
		'SetBounds Left, Top, Width,65
		#ifdef __USE_GTK__
			Height = 60
		#else
			Height = 65
		#endif
		btnReplace.Enabled = False
		btnReplaceAll.Enabled = False
	Else
		Height = 95
		btnReplace.Enabled = True
		btnReplaceAll.Enabled = True
	End If
	btnReplaceShow.Caption=IIf(mFormFind,">","<")
	btnFind.SetFocus  'David Change
End Sub

Private Sub frmFind.btnCancel_Click(ByRef Sender As Control)
	This.ModalResult = ModalResults.Cancel
	This.CloseForm
End Sub

Private Sub frmFind.Form_Show(ByRef Sender As Form)
	If mFormFind = True Then
		This.Caption=ML("Find")
		#ifdef __USE_GTK__
			This.Height = 58
			SetBounds pfrmMain->Left + pfrmMain->Width - This.Width - 5, pfrmMain->Top + 20, This.Width, 58
		#else
			This.Height = 65
			SetBounds pfrmMain->Left + pfrmMain->Width - This.Width - 5, pfrmMain->Top + 20, This.Width, 65
		#endif
		btnReplace.Enabled = False
		btnReplaceAll.Enabled = False
	Else
		This.Caption=ML("Replace")
		This.Height = 95
		SetBounds pfrmMain->Left + pfrmMain->Width - This.Width - 5, pfrmMain->Top + 20, This.Width, 95
		btnReplace.Enabled = True
		btnReplaceAll.Enabled = True
	End If
	'TODO David Change For couldn't minimize Width of the Command buttom
	#ifdef __USE_GTK__
		btnReplaceShow.Visible = False
		TrackBar1.Visible = False
		lblTrack.Visible = False
	#else
		btnReplaceShow.Width=18
	#endif
	'btnFindAll.Visible = False
	Opacity = 230
	TrackBar1.Position = 230
	lblTrack.Text = WStr(CUInt(TrackBar1.Position / 2.55))
	
	Dim As UString SelText
	If ptabCode Then
		Dim As TabWindow Ptr tb = Cast(TabWindow Ptr, ptabCode->SelectedTab)
		If tb Then
			SelText = tb->txtCode.SelText
		End If
	End If
	If SelText = "" Then
		SelText = pClipboard->GetAsText
	End If
	If SelText = "" Then
		cboFindRange.ItemIndex = 1
	Else
		'David Change For limited the Muilti Line
		Var Posi = InStr(SelText, Chr(13)) - 1
		If Posi < 1 Then Posi = InStr(SelText, Chr(10)) - 1
		If Posi < 1 Then Posi = Len(SelText)
		txtFind.Text = ..Left(SelText, Posi)
	End If
	txtFind.SetFocus
End Sub

Private Sub frmFind.Form_Close(ByRef Sender As Control, ByRef Action As Integer)
	Dim iCount As Integer=-1
	If txtFind.ItemCount>0 Then
		For i As Integer =txtFind.ItemCount-1 To 0 Step -1
			iCount+=1
			piniSettings->WriteString("Find", "Find_"+WStr(iCount), txtFind.Item(i))
			If iCount>=9 Then Exit For
		Next
	End If
	If txtReplace.ItemCount>0 Then
		iCount=-1
		For i As Integer =txtReplace.ItemCount-1 To 0 Step -1
			iCount+=1
			piniSettings->WriteString("Replace", "Replace_"+WStr(iCount), txtReplace.Item(i))
			If iCount>=9 Then Exit For
		Next
	End If
	btnFind.SetFocus  'David Change
End Sub

Private Sub frmFind.TrackBar1_Change(ByRef Sender As TrackBar,Position As Integer)
	If Sender.Position<100 Then	Sender.Position =100 'David Change For limitation
	Opacity = Sender.Position
	lblTrack.Text = WStr(CUInt(Sender.Position/2.55))
End Sub

Private Sub frmFind.btnFindAll_Click(ByRef Sender As Control)
	If Not txtFind.Contains(txtFind.Text) Then
		txtFind.AddItem txtFind.Text
	End If
	FindAll plvSearch, 2, , False
End Sub

Private Sub frmFind.Form_Create(ByRef Sender As Control)
	Dim tmpStr As WString Ptr
	txtFind.Clear
	txtReplace.Clear
	For i As Integer =0 To 9
		WLet(tmpStr, piniSettings->ReadString("Find", "Find_" + WStr(i), ""))
		If CInt(Trim(*tmpStr)<>"") Then txtFind.AddItem *tmpStr
	Next
	For i As Integer =0 To 9
		WLet(tmpStr, piniSettings->ReadString("Replace", "Replace_"+WStr(i), ""))
		If CInt(Trim(*tmpStr)<>"") Then txtReplace.AddItem *tmpStr
	Next
	cboFindRange.ItemIndex = 1
	WDeAllocate tmpStr
End Sub

Private Sub frmFind.cboFindRange_Selected(ByRef Sender As ComboBoxEdit, ItemIndex As Integer)
	Static As Integer ItemIndexSave
	If ItemIndexSave <> ItemIndex Then
		WLet(gSearchSave, "")
		ItemIndexSave = ItemIndex
	End If
End Sub


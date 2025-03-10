﻿'#########################################################
'#  frmPath.bas                                          #
'#  This file is part of VisualFBEditor                  #
'#  Authors: Xusinboy Bekchanov (bxusinboy@mail.ru)      #
'#########################################################

#include once "frmPath.bi"
#include once "frmImageManager.bi"

'#Region "Form"
	Constructor frmPath
		' frmPath
		With This
			.Name = "frmPath"
			.Text = ML("Path")
			.StartPosition = FormStartPosition.CenterParent
			.BorderStyle = FormBorderStyle.FixedDialog
			.MaximizeBox = False
			.MinimizeBox = False
			.Designer = @This
			.OnShow = @Form_Show_
			.OnClose = @Form_Close_
			.SetBounds 0, 0, 462, 177
		End With
		' cmdCancel
		With cmdCancel
			.Name = "cmdCancel"
			.Text = ML("Cancel")
			.SetBounds 336, 116, 112, 24
			.Designer = @This
			.OnClick = @cmdCancel_Click_
			.Parent = @This
		End With
		' txtVersion
		With txtVersion
			.Name = "txtVersion"
			.Text = ""
			.SetBounds 100, 48, 348, 24
			.Parent = @This
		End With
		' lblVersion
		With lblVersion
			.Name = "lblVersion"
			.Text = ML("Version") & ":"
			.SetBounds 8, 50, 84, 24
			.Parent = @This
		End With
		' lblPath
		With lblPath
			.Name = "lblPath"
			.Text = ML("Path") & ":"
			.SetBounds 8, 18, 84, 24
			.Parent = @This
		End With
		' txtPath
		With txtPath
			.Name = "txtPath"
			.Text = ""
			.SetBounds 100, 16, 316, 24
			.Parent = @This
		End With
		' cmdPath
		With cmdPath
			.Name = "cmdPath"
			.Text = "..."
			.SetBounds 416, 16, 32, 24
			.Caption = "..."
			.Designer = @This
			.OnClick = @cmdPath_Click_
			.Parent = @This
		End With
		' cmdOK
		With cmdOK
			.Name = "cmdOK"
			.Text = ML("OK")
			.SetBounds 216, 116, 112, 24
			.Designer = @This
			.OnClick = @cmdOK_Click_
			.Parent = @This
		End With
		' lblCommandLine
		With lblCommandLine
			.Name = "lblCommandLine"
			.Text = ML("Command line") & ":"
			.SetBounds 8, 82, 88, 24
			.Parent = @This
		End With
		' txtCommandLine
		With txtCommandLine
			.Name = "txtCommandLine"
			.SetBounds 100, 80, 128, 24
			.Text = ""
			.Parent = @This
		End With
		' lblExtensions
		With lblExtensions
			.Name = "lblExtensions"
			.Text = ML("Extensions") & ":"
			.SetBounds 238, 82, 88, 24
			.Caption = ML("Extensions") & ":"
			.Parent = @This
		End With
		' txtExtensions
		With txtExtensions
			.Name = "txtExtensions"
			.SetBounds 320, 80, 128, 24
			.Text = ""
			.Parent = @This
		End With
		' cboType
		With cboType
			.Name = "cboType"
			.Text = ""
			.TabIndex = 11
			.SetBounds 100, 80, 130, 21
			.Visible = False
			.Parent = @This
		End With
	End Constructor
	
	Dim Shared frPath As frmPath
	Dim Shared frPathImageList As frmPath
	pfPath = @frPath
	pfPathImageList = @frPathImageList
'#End Region

Private Sub frmPath.cmdOK_Click_(ByRef Sender As Control)
	*Cast(frmPath Ptr, Sender.Designer).cmdOK_Click(Sender)
End Sub
Private Sub frmPath.cmdOK_Click(ByRef Sender As Control)
	If Not ChooseFolder AndAlso Trim(txtVersion.Text) = "" Then
		MsgBox ML("Enter version of program!")
		This.BringToFront()
		Exit Sub
	ElseIf Trim(This.txtPath.Text) = "" Then
		MsgBox ML("Select path of program!")
		This.BringToFront()
		Exit Sub
	End If
	txtCommandLineText = txtCommandLine.Text
	txtExtensionsText = txtExtensions.Text
	cboTypeText = cboType.Text
	This.ModalResult = ModalResults.OK
	This.CloseForm
End Sub

Private Sub frmPath.cmdCancel_Click_(ByRef Sender As Control)
	*Cast(frmPath Ptr, Sender.Designer).cmdCancel_Click(Sender)
End Sub
Private Sub frmPath.cmdCancel_Click(ByRef Sender As Control)
	This.ModalResult = ModalResults.Cancel
	This.CloseForm
End Sub

Private Sub frmPath.cmdPath_Click_(ByRef Sender As Control)
	*Cast(frmPath Ptr, Sender.Designer).cmdPath_Click(Sender)
End Sub
Private Sub frmPath.cmdPath_Click(ByRef Sender As Control)
	With This
		If .WithKey AndAlso .cboType.ItemIndex = 0 Then
			If pfImageManager->ShowModal(*pfrmMain) = ModalResults.OK Then
				If pfImageManager->SelectedItem <> 0 Then
					.txtPath.Text = pfImageManager->SelectedItem->Text(0)
					.txtVersion.Text = .txtPath.Text
				End If
			End If
		Else
			Dim As UString FolderName
			If .WithType Then
				FolderName = GetFolderName(.ExeFileName)
			Else
				FolderName = GetFolderName(pApp->FileName)
			End If
			If .ChooseFolder Then
				.BrowseD.InitialDir = GetFullPath(.txtPath.Text)
				If .BrowseD.Execute Then
					If FolderName <> "" AndAlso StartsWith(.BrowseD.Directory, FolderName) Then
						.txtPath.Text = "." & Slash & Mid(.BrowseD.Directory, Len(FolderName) + 1)
					Else
						.txtPath.Text = .BrowseD.Directory
					End If
				End If
			Else
				.OpenD.Filter = ML("All Files") & "|*.*;"
				If .OpenD.Execute Then
					If FolderName <> "" AndAlso StartsWith(.OpenD.FileName, FolderName) Then
						.txtPath.Text = "." & Slash & Mid(.OpenD.FileName, Len(FolderName) + 1)
					Else
						.txtPath.Text = .OpenD.FileName
					End If
					If EndsWith(.OpenD.FileName, ".chm") OrElse .SetFileNameToVersion Then
						.txtVersion.Text = ..Left(GetFileName(.OpenD.FileName), Len(GetFileName(.OpenD.FileName)) - 4)
					Else
						.txtVersion.Text = GetFileName(GetFolderName(.OpenD.FileName, False))
						If .txtVersion.Text = "bin" Then
							.txtVersion.Text = GetFileName(GetFolderName(GetFolderName(.OpenD.FileName, False), False))
						End If
					End If
					If .WithType Then
						If EndsWith(LCase(.OpenD.FileName), ".bmp") Then
							.cboType.ItemIndex = 0
						ElseIf EndsWith(LCase(.OpenD.FileName), ".cur") Then
							.cboType.ItemIndex = 1
						ElseIf EndsWith(LCase(.OpenD.FileName), ".ico") Then
							.cboType.ItemIndex = 2
						ElseIf EndsWith(LCase(.OpenD.FileName), ".png") Then
							.cboType.ItemIndex = 3
						Else
							.cboType.ItemIndex = 4
						End If
					End If
				End If
			End If
		End If
		.BringToFront()
	End With
End Sub

Private Sub frmPath.Form_Show_(ByRef Sender As Form)
	*Cast(frmPath Ptr, Sender.Designer).Form_Show(Sender)
End Sub
Private Sub frmPath.Form_Show(ByRef Sender As Form)
	lblVersion.Visible = (Not WithoutVersion) AndAlso Not ChooseFolder
	txtVersion.Visible = (Not WithoutVersion) AndAlso Not ChooseFolder
	lblCommandLine.Visible = Not (WithoutCommandLine OrElse ChooseFolder)
	txtCommandLine.Visible = Not (WithoutCommandLine OrElse ChooseFolder OrElse WithType)
	lblExtensions.Visible = WithExtensions
	txtExtensions.Visible = WithExtensions
	cboType.Visible = WithType
	lblPath.Text = IIf(WithKey, ML("Resource Name / Path") & ":", ML("Path") & ":")
	lblVersion.Text = IIf(WithType, IIf(WithKey, ML("Key") & ":", ML("Resource Name") & ":"), ML("Version") & ":")
	lblCommandLine.Text = IIf(WithType, ML("Type") & ":", ML("Command line") & ":")
	txtCommandLineText = ""
	txtExtensionsText = ""
	cboTypeText = ""
End Sub

Private Sub frmPath.Form_Close_(ByRef Sender As Form, ByRef Action As Integer)
	*Cast(frmPath Ptr, Sender.Designer).Form_Close(Sender, Action)
End Sub
Private Sub frmPath.Form_Close(ByRef Sender As Form, ByRef Action As Integer)
	ChooseFolder = False
	WithoutVersion = False
	WithoutCommandLine = False
	WithExtensions = False
	WithType = False
End Sub

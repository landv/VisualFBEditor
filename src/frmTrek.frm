﻿#include once "frmTrek.bi"

'#Region "Form"
	Constructor frmTrek
		LoadLanguageTexts
		' frmTrek
		With This
			.Name = "frmTrek"
			.Text = ML("Trek")
			#ifdef __USE_GTK__
				.Icon.LoadFromFile(ExePath & "/Resources/VisualFBEditor.ico")
			#else
				.Icon.LoadFromResourceID(1)
			#endif
			.MinimizeBox = False
			.BorderStyle = FormBorderStyle.Sizable
			.StartPosition = FormStartPosition.CenterParent
			.OnShow = @Form_Show
			.DefaultButton = @cmdOK
			.CancelButton = @cmdCancel
			.SetBounds 0, 0, 840, 276
		End With
		' lvTrek
		With lvTrek
			.Name = "lvTrek"
			.SetBounds 8, 8, 808, 168
			.Columns.Add ML("Name"), , 150, cfLeft
			.Columns.Add ML("Parameters"), , 150, cfLeft
			.Columns.Add ML("Line"), , 50, cfRight
			.Columns.Add ML("File"), , 400, cfLeft
			.Columns.Add ML("Comment"), , 0, cfLeft
			.OnItemActivate = @lvTrek_ItemActivate
			.Anchor.Top = AnchorStyle.asAnchor
			.Anchor.Right = AnchorStyle.asAnchor
			.Anchor.Left = AnchorStyle.asAnchor
			.Anchor.Bottom = AnchorStyle.asAnchor
			.OnSelectedItemChanged = @lvTrek_SelectedItemChanged
			.Parent = @This
		End With
		' cmdOK
		With cmdOK
			.Name = "cmdOK"
			.Text = ML("OK")
			.SetBounds 650, 208, 80, 24
			.Default = True
			.OnClick = @cmdOK_Click
			.Anchor.Right = AnchorStyle.asAnchor
			.Anchor.Bottom = AnchorStyle.asAnchor
			.Parent = @This
		End With
		' cmdCancel
		With cmdCancel
			.Name = "cmdCancel"
			.Text = ML("Cancel")
			.SetBounds 736, 208, 80, 24
			.OnClick = @cmdCancel_Click
			.Anchor.Right = AnchorStyle.asAnchor
			.Anchor.Bottom = AnchorStyle.asAnchor
			.Parent = @This
		End With
		' lblComment
		With lblComment
			.Name = "lblComment"
			.Text = ""
			.SetBounds 80, 184, 736, 16
			.Caption = ""
			.Anchor.Bottom = AnchorStyle.asAnchor
			.Anchor.Left = AnchorStyle.asAnchor
			.Anchor.Right = AnchorStyle.asAnchor
			.Parent = @This
		End With
		' lblLabelComment
		With lblLabelComment
			.Name = "lblLabelComment"
			.Text = ML("Comment") & ":"
			.SetBounds 8, 184, 64, 16
			.Anchor.Top = AnchorStyle.asNone
			.Anchor.Bottom = AnchorStyle.asAnchor
			.Parent = @This
		End With
	End Constructor
	
	Dim Shared fTrek As frmTrek
	pfTrek = @fTrek
'#End Region


Private Sub frmTrek.cmdOK_Click(ByRef Sender As Control)
	fTrek.SelectedItem = fTrek.lvTrek.SelectedItem
	fTrek.ModalResult = ModalResults.OK
	fTrek.CloseForm
End Sub

Private Sub frmTrek.cmdCancel_Click(ByRef Sender As Control)
	fTrek.ModalResult = ModalResults.Cancel
	fTrek.CloseForm
End Sub

Private Sub frmTrek.lvTrek_ItemActivate(ByRef Sender As ListView, ByVal ItemIndex As Integer)
	fTrek.SelectedItem = fTrek.lvTrek.SelectedItem
	fTrek.ModalResult = ModalResults.OK
	fTrek.CloseForm
End Sub

Private Sub frmTrek.Form_Show(ByRef Sender As Form)
	fTrek.lvTrek.SetFocus
	fTrek.lvTrek.SelectedItemIndex = 0
	fTrek.SelectedItem = 0
End Sub

Private Sub frmTrek.lvTrek_SelectedItemChanged(ByRef Sender As ListView, ByVal ItemIndex As Integer)
	If ItemIndex <> -1 Then fTrek.lblComment.Caption = fTrek.lvTrek.ListItems.Item(ItemIndex)->Text(4) Else fTrek.lblComment.Caption = ""
End Sub

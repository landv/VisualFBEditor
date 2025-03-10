﻿'#Region "Form"
	#if defined(__FB_MAIN__) AndAlso Not defined(__MAIN_FILE__)
		#define __MAIN_FILE__ __FILE__
		#ifdef __FB_WIN32__
			#cmdline "Form1.rc"
		#endif
	#endif
	#include once "mff/Form.bi"
	#include once "mff/ListControl.bi"
	#include once "mff/Panel.bi"
	#include once "mff/CommandButton.bi"
	#include once "mff/Label.bi"
	
	Using My.Sys.Forms
	
	Type MDIListType Extends Form
		Declare Static Sub _Form_Create(ByRef Sender As Control)
		Declare Sub Form_Create(ByRef Sender As Control)
		Declare Static Sub _ListControl1_DblClick(ByRef Sender As Control)
		Declare Sub ListControl1_DblClick(ByRef Sender As Control)
		Declare Constructor
		
		Dim As ListControl ListControl1
	End Type
	
	Constructor MDIListType
		' MDIList
		With This
			.Name = "MDIList"
			.Text = "Select Window"
			.Designer = @This
			.Caption = "Select Window"
			.StartPosition = FormStartPosition.CenterParent
			.OnCreate = @_Form_Create
			.BorderStyle = FormBorderStyle.Sizable
			.SetBounds 0, 0, 350, 300
		End With
		' ListControl1
		With ListControl1
			.Name = "ListControl1"
			.Text = "ListControl1"
			.TabIndex = 0
			.Align = DockStyle.alClient
			.ExtraMargins.Top = 10
			.ExtraMargins.Right = 10
			.ExtraMargins.Left = 10
			.ExtraMargins.Bottom = 10
			.SetBounds 10, 10, 314, 238
			.Designer = @This
			.OnDblClick = @_ListControl1_DblClick
			.Parent = @This
		End With
	End Constructor
	
	Private Sub MDIListType._ListControl1_DblClick(ByRef Sender As Control)
		*Cast(MDIListType Ptr, Sender.Designer).ListControl1_DblClick(Sender)
	End Sub
	
	Private Sub MDIListType._Form_Create(ByRef Sender As Control)
		*Cast(MDIListType Ptr, Sender.Designer).Form_Create(Sender)
	End Sub
	
	Dim Shared MDIList As MDIListType
	
	#if __MAIN_FILE__ = __FILE__
		MDIList.Show
	
		App.Run
	#endif
'#End Region

Private Sub MDIListType.Form_Create(ByRef Sender As Control)
	ListControl1.Clear
	If MDIMain.lstMdiChild.Count < 1 Then Exit Sub
	Dim i As Integer
	For i = 0 To MDIMain.lstMdiChild.Count - 1
		ListControl1.AddItem (Cast(MDIChildType Ptr, MDIMain.lstMdiChild.Item(i))->Text)
	Next
	ListControl1.ItemIndex = MDIMain.actMidChildIdx
End Sub

Private Sub MDIListType.ListControl1_DblClick(ByRef Sender As Control)
	If ListControl1.ItemIndex < 0 Then Exit Sub
	Tag = MDIMain.lstMdiChild.Item(ListControl1.ItemIndex)
	ModalResult = ModalResults.OK
	CloseForm
End Sub

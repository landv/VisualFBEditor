﻿#ifdef __FB_WIN32__
	'#Compile "Form1.rc"
#endif
#define __USE_GTK3__
'#Region "Form"
	#include once "mff/Form.bi"
	#include once "mff/ReBar.bi"
	#include once "mff/ToolBar.bi"
	#include once "mff/RadioButton.bi"
	#include once "mff/CommandButton.bi"
	
	Using My.Sys.Forms
	
	Type Form1Type Extends Form
		Declare Static Sub CommandButton1_Click_(ByRef Sender As Control)
		Declare Sub CommandButton1_Click(ByRef Sender As Control)
		Declare Constructor
		
		Dim As ReBar ReBar1
		Dim As ToolBar ToolBar1, ToolBar2
		Dim As ToolButton ToolButton1
		Dim As RadioButton RadioButton1
		Dim As CommandButton CommandButton1
	End Type
	
	Constructor Form1Type
		' Form1
		With This
			.Name = "Form1"
			.Text = "Form1"
			.SetBounds 0, 0, 350, 300
		End With
		' ReBar1
		With ReBar1
			.Name = "ReBar1"
			.Text = "ReBar1"
			.Align = DockStyle.alTop
			.AutoSize = False
			.SetBounds 0, 0, 334, 30
			.Parent = @This
		End With
		' ToolBar1
		With ToolBar1
			.Name = "ToolBar1"
			.Text = "ToolBar1"
			.SetBounds 11, 2, 10, 36
			.Parent = @ReBar1
		End With
		' ToolButton1
		With ToolButton1
			.Name = "ToolButton1"
			.Caption = "15"
			.Parent = @ToolBar1
		End With
		' ToolBar2
		With ToolBar2
			.Name = "ToolBar2"
			.Text = "ToolBar2"
			.SetBounds 0, 10, 10, 50
			.Parent = @ReBar1
		End With
		' RadioButton1
		With RadioButton1
			.Name = "RadioButton1"
			.Text = "RadioButton1"
			.TabIndex = 0
			.SetBounds 0, 10, 30, 30
			.Parent = @ReBar1
		End With
		' CommandButton1
		With CommandButton1
			.Name = "CommandButton1"
			.Text = "CommandButton1"
			.TabIndex = 1
			.SetBounds 50, 70, 100, 30
			.Designer = @This
			.OnClick = @CommandButton1_Click_
			.Parent = @This
		End With
	End Constructor
	
Private Sub Form1Type.CommandButton1_Click_(ByRef Sender As Control)
	*Cast(Form1Type Ptr, Sender.Designer).CommandButton1_Click(Sender)
End Sub

	
	Dim Shared Form1 As Form1Type
	
	#ifndef _NOT_AUTORUN_FORMS_
		#define _NOT_AUTORUN_FORMS_
		
		Form1.Show
		
		App.Run
	#endif
'#End Region

Private Sub Form1Type.CommandButton1_Click(ByRef Sender As Control)
DebugPrint(__FILE__ & " Line " & __LINE__ & "Debug logging testing.", True, False) : 
End Sub

﻿'#Region "Form"
	#include once "mff/Form.bi"
	#include once "mff/ListControl.bi"
	#include once "mff/Label.bi"
	#include once "mff/CommandButton.bi"
	
	Using My.Sys.Forms
	
	Type frmSave Extends Form
		Declare Static Sub cmdYes_Click_(ByRef Sender As Control)
		Declare Sub cmdYes_Click(ByRef Sender As Control)
		Declare Static Sub cmdNo_Click_(ByRef Sender As Control)
		Declare Sub cmdNo_Click(ByRef Sender As Control)
		Declare Static Sub cmdCancel_Click_(ByRef Sender As Control)
		Declare Sub cmdCancel_Click(ByRef Sender As Control)
		Declare Static Sub Form_Show_(ByRef Sender As Form)
		Declare Sub Form_Show(ByRef Sender As Form)
		Declare Static Sub Form_Create_(ByRef Sender As Control)
		Declare Sub Form_Create(ByRef Sender As Control)
		Declare Constructor
		
		Dim As ListControl lstFiles
		Dim As Label lblMessage
		Dim As CommandButton cmdYes, cmdNo, cmdCancel
	End Type

	Common Shared pfSave As frmSave Ptr
	
#ifndef __USE_MAKE__
	#include once "frmSave.frm"
#endif

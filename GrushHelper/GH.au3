#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.8.1
 Author:         Jaccus

 Script Function:
	GrushHelper main

#ce ----------------------------------------------------------------------------

#include <GHFUN.au3>
#NoTrayIcon
;-----------------------------------------------------------------------
GUISetState(@SW_SHOW)
WinMove($GHTitle,"",1,1)
ReadConfig()

While 1
  $msg = GUIGetMsg()
  
  Select
	Case $msg = $GUI_EVENT_CLOSE
		ExitLoop
    Case $msg = $PartyAll
		PartyAll()
    Case $msg = $PartyNone
		PartyNone()
	Case $msg = $JoinMules
		JoinGame("jc1","jc2","1","2")
	Case $msg = $DropAnnis
		DropAnnis()
	Case $msg = $KillStorers
		KillStorers()
	Case $msg = $KillAnners
		KillAnners()
	Case $msg = $RunFirstSitters
		RunFirstSitters()
	Case $msg = $RunSecondSitters
		RunSecondSitters()
	Case $msg = $RunThirdSitters
		RunThirdSitters()
	Case $msg = $OnTopCheckBox
		If GUICtrlRead($OnTopCheckBox) = $GUI_CHECKED Then
			WinSetOnTop($GHTitle,"",1)
		EndIf
		If GUICtrlRead($OnTopCheckBox) = $GUI_UNCHECKED Then
			WinSetOnTop($GHTitle,"",0)
		EndIf
	;moves
	Case $msg = $MoveUpLeft
		Move("UPLEFT")
	Case $msg = $MoveUp
		Move("UP")
	Case $msg = $MoveUpRight
		Move("UPRIGHT")
	Case $msg = $MoveLeft
		Move("LEFT")
	Case $msg = $MoveRight
		Move("RIGHT")
	Case $msg = $MoveDownLeft
		Move("DOWNLEFT")
	Case $msg = $MoveDown
		Move("DOWN")
	Case $msg = $MoveDownRight
		Move("DOWNRIGHT")
	;/moves
	Case $msg = $ReloadButton
		ReloadConfig()
	Case $msg = $OpenButton
		OpenConfig()
	Case $msg = $KillSittersButton
		KillSitters()
	Case $msg = $KillDiablosButton
		KillDiablos()
  EndSelect
WEnd
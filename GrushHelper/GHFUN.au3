#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.8.1
 Author:         Jaccus

 Script Function:
	GrushHelper functions

#ce ----------------------------------------------------------------------------

#include <GHGUI.au3>

Global Const $LEFT = 1
Global Const $RIGHT = 800
Global Const $UP = 1
Global Const $DOWN = 550
Global Const $CENTERX = ($LEFT + $RIGHT) / 2
Global Const $CENTERY = ($UP + $DOWN) / 2
$TitleSC = "SocksCap Control"
$ErrorTitle = "Error"
$ErrorExist = "Run SocksCap first..."
$TitleSitter = "DCSitter"

$IniName = "GH.ini"
$ErrorTitle = "Error"
$ErrorActivating = "Error activating window "
Opt("GUIResizeMode", 0)
Opt("GUICoordMode",1)
$IniDir = @WorkingDir & "\"
$IniLocation = $IniDir & $IniName

Dim $grushers[7]
Dim $storers[8]
Dim $anners[8]
;east=55,55 europe=55,75 (client coords)
;load in sitter=570,540   ok in sitter msgbox=320,20
Func RunSitter($num)
	Opt("MouseCoordMode",2)
	ShowSC()
	MouseClick("left",55,55,2,1) ;sitter in SC click
	WinWaitActive($TitleSitter)
	MouseClick("left",570,540,1,1) ;load click
	WinWaitActive("Load")
	Send($num)
	MouseClick("left",320,20,1,1) ;Ok click
	WinSetState($TitleSitter,"",@SW_MINIMIZE)
	
EndFunc

Func RunFirstSitters()
	FOR $i = 1 TO 24 STEP +1
		RunSitter($i)
	NEXT
	;RunSitter(1)
EndFunc
Func RunSecondSitters()
	FOR $i = 25 TO 48 STEP +1
		RunSitter($i)
	NEXT
EndFunc
Func RunThirdSitters()
	FOR $i = 48 TO 60 STEP +1
		RunSitter($i)
	NEXT
EndFunc

Func ShowSC()
	MinimizeSC()
	If WinExists($TitleSC) Then
		WinActivate($TitleSC)
		WinWaitActive($TitleSC)
	Else
		MsgBox(0,$ErrorTitle,$ErrorExist)
	EndIf
EndFunc
Func MinimizeSC()
	WinSetState($TitleSC,"",@SW_MINIMIZE)
EndFunc

Func KillSitters()
	$list = ProcessList("DC Sitter.exe")
	$num = $list[0][0]
	for $i = 1 to $num
		Sleep(20)
		ProcessClose($list[$i][0])
	next
EndFunc

Func KillDiablos()
	$list = ProcessList("Diablo II.exe")
	$num = $list[0][0]
	for $i = 1 to $num
		Sleep(100)
		ProcessClose($list[$i][0])
	next
EndFunc

;695,417 - anni corner
;40,500 - drop corner
Func DropAnnis()
	Opt("GUICoordMode",1)
	$pos = MouseGetPos()
	FOR $w IN $anners
		If WinExists($w) Then
			ControlSend($w, "", 0, "i")
			Sleep(50)
			_MouseClickPlus($w, "left", 695,417, 1)
			Sleep(400)
			_MouseClickPlus($w, "left", 50,450, 1)
			Sleep(50)
			ControlSend($w, "", 0, "i")
		Else 
			MsgBox(0,$ErrorTitle,$ErrorActivating & $w)
			ExitLoop
		EndIf
		Sleep(10)
	NEXT
	MouseMove($pos[0],$pos[1],1)	
EndFunc

Func KillAnners()
	Opt("GUICoordMode",1)
	$pos = MouseGetPos()
	FOR $w IN $anners
		If WinExists($w) Then
			$ps = WinGetProcess($w)
			ProcessClose($ps)
		Else 
			MsgBox(0,$ErrorTitle,$ErrorActivating & $w)
			ExitLoop
		EndIf
		Sleep(10)
	NEXT
EndFunc

Func KillStorers()
	Opt("GUICoordMode",1)
	$pos = MouseGetPos()
	FOR $w IN $storers
		If WinExists($w) Then
			$ps = WinGetProcess($w)
			ProcessClose($ps)
		Else 
			MsgBox(0,$ErrorTitle,$ErrorActivating & $w)
			ExitLoop
		EndIf
		Sleep(10)
	NEXT
EndFunc

;710,460 - join
;510,140 - game name
;690,140 - game pass
;670,420 - join game
Func JoinGame($name1, $name2, $pass1, $pass2)
	$pos = MouseGetPos()
	$i = 0
	FOR $w IN $anners
		If WinExists($w) Then
			_MouseClickPlus($w, "left", 710,460, 1) ;join
			Sleep(10)
			_MouseClickPlus($w, "left", 510,140, 1) ;gamename
			Sleep(10)
			IF ($i<4) THEN
				ControlSend($w,"",0,$name1)
			ELSE
				ControlSend($w,"",0,$name2)
			ENDIF
				_MouseClickPlus($w, "left", 690,140, 1) ;gamepass
				Sleep(30)
			IF ($i<4) THEN
				ControlSend($w,"",0,$pass1)
			ELSE
				ControlSend($w,"",0,$pass2)
			ENDIF
			Sleep(20)
			_MouseClickPlus($w, "left", 670,420, 1) ;joingame
			Sleep(10)
			Sleep(30)
		Else 
			MsgBox(0,$ErrorTitle,$ErrorActivating & $w)
			ExitLoop
		EndIf
		$i+=1
		Sleep(10)
	NEXT
	MouseMove($pos[0],$pos[1],1)	
EndFunc

Func ReadConfig()
	FOR $i = 0 TO 6 STEP +1
		$grushers[$i] = IniRead($IniLocation,"grush","w" & ($i +1), "NotFound")
	NEXT
	FOR $i = 0 TO 7 STEP +1
		$storers[$i] = IniRead($IniLocation,"storers","w" & $i, "NotFound")
		$anners[$i] = IniRead($IniLocation,"anners","w" & $i, "NotFound")
	NEXT
EndFunc
;335,115 //leave party
Func PartyAll()
	$pos = MouseGetPos()
	FOR $w IN $grushers
		If WinExists($w) Then
			ControlSend($w, "", 0, "p")
			Sleep(40)
			FOR $i = 0 TO 6 STEP +1
				_MouseClickPlus($w, "left", 300, 170 + (38 * ($i-1)), 1)
				Sleep(10)
			NEXT
			ControlSend($w, "", 0, "p")
		Else 
			MsgBox(0,$ErrorTitle,$ErrorActivating & $w)
		EndIf
		Sleep(10)
	NEXT
	MouseMove($pos[0],$pos[1],0)
EndFunc

Func PartyNone()
	Opt("GUICoordMode",1)
	$pos = MouseGetPos()
	FOR $w IN $grushers
		If WinExists($w) Then
			ControlSend($w, "", 0, "p")
			Sleep(50)
			_MouseClickPlus($w, "left", 337, 90, 1)
			Sleep(10)
			ControlSend($w, "", 0, "p")
		Else 
			MsgBox(0,$ErrorTitle,$ErrorActivating & $w)
		EndIf
		Sleep(10)
	NEXT
	MouseMove($pos[0],$pos[1],1)
EndFunc

Func Move($direction)
	Opt("GUICoordMode",1)
	$pos = MouseGetPos()
	FOR $w IN $grushers
		If WinExists($w) Then
			Select
				;directions
			Case $direction = "UP"
				_MouseClickPlus($w, "left", $CENTERX, $UP, 1)
			Case $direction = "DOWN"
				_MouseClickPlus($w, "left", $CENTERX, $DOWN, 1)
			Case $direction = "LEFT"
				_MouseClickPlus($w, "left", $LEFT, $CENTERY, 1)
			Case $direction = "RIGHT"
				_MouseClickPlus($w, "left", $RIGHT, $CENTERY, 1)
				;corners
			Case $direction = "UPLEFT"
				_MouseClickPlus($w, "left", $LEFT, $UP, 1)
			Case $direction = "UPRIGHT"
				_MouseClickPlus($w, "left", $RIGHT, $UP, 1)
			Case $direction = "DOWNLEFT"
				_MouseClickPlus($w, "left", $LEFT, $DOWN, 1)
			Case $direction = "DOWNRIGHT"
				_MouseClickPlus($w, "left", $RIGHT, $DOWN, 1)
			EndSelect
		Else 
			MsgBox(0,$ErrorTitle,$ErrorActivating & $w)
		EndIf
		Sleep(10)
	NEXT
	MouseMove($pos[0],$pos[1],1)
EndFunc

Func Terminate() 
  Exit 0
EndFunc

Func ReloadConfig()
	ReadConfig()
	MsgBox(0,"Reload Config", "Config Reloaded Successfully")
EndFunc

Func OpenConfig()
	If FileExists($IniLocation) Then
		Run("notepad.exe " & $IniLocation, $IniDir)
	EndIf
EndFunc
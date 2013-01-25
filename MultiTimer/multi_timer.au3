$IniName = "timers.ini"

#region --- Gui code Start ---
#include <GuiConstants.au3>
#include <Array.au3>
GuiCreate("Multi Timer 1.0 by Jaccus", 420, 323,(@DesktopWidth-420)/2, (@DesktopHeight-323)/2 , $WS_OVERLAPPEDWINDOW + $WS_VISIBLE + $WS_CLIPSIBLINGS)

$Group_Timer = GuiCtrlCreateGroup("Add Timer", 0, 0, 150, 115)
$Input_H = GuiCtrlCreateInput("", 10, 20, 30, 20)
$Input_M = GuiCtrlCreateInput("", 60, 20, 30, 20)
$Input_S = GuiCtrlCreateInput("", 110, 20, 30, 20)
$Label_H = GuiCtrlCreateLabel("hours", 10, 40, 40, 20)
$Label_M = GuiCtrlCreateLabel("min", 70, 40, 20, 20)
$Label_S = GuiCtrlCreateLabel("sec", 120, 40, 20, 20)
$Input_Timer_Name = GuiCtrlCreateInput("", 10, 70, 130, 20)
$Label_Timer_Name = GuiCtrlCreateLabel("timer name", 40, 90, 100, 20)
$Button_Timer_Add = GuiCtrlCreateButton("ADD", 0, 120, 150, 20)
$k=" | "
$listview = GUICtrlCreateListView("Timer Name|hours|minutes|seconds  ", 160, 10, 250, 310)

$Button_Reload = GuiCtrlCreateButton("reload", 120, 240, 40, 20)
$Button_Delete = GuiCtrlCreateButton("delete", 120, 270, 40, 20)
$Button_Clear = GuiCtrlCreateButton("clear", 120, 300, 40, 20)

GuiSetState()
While 1
	$msg = GuiGetMsg()
	Select
	Case $msg = $GUI_EVENT_CLOSE
		ExitLoop
	Case $msg = $Button_Timer_Add
		TimerAdd()
	Case $msg = $Button_Reload
		ListLoad($IniName,$listview)
	Case $msg = $Button_Clear
		ListClear($listview)
	Case $msg = $Button_Delete
		;funkcja del
	Case Else
		;;;
	EndSelect
WEnd
Exit
#endregion --- Gui code End ---

#region --- Add Timer Function ---
Func TimerAdd()
	If GUICtrlRead($Input_Timer_Name) Then ;checks if timer name is set
		If GUICtrlRead($Input_H) Or GUICtrlRead($Input_M) Or GUICtrlRead($Input_S) Then ;checks if time is set

				$var = IniReadSectionNames($IniName)
				$bool = 0
				If @error Then 
					MsgBox(4096, "", "Error occured, probably no INI file.")
				Else
					For $i = 1 To $var[0] Step +1
						If GUICtrlRead($Input_Timer_Name) = $var[$i] Then
							$bool = 1
							ExitLoop
						EndIf
					Next
				
				
				If $bool=0 Then

					If GUICtrlRead($Input_H) Then ;0 if none
						IniWrite($IniName,GUICtrlRead($Input_Timer_Name),GUICtrlRead($Label_H),GUICtrlRead($Input_H))
					Else
						IniWrite($IniName,GUICtrlRead($Input_Timer_Name),GUICtrlRead($Label_H),0) ;0 if none
					EndIf
					
					If GUICtrlRead($Input_M) Then ;0 if none
						IniWrite($IniName,GUICtrlRead($Input_Timer_Name),GUICtrlRead($Label_M),GUICtrlRead($Input_M))
					Else
						IniWrite($IniName,GUICtrlRead($Input_Timer_Name),GUICtrlRead($Label_M),0) ;0 if none
					EndIf
					
					If GUICtrlRead($Input_S) Then ;0 if none
						IniWrite($IniName,GUICtrlRead($Input_Timer_Name),GUICtrlRead($Label_S),GUICtrlRead($Input_S))
					Else
						IniWrite($IniName,GUICtrlRead($Input_Timer_Name),GUICtrlRead($Label_S),0) ;0 if none
					EndIf
				Else
					MsgBox(0,"Error","Such timer already exists.")
				EndIf
				EndIf

		Else
			MsgBox(0,"Error","Time not set.")
		EndIf
		
	Else
		MsgBox(0,"Error","Timer name not specified.")
	EndIf
	
EndFunc

#endregion
#region --- List Load Function ---
Func ListLoad($IniName,$listview)
	$Sections = IniReadSectionNames($IniName)
	Dim $item[$Sections[0]+1]
	For $i = 1 To $Sections[0] Step +1
		$nazwasekcji = $Sections[$i]
		$ilegodzin = IniRead($IniName,$Sections[$i],"hours",0)
		$ileminut = IniRead($IniName,$Sections[$i],"min",0)
		$ilesekund = IniRead($IniName,$Sections[$i],"sec",0)
		$item[$i] = GUICtrlCreateListViewItem($nazwasekcji & $k & $ilegodzin & $k & $ileminut & $k & $ilesekund , $listview )		
	Next
EndFunc
#endregion
#region --- List Clear Function ---
Func ListClear($listview)
	GUICtrlDelete($listview)
	;$listview = GUICtrlCreateListView("Timer Name|hours|minutes|seconds  ", 160, 10, 250, 310)
EndFunc
#endregion
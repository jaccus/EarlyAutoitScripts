#include <GUIConstants.au3>

$appname = "Time Counter v1.0 by Jaccus"
$label_1_text = "Time value to count:"

GUICreate($appname, 250, 200)
$label_1 = GUICtrlCreateLabel($label_1_text, 10, 10)
$input_hours = GUICtrlCreateInput("0",10,30,25,20)
$input_minutes = GUICtrlCreateInput("0",60,30,25,20)
$input_seconds = GUICtrlCreateInput("0",110,30,25,20)
$label_hours = GUICtrlCreateLabel("hours",10,50,45,20)
$label_minutes = GUICtrlCreateLabel("minutes",60,50,45,20)
$label_seconds = GUICtrlCreateLabel("seconds",110,50,45,20)
$button_start = GUICtrlCreateButton("RUN",160,30,70,20)
$label_time_left = GUICtrlCreateLabel("[time left]",100,90,45,20)
GUISetState(@SW_SHOW)


While 1
  $msg = GUIGetMsg()
  Select
	  
  Case $msg = $button_start
ccounter()
;MsgBox(0,"",$label_time_left)
    Case $msg = $GUI_EVENT_CLOSE
      ExitLoop
  EndSelect
 
WEnd 

Func ccounter()
	While (1)
	  $time_left = 60*60*$label_hours + 60 *$label_minutes + $label_seconds
	  $handle = FileOpen("time.txt",2)
	  FileWrite($handle,$time_left)
	  FileClose($handle)
	WEnd
EndFunc
  
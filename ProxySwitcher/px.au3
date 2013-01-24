#include <GuiConstants.au3>
#include <Array.au3>
#include <px_functions.au3>
#NoTrayIcon
;-----------------------------------------------------------------------
CheckSections()
;-----------------------------------------------------------------------
GUISetState(@SW_SHOW)
While 1
  $msg = GUIGetMsg()
  Select
	Case $msg = $GUI_EVENT_CLOSE
	  ExitLoop
    Case $msg = $RunSCButton
	  RunSC()
	  ResizeSC()
	  ApplyProxy("proxy1")
    Case $msg = $ResizeSCButton
      ResizeSC() 
	Case $msg = $ShowSCButton
	  ShowSC()
    Case $msg = $HideSCButton
	  MinimizeSC()
    Case $msg = $CloseSCButton
	  CloseSC()
	Case $msg = $OnTopCheckBox
		If GUICtrlRead($OnTopCheckBox) = $GUI_CHECKED Then
			WinSetOnTop($SwitcherTitle,"",1)
		EndIf
		If GUICtrlRead($OnTopCheckBox) = $GUI_UNCHECKED Then
			WinSetOnTop($SwitcherTitle,"",0)
		EndIf
	Case $msg = $Import1Button
      ApplyProxy("proxy1")
    Case $msg = $Import2Button
      ApplyProxy("proxy2")
    Case $msg = $Import3Button
      ApplyProxy("proxy3")
    Case $msg = $Import4Button
      ApplyProxy("proxy4")
    Case $msg = $Import5Button
      ApplyProxy("proxy5")
    Case $msg = $Import6Button
      ApplyProxy("proxy6")
    Case $msg = $Import7Button
      ApplyProxy("proxy7")
    Case $msg = $Import8Button
      ApplyProxy("proxy8")
    Case $msg = $Import9Button
      ApplyProxy("proxy9")
    Case $msg = $Import10Button
      ApplyProxy("proxy10")
    Case $msg = $Import11Button
      ApplyProxy("proxy11")
    Case $msg = $Import12Button
      ApplyProxy("proxy12")
    Case $msg = $Import13Button
      ApplyProxy("proxy13")
    Case $msg = $Import14Button
      ApplyProxy("proxy14")
    Case $msg = $Import15Button
      ApplyProxy("proxy15")
    Case $msg = $Import16Button
      ApplyProxy("proxy16")
    Case $msg = $Import17Button
      ApplyProxy("proxy17")
    Case $msg = $Import18Button
      ApplyProxy("proxy18")
    Case $msg = $Import19Button
      ApplyProxy("proxy19")
    Case $msg = $Import20Button
      ApplyProxy("proxy20")
  Case $msg = $ReloadButton
	  ReloadConfig()
  Case $msg = $OpenButton
	  OpenConfig()
  EndSelect
WEnd
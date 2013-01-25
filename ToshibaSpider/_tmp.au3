;#include <FF.au3>

;$Socket = _FFStart("http://www.google.it")
;$sStatusText = _FFGetValue($Socket ,"window.status")
;;msgbox(0,"test",$sStatusText)
;ConsoleWrite($sStatusText)

#include <ie.au3>
#include <ext_lib.au3>

HotKeySet("{F8}", "RunApp")
;HotKeySet("{F9}", "TypeAlphabet")
HotKeySet("{F10}", "ExitApp")




	$url = "http://apps.facebook.com/toshibobranie/laptop/show/2rkyuj2bgb/"
	$oIE = _IECreate()
	_IENavigate($oIE, $url)



Tooltip("F8 = Run, F10 = Exit", 0, 0)

Func RunApp()
	Tooltip("Starting", 0, 0)

	$status = _IEPropertyGet($oIE,"statustext")
	_IEQuit($oIE)

	;$coord = PixelSearch(0,0,@DesktopWidth,@DesktopHeight,0xF6001C)
	If Not @error Then
		;MsgBox(0, "X and Y are:", $coord[0] & "," & $coord[1])
		MsgBox(0, "", $status)
	EndIf

	;ConsoleWrite()

	Tooltip("F8 = Open game, F10 = Exit", 0, 0)
EndFunc

;Func TypeAlphabet()
;   Tooltip("Botting", 0, 0)
;   Send("abcdefghijklmnopqrstuvwxyz")
;   Tooltip("F8 = Open game, F9 = Start botting, F10 = Exit bot", 0, 0)
;EndFunc

Func ExitApp()
   Exit
EndFunc

While True
   Sleep(100)
WEnd
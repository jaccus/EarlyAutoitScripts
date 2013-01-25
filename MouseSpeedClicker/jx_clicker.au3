#cs ----------------------------------------------------------------------------
	
	AutoIt Version: 3.2.8.1
	Author:         Jaccus
	
	Script Function:
	quick mouse clicker
	
#ce ----------------------------------------------------------------------------

#include <jx_common.au3>

HotKeySet("z","start")
HotKeySet("x","stop")
HotKeySet("c","end")

$scriptVersion = "v0.1.0.0"
$scriptName = "JX Clicker"
$scriptAuthor = "Jaccus"
$splashMsg = "Clicks as fast as possible!" & @CRLF & "Press Z to start, X to stop, C key to exit"
$isRunning = False
TraySetIcon("jx_clicker.exe", 0)
TraySetToolTip($splashMsg)

showsplash($scriptName,$scriptVersion,$scriptAuthor,$splashMsg,3000)

;main loop
While True
	While $isRunning
		;$mpos = MouseGetPos()
		;Sleep(1)
		;MouseClick("left",$mpos[0],$mpos[1],1,1)
		MouseClick("left",750,250,9999999,0)
	WEnd
	
	;Sleep(10)
WEnd

Func start()
	$isRunning=True
EndFunc

Func stop()
	$isRunning=False
EndFunc

Func end()
	Exit
EndFunc

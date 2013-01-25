#cs ----------------------------------------------------------------------------
	
	AutoIt Version: 3.2.8.1
	Author:         Jaccus
	
	Script Function:
	page green tick click at 0x00CC00
	
#ce ----------------------------------------------------------------------------

#include <jx_common.au3>

HotKeySet("x","end")

$scriptVersion = "v0.1.0.0"
$scriptName = "JX Ticker"
$scriptAuthor = "Jaccus"
$splashMsg = "Ticks the green ticks!" & @CRLF & "Press X key to exit"

TraySetIcon("jx_ticker.exe", 0)
TraySetToolTip($splashMsg)

showsplash($scriptName,$scriptVersion,$scriptAuthor,$splashMsg,4000)

while 1
	$mpos = MouseGetPos()
	$Coords = PixelSearch(0,0,@DesktopWidth,@DesktopHeight,0x00CC00)
	If Not @error Then
	MouseClick("left",$Coords[0],$Coords[1],1,1)
	MouseMove($mpos[0],$mpos[1],0)
	EndIf
	Sleep(200)
WEnd

Func end()
	Exit
EndFunc
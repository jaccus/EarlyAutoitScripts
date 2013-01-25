#cs ----------------------------------------------------------------------------
	
	AutoIt Version: 3.2.8.1
	Author:         Jaccus
	
	Script Function:
	page idle script
	
#ce ----------------------------------------------------------------------------

#include <jx_common.au3>

$scriptVersion = "v0.1.0.2"
$scriptName = "JX Idler"
$scriptAuthor = "Jaccus"
$splashMsg = ""

;init
TraySetIcon("jx_idler.exe", 0)
$IniName = "jx_idler.ini"
$IniLocation = @WorkingDir & "\" & $IniName

$browser_window_title = IniRead($IniLocation, "settings", "browser_window_title", "NotFound")
ConsoleWrite($browser_window_title & " ")

$browser_executable_location = IniRead($IniLocation, "settings", "browser_executable_location", "NotFound")
ConsoleWrite($browser_executable_location & " ")

$browser_url = IniRead($IniLocation, "settings", "browser_url", "NotFound")
ConsoleWrite($browser_url & " ")

$browser_params = IniRead($IniLocation, "advanced", "browser_params", "NotFound")
ConsoleWrite($browser_params & " ")

$idle_cycles = IniRead($IniLocation, "settings", "idle_cycles", "1")
ConsoleWrite($idle_cycles & " ")

$browser_await_delay = IniRead($IniLocation, "advanced", "browser_await_delay", "NotFound")
ConsoleWrite($browser_await_delay & " ")

$idle_sleep_at_page = IniRead($IniLocation, "settings", "idle_sleep_at_page", "NotFound")
ConsoleWrite($idle_sleep_at_page & " ")

$idle_sleep_timeout_minimum = IniRead($IniLocation, "settings", "idle_sleep_timeout_minimum", "NotFound")
ConsoleWrite($idle_sleep_timeout_minimum & " ")

$idle_sleep_timeout_maximum = IniRead($IniLocation, "settings", "idle_sleep_timeout_maximum", "NotFound")
ConsoleWrite($idle_sleep_timeout_maximum & " ")

$minimize_window = IniRead($IniLocation, "settings", "minimize_window", "NotFound")
ConsoleWrite($minimize_window & " ")

showsplash($scriptName,$scriptVersion,$scriptAuthor,$splashMsg,4000)

;main loop
While $idle_cycles > 0
	$trayMsg = "idle cycles left: " & $idle_cycles-1
	
	TraySetToolTip($trayMsg)
	
	ViewPage()
	
	$idle_cycles = $idle_cycles - 1
WEnd




;functions

Func ViewPage()
	Run($browser_executable_location & " " & $browser_params & " " & $browser_url, "", @SW_MINIMIZE)
	
	Sleep($browser_await_delay)
	
	If WinWait($browser_window_title, "", $browser_await_delay) Then
		
		If $minimize_window == "yes" Then
			WinSetState($browser_window_title, "", @SW_MINIMIZE)
		EndIf
		
		Sleep($idle_sleep_at_page+Random(-10,10))
		
		WinClose($browser_window_title)
		
		Sleep(Random($idle_sleep_timeout_minimum, $idle_sleep_timeout_maximum))
	EndIf
EndFunc   ;==>ViewPage

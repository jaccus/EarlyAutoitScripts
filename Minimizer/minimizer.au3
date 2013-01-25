#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=down.ico
#AutoIt3Wrapper_Res_Comment=This simple AutoIt3 script can be used to minimize/hide all windows on your desktop.
#AutoIt3Wrapper_Run_Obfuscator=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
$oShell = ObjCreate("shell.application")

$oShell.MinimizeAll
$oShell.
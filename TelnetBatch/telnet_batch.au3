#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Res_SaveSource=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
AutoItSetOption ( "WinTitleMatchMode" , 2)
#include <file.au3>

Dim $ipfile="IPs.txt"
Dim $functionfile="Function.txt"
Dim $ipadress, $function

Run("cmd")
;read ip address into array
If Not _FileReadToArray($ipfile, $ipadress) Then
   MsgBox(4096,"Error", $ipfile & " Not Found")
   Exit
EndIf
;read function into array
If Not _FileReadToArray($functionfile, $function) Then
   MsgBox(4096,"Error", $functionfile & " Not Found")
   Exit
EndIf
;go into loop untill out of ip adresses
For $loop = 1 to $ipadress[0]
	WinWait("cmd")
	WinActivate("cmd")
	WinWaitActive("cmd")
	Send("telnet " & $ipadress[$loop] & "{ENTER}")
	Sleep(2000)
	If WinExists("Telnet ") Then
		;go into loop untill all functions are done
		For $loop2 = 1 to $function[0]
			WinActivate("Telnet " & $ipadress[$loop])
			WinWaitActive("Telnet " & $ipadress[$loop])
			Send($function[$loop2] & "{ENTER}")
		Next
	Else
		MsgBox(0,"Failure","Failed to connect to host, closing.")
		WinKill("cmd")
	EndIf

Next

#cs ----------------------------------------------------------------------------
 AutoIt Version: 3.3.0.0
 Author:         jaccus

 Script Function:
	Automatic maximo login script (IBM).
#ce ----------------------------------------------------------------------------
Run("cmd.exe")
WinWaitActive("C:\WINDOWS\system32\cmd.exe")
$win = WinActivate("C:\WINDOWS\system32\cmd.exe")
Send("telnet maximo{ENTER}")
Sleep(300)
Send("<EMAIL_ADDRESS>{ENTER}")
$pass = InputBox("Password","Enter your intranet password:")
MsgBox(0,"",$pass)
Send($pass)

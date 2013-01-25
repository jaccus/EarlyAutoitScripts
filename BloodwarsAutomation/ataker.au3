Opt("WinTitleMatchMode", 2)
$error_exist = "Window does not exist"
$fftitle_startowa = "Mozilla Firefox"
$fflink = "D:\soft\Firefox\firefox.exe"
$login = "<LOGIN>"
$pass = "<PASS>"
$slp_ff = 1000
$slp_login = 1000
$failed_zajety ="Nie mo¿esz wyruszyæ na wyprawê, poniewa¿ jesteœ w trakcie ataku na innego gracza."
$stan = "none"
$sekunda = 1000
$minuta = 60 * $sekunda
$godzina = 60 * $minuta
;---------------------------------------------------
;Sleep(10 * $minuta)
;Sleep(4 * $godzina)
;---------------------------------------------------
Godzin(2)

Konradek()
Minut(15)
Sushik()
Minut(7)
Minut(30)
Konradek()
Minut(15)
Sushik()
Minut(7)

Godzin(3)

Konradek()
Minut(15)
Sushik()
Minut(7)
Minut(30)
Konradek()
Minut(15)
Sushik()
Minut(7)




;---------------------------------------------------
Func Godzin($ile)
	Sleep($ile * $godzina)
EndFunc
Func Minut($ile)
	Sleep($ile * $minuta)
EndFunc
Func Konradek()
	RunAndLogin()
	GoTo("Ranking")
	AtakKonrad()
	Close_ff()
EndFunc
Func Sushik()
	RunAndLogin()
	GoTo("Ranking")
	AtakSushi()
	Close_ff()
EndFunc
;---------------------------------------------------
Func Close_ff ()
	MouseClick("left",1265,12,1,1)
EndFunc
Func RunAndLogin()
	
	;RunWait(@ComSpec & " /c " & 'firefox', "", @SW_HIDE)
	Run($fflink)
	Sleep($slp_ff)
	If WinWait($fftitle_startowa,"",10) Then
		If WinActivate($fftitle_startowa) Then
			Sleep(2000)
			MouseClick("left",700,68,1,1)
			Send("www.bloodwars.pl" & "{ENTER}")
			Sleep($slp_login)
			MouseClick("left",450,325,2,1)
			Send($login & "{TAB}" & $pass & "{ENTER}")
		EndIf
	 
	;Else 
		;MsgBox(0,"Error",$error_exist)
	EndIf
	

	
EndFunc
Func GoTo($page)
	Sleep(2000)
		Send ("{CTRLDOWN}" & "f" & "{CTRLUP}" & $page & "{ENTER}")
		$Coords = PixelSearch(0,0,300,750,0x39DB7B)
		If Not @error Then
		MouseClick("left",$Coords[0],$Coords[1],1,1)
		EndIf
		Sleep(1000)
	EndFunc
Func AtakSushi()
	Sleep(1000)
	MouseClick("left",700,563,1,1)
	Sleep(1000)
	Send ("{CTRLDOWN}" & "f" & "{CTRLUP}" & "atk" & "{ENTER}")
		$Coords = PixelSearch(0,0,1280,800,0x39DB7B)
		If Not @error Then
		MouseClick("left",$Coords[0],$Coords[1],1,1)
	EndIf
	
	Sleep(500)
	Send("{CTRLDOWN}" & "{END}" & "{CTRLUP}")
	Sleep(1000)
	MouseClick("left",700,370,1,20)
	Sleep(1000)
	MouseClick("left",600,508,1,20)
	Sleep(2000)
EndFunc
Func AtakKonrad()
	Sleep(1000)
	MouseClick("left",700,579,1,1)
	Sleep(1000)
	Send ("{CTRLDOWN}" & "f" & "{CTRLUP}" & "atk" & "{ENTER}")
		$Coords = PixelSearch(0,0,1280,800,0x39DB7B)
		If Not @error Then
		MouseClick("left",$Coords[0],$Coords[1],1,1)
	EndIf
	Sleep(500)
	Send("{CTRLDOWN}" & "{END}" & "{CTRLUP}")
	Sleep(1000)
	MouseClick("left",700,415,1,20)
	Sleep(1000)
	MouseClick("left",600,508,1,20)
	Sleep(2000)
EndFunc
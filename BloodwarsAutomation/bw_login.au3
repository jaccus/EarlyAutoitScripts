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
$slp_trip = 101000 ; 10 min + 5 sek

;$ile_wypraw = InputBox("Wyprawy","Ile wypraw?",10)


	RunAndLogin()


;CheckExists($failed_zajety)
;PrintStan()

Func Close_ff ()
	MouseClick("left",1265,12,1,1)
EndFunc

Func RunAndLogin()
	
	;RunWait(@ComSpec & " /c " & 'firefox', "", @SW_HIDE)
	Run($fflink)
	Sleep($slp_ff)
	If WinWait($fftitle_startowa,"",10) Then
		If WinActivate($fftitle_startowa) Then
			Sleep(1000)
			MouseClick("left",700,68,1,1)
			Send("www.bloodwars.pl" & "{ENTER}")
			Sleep($slp_login)
			MouseClick("left",450,325,2,1)
			Send($login & "{TAB}" & $pass & "{ENTER}")
		EndIf
	 
	Else 
		MsgBox(0,"Error",$error_exist)
	EndIf
	

	
EndFunc
Func GoTo($page)
		Send ("{CTRLDOWN}" & "f" & "{CTRLUP}" & $page & "{ENTER}")
		$Coords = PixelSearch(0,0,300,750,0x39DB7B)
		If Not @error Then
		MouseClick("left",$Coords[0],$Coords[1],1,1)
		EndIf
		Sleep(1000)
EndFunc
Func GoTrip() ;Func GoTrip($trip_times)
		;While $trip_times > 0
			Send ("{CTRLDOWN}" & "f" & "{CTRLUP}" & "Sprawdzian wiedzy" & "{ESC}")
			Send ("{CTRLDOWN}" & "f" & "{CTRLUP}" & "poziom ³atwy" & "{ENTER}")
			$Coords = PixelSearch(300,100,1000,700,0x39DB7B)
			If Not @error Then
			;MouseClick("left",$Coords[0],$Coords[1]-100,1,10)
			MouseClick("left",239,171,1,1)
			MouseClick("left",600,510,1,1)
			;MouseClick($Coords[0]+30,$Coords[1]-80,10)
			Else
			Exit
			;MsgBox(0,"lol","lol")
			EndIf
			Sleep(1000)
			
			;$trip_times = $trip_times - 1
			;Sleep($slp_trip)
EndFunc	
Func CheckExists($page)
		Send ("{CTRLDOWN}" & "f" & "{CTRLUP}" & $page & "{ENTER}")
		$Coords = PixelSearch(0,0,300,750,0x39DB7B)
		If not @error Then
			$stan = $failed_zajety
		EndIf
		Sleep(1000)
EndFunc
Func PrintStan()
	MsgBox(0,"Stan",$stan)
EndFunc
#comments-start
    * Konto premium
    * Sala tronowa
    * Trening
    * Plac budowy
    * Widok miasta
    * Klan
    * Sklep
    * Zbrojownia
    * Handel
    * Urz¹dŸ zasadzkê
    * IdŸ na wyprawê
    * Zadania
    * Wiadomoœci
    * Ustawienia
    * Ranking
    * Forum
    * Wyloguj 
#comments-end
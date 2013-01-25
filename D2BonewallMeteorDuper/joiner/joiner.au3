MsgBox(0,"Jaccus`s Joiner v1.0", "Press 'a' to run, 's' to quit.")
;Global $JoiningWindowName = InputBox("Window Name", "In which d2 window joiner should run?","","")
Global $JoiningWindowName = "j06"
Global $GameName = InputBox("Game Name", "What is the game name to join?","","")
;Global $GameName = "jx2"
;Global $counter = 0
Global $Place = "else"
Opt( "MouseCoordMode", 2)
Opt( "PixelCoordMode", 2)
$sum_red = "887419132"
$sum_join = "301109326"
$sum_notexist = "708537348" ;na lapie
;$sum_notexist = "1847016826" ;na pc
$sum_pass = "943683834"

$name = "jx8" ;do stworzenia jak zniknie

HotKeySet("a","start")
HotKeySet("s","end")

While 1
	Sleep(100)
WEnd

Func start()
	If WinExists($JoiningWindowName) Then
		WinActivate($JoiningWindowName)
	Else 
		MsgBox(0,"error","d2 window does not exist")
	EndIf
	
	Do 
		Sleep(1000)
		join_game()
		Sleep(2000)
;MsgBox(0,"a",PixelChecksum(440,140,770,190))
	Until check_place() = "notexist"
	
	If check_place() = "notexist" Then
		SoundPlay("notify.wav")
		;MsgBox(0,"CAUTION!","GAME DISAPPEARED! KEEP ON DOOOPING!")
		SoundPlay("notify.wav")
		WinActivate($JoiningWindowName)
		create($name)
		SoundPlay("notify.wav")
	EndIf
EndFunc
	
Func join_game()
	MouseClick("left",710,460,1,10)
	Send($GameName)
	MouseClick("left",680,420,1,10)
	;MouseMove(710,350,20)
EndFunc

Func end()
	Exit
EndFunc

Func check_place()
	If $sum_red = PixelChecksum(440,140,760,270) Then
		$Place = "red"
	EndIf
	
	If $sum_join = PixelChecksum(530,110,740,160) Then
		$Place = "join"
	EndIf
		If $sum_notexist = PixelChecksum(440,140,770,190) Then
		$Place = "notexist"
	EndIf
		If $sum_pass = PixelChecksum(466,140,740,230) Then
		$Place = "pass"
	EndIf
	Return $Place
	;MsgBox(0,"place",$Place)
	;MsgBox(0,"error", PixelChecksum(440,140,760,270))
EndFunc

Func create($name)
	Sleep(20)
	MouseClick("left",600,460,1,10)
	Sleep(20)
	Send($name)
	Send("{TAB}")
	Sleep(20)
	Send("x")
	Send("{ENTER}")
	end()
EndFunc
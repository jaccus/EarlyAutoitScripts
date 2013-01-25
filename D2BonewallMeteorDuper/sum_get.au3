Opt( "PixelCoordMode", 2)

Global $JoiningWindowName = "h8"
Global $sum_red
Global $sum_join
Global $sum_notexist
Global $sum_pass
HotKeySet("z","scr_red")
HotKeySet("x","scr_join")
HotKeySet("c","scr_notexist")
HotKeySet("v","scr_pass")
;HotKeySet("b","print_sum_red")
HotKeySet("a","start")
Opt( "MouseCoordMode", 2)


While 1
	Sleep(100)
WEnd

Func start()
	;asfd
	
EndFunc

;Func print_sum_red()
	;MsgBox(0,"sum_red",$sum_red)
;EndFunc
Func scr_red()
	$sum_red = PixelChecksum(440,140,760,270)
	MsgBox(1,"sum_red",$sum_red)
	Return $sum_red
EndFunc
Func scr_join()
	$sum_join = PixelChecksum(530,110,740,160)
	MsgBox(1,"sum_join",$sum_join)
	Return $sum_join
EndFunc
Func scr_notexist()
	$sum_notexist = PixelChecksum(440,140,770,190)
	MsgBox(1,"sum_notexist",$sum_notexist)
	Return $sum_notexist
EndFunc
Func scr_pass()
	$sum_pass = PixelChecksum(466,140,740,230)
	MsgBox(1,"sum_pass",$sum_pass)
	Return $sum_pass
EndFunc
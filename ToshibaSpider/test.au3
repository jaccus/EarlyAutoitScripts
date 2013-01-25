#include <ext_lib.au3>


Dim $a1[5]
$a1[0]='1'
$a1[1]='2'
$a1[2]='3'
$a1[3]='4'
$a1[4]='5'

Dim $a2[3]
$a2[0]="2"
$a2[1]="3"
$a2[2]="4"
$res = jx_arrayExclude($a1, $a2)
;_ArrayDisplay($res)

;ProcessClose(5144)

Func killWindows2Chrome()
	AutoItSetOption("WinTitleMatchMode", 2)
	$windows = WinList("Google Chrome")
	For $i = 1 To $windows[0][0]
		ConsoleWrite($windows[$i][0] & @CRLF)
		;ProcessClose($windows[$i][1])
		WinClose($windows[$i][0])
	Next
EndFunc

killWindows2Chrome()
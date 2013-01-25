$number= getnum()

$Window1="k1"
$Window2="k2"
$Window3="k4"
$Window4="k5"
$Window5="k9"
$Window6="k10"
$Window7="k11"
$Window8=""


func getnum()
Return FileReadLine("num.txt", 1)
EndFunc

func rund2($title)
Sleep(700)
WinActivate($title)
Sleep(300)
MouseClick("left" , 784 , 613 , 1 , 20)
;Sleep(500)
;MouseClick("left" , 902 , 529 , 1 , 20)
Sleep(300)
;MouseClick("left" , 656 , 308 , 1 , 20)
;Sleep(500)
Send("jx_")
Send(letter($title))
Send("_")
Send($number)
Sleep(300)
Send("{TAB}")
Sleep(300)
Send($number)
Sleep(300)
Send("{ENTER}")
Sleep(2000)
MouseClick("left" , 0 , 0 , 1 , 1)
EndFunc
func letter($title)
		If $title == $Window1 Then $letter = "A"
		If $title == $Window2 Then $letter = "B"
		If $title == $Window3 Then $letter = "C"
		If $title == $Window4 Then $letter = "D"
		If $title == $Window5 Then $letter = "E"
		If $title == $Window6 Then $letter = "F"
		If $title == $Window7 Then $letter = "G"
		If $title == $Window8 Then $letter = "H"
		Return $letter
EndFunc

func quitd2 ($tytul)
Sleep(700)
WinActivate($tytul)
Sleep(1000)
Send("{ESC}")
Sleep(600)
MouseClick("left" , 604 , 413 , 1 , 10)
Sleep(1000)
EndFunc
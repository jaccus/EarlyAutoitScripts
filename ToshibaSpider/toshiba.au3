#include <ext_lib.au3>

HotKeySet("{F10}","end")
Func end()
	Exit
EndFunc

$USE_CHROME = True

$RED_BUTTON_WAIT_TIMEOUT = 10000
$BLUE_BUTTON_WAIT_TIMEOUT = 10000
$RED_BUTTON_STATIC_SLEEP = Random(2100,6500)
$BLUE_BUTTON_STATIC_SLEEP = Random(1000,4200)

$FILE_HASHES_ALL =     "D:\all.txt"
;$FILE_HASHES_SKIPPED = "D:\skipped2.txt"
$FILE_HASHES_SKIPPED = "D:\skipped.txt"
$FILE_HASHES_HELPED =  "D:\helped.txt"

$FILE_HASHES_TMP =     "D:\_tmp_hashes_to_help.txt"
;$FILE_HASHES_TMP =     "D:\TO_CHECK_TOMORROW"

;$FILE_HASHES_SKIPPED = "D:\skipped2.txt"
$FILE_HASHES_CRAP =    "D:\crap.txt"
$PATH_IE = 'C:\Program Files (x86)\Internet Explorer\iexplore.exe'
$PATH_CHROME = 'C:\Users\jaccus\AppData\Local\Google\Chrome\Application\chrome.exe --enable-vertical-tabs --new-window --start-maximized'
$WINMATCHER_IE = 'Windows Internet Explorer'
$WINMATCHER_CHROME = 'Google Chrome'
$URL_PROFILE_PREFIX = 'http://facebook.zeroproblemu.pl/laptop/show/'

$iconX = 141 ; 142 original -1 for 100% hit
$iconY = 54 ;55 original -1 for 100% hit

$BUTTON_RED=1
$BUTTON_BLUE=2
$BUTTON_NOLAP=3

;REMEMBER TO SET WINDOW INFO TO RELATIVE!!!!
$RED_X=840
$RED_Y=446
$RED_COLOR=0xF6001C
$BLUE_X=651
$BLUE_Y=431
$BLUE_COLOR=0x6079AB

$helpButtonX=$RED_X
$helpButtonY=$RED_X
$helpButtonX_chrome=$RED_X
$helpButtonY_chrome=$RED_Y
$helpButtonLabelPrefix='http://facebook.zeroproblemu.pl/laptop/show/b4xfjbnskf/?session=%7B%22uid%22%3A%22709945659%22%2C%22session_key%22%3A%222.oKqpoDI3lQOO68OMJvuJAA__.3600.1290474000-709945659%22%2C%22secret%22%3A%22MWJtf5hKBGaBenCUo_1daQ__%22%2C%22expires%22%3A1290474000%2C%22access_token%22%3A%22153578481351853%7C2.oKqpoDI3lQOO68OMJvuJAA__.3600.1290474000-709945659%7CTL4baljkzE2C2hMSrm-z0Zo5Ikg%22%2C%22sig%22%3A%22a12afab83e355050f4338b288058d51b%22%7D&session=%7B%22uid%22%3A%22709945659%22%2C%22session_key%22%3A%222.oKqpoDI3lQOO68OMJvuJAA__.3600.1290474000-709945659%22%2C%22secret%22%3A%22MWJtf5hKBGaBenCUo_1daQ__%22%2C%22expires%22%3A1290474000%2C%22access_token%22%3A%22153578481351853%7C2.oKqpoDI3lQOO68OMJvuJAA__.3600.1290474000-709945659%7CTL4baljkzE2C2hMSrm-z0Zo5Ikg%22%2C%22sig%22%3A%22a12afab83e355050f4338b288058d51b%22%7D#'
;$doneButtonLabelPrefix='http://facebook.zeroproblemu.pl/laptop/show/pm6mgnjbjb/?session=%7B%22uid%22%3A%22709945659%22%2C%22session_key%22%3A%222.UTjNKaDS6Jf1KmcLJodRGw__.3600.1290524400-709945659%22%2C%22secret%22%3A%22oeuJkhapbG5aCNMDJ_dLvw__%22%2C%22expires%22%3A1290524400%2C%22access_token%22%3A%22153578481351853%7C2.UTjNKaDS6Jf1KmcLJodRGw__.3600.1290524400-709945659%7Cm0znDcY-diaJsj-fmJ7X5U1K1lg%22%2C%22sig%22%3A%22d71817f9d8d61bf9aeee91b8bc73e241%22%7D#'
$helpingbuttonLabelMatcher='session'
AutoItSetOption("WinTitleMatchMode", 2)

Func scrollDownOnePage()
	send("{DOWN}{DOWN}{DOWN}{DOWN}")
EndFunc

Func openHashWindow($hash)

	$url = $URL_PROFILE_PREFIX & $hash

	$pid = -1
	If $USE_CHROME Then
		$pid = run($PATH_CHROME & ' ' & $url)
		AutoItSetOption("WinTitleMatchMode", 2)
		WinWaitActive($WINMATCHER_CHROME)
		;WinSetState($WINMATCHER_CHROME,"",@SW_MAXIMIZE)
		;Send("{LWINDOWN}{UP}{LWINUP}")
		;ConsoleWrite("chrome window opened, pid=" & $pid & @CRLF)
	Else
		$pid = run($PATH_IE & ' ' & $url)
		winwait($WINMATCHER_IE)
		;WinSetState($WINMATCHER_IE,"",@SW_MAXIMIZE)
	EndIf

	TrayTip("","waiting for the RED button",($RED_BUTTON_WAIT_TIMEOUT+$RED_BUTTON_STATIC_SLEEP)/1000)
	WaitForRedButton($RED_BUTTON_WAIT_TIMEOUT)
	Sleep($RED_BUTTON_STATIC_SLEEP)

	Return $pid
EndFunc

Func ButtonExists($x,$y,$color)
	If $USE_CHROME Then
		Opt("PixelCoordMode", 0)        ;1=absolute, 0=relative, 2=client
		Return PixelGetColor($x,$y) = $color
	Else
		Return 0
	EndIf
EndFunc
Func WaitForPage($timeout)
	$totalWaited = 0
	$loopSleep = 100
	While not ButtonExists($BLUE_X,$BLUE_Y,$BLUE_COLOR)
		If $totalWaited >= $timeout Then
			Return
		EndIf
		Sleep($loopSleep)
		$totalWaited = $totalWaited + $loopSleep
	WEnd
EndFunc
Func WaitForBlueButton($timeout)
	$totalWaited = 0
	$loopSleep = 100
	While not ButtonExists($BLUE_X,$BLUE_Y,$BLUE_COLOR)
		If $totalWaited >= $timeout Then
			Return
		EndIf
		Sleep($loopSleep)
		$totalWaited = $totalWaited + $loopSleep
	WEnd
EndFunc
Func WaitForRedButton($timeout)
	$totalWaited = 0
	$loopSleep = 100
	While not ButtonExists($RED_X,$RED_Y,$RED_COLOR)
		If $totalWaited >= $timeout Then
			Return
		EndIf
		Sleep($loopSleep)
		$totalWaited = $totalWaited + $loopSleep
	WEnd
EndFunc
Func helpIfPossible($winmatcher, $hash,$jumpSleep)
	If ButtonExists($RED_X,$RED_Y,$RED_COLOR) Then ;POMOZ button detected

		Opt("MouseCoordMode", 0)        ;1=absolute, 0=relative, 2=client
		$rand_x = Random(-5,5)
		$rand_y = Random(-2,3)
		MouseMove($RED_X+$rand_x,$RED_Y+$rand_y,2)

		Sleep(50+Random(0,50))
		MouseClick("left") ;POMOZ click

		jx_log("waiting for the BLUE button", $BLUE_BUTTON_WAIT_TIMEOUT/1000)
		WaitForBlueButton($BLUE_BUTTON_WAIT_TIMEOUT)
		Sleep($BLUE_BUTTON_STATIC_SLEEP)

		If ButtonExists($BLUE_X,$BLUE_Y,$BLUE_COLOR) Then ; if helped after all, add to helped.txt
			jx_log("adding hash to helped.txt:  " & $hash, 1)
			jx_arrayToFileAppend($FILE_HASHES_HELPED,$hash)
		Else
			jx_log("I clicked POMӯ but am not sure if it worked for hash: " & $hash, 1)
			jx_arrayToFileAppend($FILE_HASHES_SKIPPED,$hash)
		EndIf
		Sleep(500)
	Else
		If ButtonExists($BLUE_X,$BLUE_Y,$BLUE_COLOR) Then ;I helped already, adding to helped.txt
			jx_log("adding hash to helped.txt:  " & $hash, 1)
			jx_arrayToFileAppend($FILE_HASHES_HELPED,$hash)
		Else
			jx_log("None of the buttons was found. Skipping hash: " & $hash, 1)
			jx_arrayToFileAppend($FILE_HASHES_SKIPPED,$hash)
		EndIf
		Sleep(500)
	EndIf
EndFunc
Func hashHelpingCycle($hashesToHelp)

	jx_log("Hashes to help: " & UBound($hashesToHelp), 2)

	For $i = 0 To UBound($hashesToHelp)-1 Step +1
		TrayTip("",$i,10)
	;For $i = UBound($hashesToHelp)-1 To 0 Step -1
		If $hashesToHelp[$i] == "" Then
			ContinueLoop
		EndIf
		$pid = openHashWindow($hashesToHelp[$i])

		;WinActivate($WINMATCHER_IE)
		helpIfPossible($WINMATCHER_IE, $hashesToHelp[$i],10)
		If $USE_CHROME Then
			;killChromeWindow($pid)
			;$activeWindow = WinGetActive()
			;WinKill($activeWindow)
			;Send("!{F4}")
			killWindowsChrome()
		Else
			killWindowsIE()
		EndIf
	Next
EndFunc
Func makeHashes()
	TrayTip("","creating hash list...",10000)

	Dim $initialHashes
	jx_fileToArray($FILE_HASHES_ALL, $initialHashes)
	Dim $helpedHashes
	jx_fileToArray($FILE_HASHES_HELPED, $helpedHashes)

	$hashes = jx_arrayExclude($initialHashes,$helpedHashes)
	return $hashes
EndFunc

Func generateTmpHashes()
	jx_fileRecordsUnique($FILE_HASHES_HELPED)
	$tmp_hashes = makeHashes()
	jx_arrayToFile($FILE_HASHES_TMP, $tmp_hashes)
EndFunc
Func runTmpHashes()
	Dim $tmp_hashes
	jx_fileToArray($FILE_HASHES_TMP, $tmp_hashes)
	hashHelpingCycle($tmp_hashes)
EndFunc
Func runTmpHashesNoSkipped()
	Dim $tmp_hashes
	jx_fileToArray($FILE_HASHES_TMP, $tmp_hashes)
	Dim $skippedHashes
	jx_fileToArray($FILE_HASHES_SKIPPED, $skippedHashes)

	$hashes = jx_arrayExclude($tmp_hashes,$skippedHashes)
	hashHelpingCycle($hashes)
EndFunc
Func loopForManual()
	Dim $myhashes
	jx_fileToArray("D:\NEW_NEW", $myhashes)
	;Dim $nocrap
	;jx_fileToArray("D:\nocrap.txt", $nocrap)
	;$hashes = jx_arrayExclude($myhashes,$nocrap)
	;jx_arrayToFileAppend("D:\crap.txt",$hashes)

	For $i = 0 To UBound($myhashes) -1
		TrayTip("",$i,99999)
		$hash = $myhashes[$i]
		$url = $URL_PROFILE_PREFIX & $hash
		run($PATH_CHROME & ' ' & $url)
		Sleep(6500+Random(0,1000))
	Next
EndFunc
Func trimHashes()
	Dim $hashes
	jx_fileToArray("D:\visited.txt", $hashes)

	For $i = 0 To UBound($hashes)-1
		$hash = StringTrimRight(StringTrimLeft($hashes[$i],44),1)
		jx_arrayToFileAppend("D:\new.txt",$hash)
	Next

EndFunc


;generateTmpHashes()
;runTmpHashes()
;runTmpHashesNoSkipped()
loopForManual()
;trimHashes()
;jx_fileRecordsUnique($FILE_HASHES_SKIPPED)
;Exit


;---------------------------------------------------------

;jx_fileRecordsUnique($FILE_HASHES_HELPED)
;jx_fileRecordsUnique($FILE_HASHES_ALL)
;jx_fileRecordsUnique($FILE_HASHES_CRAP)
;jx_fileRecordsUnique($FILE_HASHES_TMP)


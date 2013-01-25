#include <ext_lib.au3>

HotKeySet("x","end")
Func end()
	Exit
EndFunc

$USE_CHROME = True

$RED_BUTTON_WAIT_TIMEOUT = 12000
$BLUE_BUTTON_WAIT_TIMEOUT = 12000
$RED_BUTTON_STATIC_SLEEP = Random(3100,4500)
$BLUE_BUTTON_STATIC_SLEEP = Random(3000,4200)


;$READ_WRITE_APPEND = 1
$hashesFilepath = "generateOnPhoeniInstead_D:\all.txt"
$helpedFilepath = "X:\helped.txt"
$tmp_hashes_file="X:\_tmp_hashes_to_help.txt"
;$FILE_HASHES_SKIPPED="X:\skipped.txt"
$FILE_HASHES_SKIPPED="X:\NEW_NEW"
$iePath = 'C:\Program Files (x86)\Internet Explorer\iexplore.exe'

$chromePath = '"C:\Documents and Settings\jaccus\Ustawienia lokalne\Dane aplikacji\Google\Chrome\Application\chrome.exe" --new-window --start-maximized'

$winmatcherComplex = 'Windows Internet Explorer'
$chromeWinMatcher = 'Google Chrome'
$profileLinkPrefix = 'http://facebook.zeroproblemu.pl/laptop/show/'
$sampleHash = 'b4xfjbnskf' ;unknown guy
$sampleHashHelped = 'a8bepxhjrz' ;sanecki
$iconX = 141 ; 142 original -1 for 100% hit
$iconY = 54 ;55 original -1 for 100% hit


;REMEMBER TO SET WINDOW INFO TO RELATIVE!!!!
$red_x=733
$red_y=493
$red_color=0xF6001C
$blue_x=504
$blue_y=473
$blue_color=0x6079AB

$helpButtonX=$red_x
$helpButtonY=$red_y
$helpButtonX_chrome=$red_x
$helpButtonY_chrome=$red_y


$helpButtonLabelPrefix='http://facebook.zeroproblemu.pl/laptop/show/b4xfjbnskf/?session=%7B%22uid%22%3A%22709945659%22%2C%22session_key%22%3A%222.oKqpoDI3lQOO68OMJvuJAA__.3600.1290474000-709945659%22%2C%22secret%22%3A%22MWJtf5hKBGaBenCUo_1daQ__%22%2C%22expires%22%3A1290474000%2C%22access_token%22%3A%22153578481351853%7C2.oKqpoDI3lQOO68OMJvuJAA__.3600.1290474000-709945659%7CTL4baljkzE2C2hMSrm-z0Zo5Ikg%22%2C%22sig%22%3A%22a12afab83e355050f4338b288058d51b%22%7D&session=%7B%22uid%22%3A%22709945659%22%2C%22session_key%22%3A%222.oKqpoDI3lQOO68OMJvuJAA__.3600.1290474000-709945659%22%2C%22secret%22%3A%22MWJtf5hKBGaBenCUo_1daQ__%22%2C%22expires%22%3A1290474000%2C%22access_token%22%3A%22153578481351853%7C2.oKqpoDI3lQOO68OMJvuJAA__.3600.1290474000-709945659%7CTL4baljkzE2C2hMSrm-z0Zo5Ikg%22%2C%22sig%22%3A%22a12afab83e355050f4338b288058d51b%22%7D#'
;$doneButtonX=590
;$doneButtonY=604
;$doneButtonLabelPrefix='http://facebook.zeroproblemu.pl/laptop/show/pm6mgnjbjb/?session=%7B%22uid%22%3A%22709945659%22%2C%22session_key%22%3A%222.UTjNKaDS6Jf1KmcLJodRGw__.3600.1290524400-709945659%22%2C%22secret%22%3A%22oeuJkhapbG5aCNMDJ_dLvw__%22%2C%22expires%22%3A1290524400%2C%22access_token%22%3A%22153578481351853%7C2.UTjNKaDS6Jf1KmcLJodRGw__.3600.1290524400-709945659%7Cm0znDcY-diaJsj-fmJ7X5U1K1lg%22%2C%22sig%22%3A%22d71817f9d8d61bf9aeee91b8bc73e241%22%7D#'
$helpingbuttonLabelMatcher='session'
AutoItSetOption("WinTitleMatchMode", 2)

Func scrollDownOnePage()
	send("{DOWN}{DOWN}{DOWN}{DOWN}")
	;send("{DOWN}{DOWN}{DOWN}{DOWN}")
EndFunc

Func extractHashes($winmatcher, $jumpX, $jumpY, $jumpSleep)


	$stepsY = ( @DesktopHeight / $jumpY ) - 1
	$stepsX = ( @DesktopWidth / $jumpX ) - 1
	WinActivate($winmatcher)
	WinWaitActive($winmatcher)

	Dim $profileLinks[1]
	$nrOfLinks = 0
	For $x = 1 to $stepsX Step +1 ;start from 1 to skip desktop border
		For $y = 1 to $stepsY Step +1
			MouseMove($x * $jumpX, $y * $jumpY,0)
			Sleep($jumpSleep)

			;eg: http://facebook.zeroproblemu.pl/laptop/show/bnfhpy7q2f/
			;trimming left to: http://facebook.zeroproblemu.pl/laptop/show/ = 44
			;trimming right eg: bnfhpy7q2f/ = 11

			$status = StatusbarGetText($winmatcher, "", 1)
			$trimmed = StringTrimRight($status, 11)

			If $trimmed == $profileLinkPrefix Then

				$hash = StringTrimRight(StringTrimLeft($status,44),1)

				If $nrOfLinks = 0 Then
					$profileLinks[0] = $hash
				Else
					_ArrayAdd($profileLinks, $hash)
				EndIf
				$nrOfLinks = $nrOfLinks + 1

			EndIf
		Next
	Next

	jx_arrayUnique($profileLinks)

	Return $profileLinks
EndFunc
Func openHashWindow($hash)

	$url = $profileLinkPrefix & $hash

	$pid = -1
	If $USE_CHROME Then
		$pid = run($chromePath & ' ' & $url)
		AutoItSetOption("WinTitleMatchMode", 2)
		WinWaitActive($chromeWinMatcher)
		;WinSetState($chromeWinMatcher,"",@SW_MAXIMIZE)
		;Send("{LWINDOWN}{UP}{LWINUP}")
		;	ConsoleWrite("chrome window opened, pid=" & $pid & @CRLF)
	Else
		$pid = run($iePath & ' ' & $url)
		winwait($winmatcherComplex)
		;WinSetState($winmatcherComplex,"",@SW_MAXIMIZE)
	EndIf

	TrayTip("","waiting for the RED button",($RED_BUTTON_WAIT_TIMEOUT+$RED_BUTTON_STATIC_SLEEP)/1000)
	WaitForRedButton($RED_BUTTON_WAIT_TIMEOUT)
	Sleep($RED_BUTTON_STATIC_SLEEP)

	Return $pid
EndFunc
Func dontuse_hashGatheringCycle()
	Dim $initialHashes
	jx_fileToArray($hashesFilepath, $initialHashes)

	For $i = 0 To UBound($initialHashes)-1 Step +1
		openHashWindow($initialHashes[$i])
		scrollDownOnePage()
		$hashes = extractHashes($winmatcherComplex,$iconX,$iconY,5)

		WinClose($winmatcherComplex)

		jx_arrayToFileAppend($hashesFilepath, $hashes)
	Next
	jx_fileRecordsUnique($hashesFilepath)
EndFunc
Func BlueButtonExists()
	If $USE_CHROME Then
		;Opt("MouseCoordMode", 0)        ;1=absolute, 0=relative, 2=client
		Opt("PixelCoordMode", 0)        ;1=absolute, 0=relative, 2=client
		;Return PixelGetColor(561,501) = 0x6079AB ;PHOENIX chrome window coords
		;Return PixelGetColor(651,431) = 0x6079AB ;PHOENIX chrome window coords new
		Return PixelGetColor($blue_x,$blue_y) = $blue_color ;XP5

	Else
		Return 0;PixelGetColor(563,602) = 0x6079AB ;PHOENIX
		;Return PixelGetColor(563,602) = 0x6079AB ;XP2
	EndIf
EndFunc
Func RedButtonExists()
	If $USE_CHROME Then
		Opt("PixelCoordMode", 0)        ;1=absolute, 0=relative, 2=client
		;Return PixelGetColor(788,519) = 0xF6001C ;PHOENIX chrome window coords
		;Return PixelGetColor(840,446) = 0xF6001C ;PHOENIX chrome window coords new
		Return PixelGetColor($red_x,$red_y) = $red_color ;XP5
	Else
		Return 0;PixelGetColor(791,624) = 0xF6001C ;PHOENIX
		;Return PixelGetColor(791,611) = 0xF6001C ;XP2
	EndIf
EndFunc
Func WaitForBlueButton($timeout)
	$totalWaited = 0
	$loopSleep = 20
	While not BlueButtonExists()
		If $totalWaited >= $timeout Then
			Return
		EndIf
		Sleep($loopSleep)
		$totalWaited = $totalWaited + $loopSleep
	WEnd
EndFunc
Func WaitForRedButton($timeout)
	$totalWaited = 0
	$loopSleep = 20
	While not RedButtonExists()
		If $totalWaited >= $timeout Then
			Return
		EndIf
		Sleep($loopSleep)
		$totalWaited = $totalWaited + $loopSleep
	WEnd
EndFunc
Func helpIfPossible($winmatcher, $hash,$jumpSleep)
	;If checkButtonExists($winmatcher, $helpButtonX, $helpButtonY,500) Then ;POMOZ button detected
	If RedButtonExists() Then ;POMOZ button detected

		If $USE_CHROME Then
			Opt("MouseCoordMode", 0)        ;1=absolute, 0=relative, 2=client
			MouseMove($helpButtonX_chrome,$helpButtonY_chrome,2)
		Else
			MouseMove($helpButtonX,$helpButtonY,2)
		EndIf

		;Sleep(20)
		MouseClick("left") ;POMOZ click

		TrayTip("","waiting for the BLUE button",$BLUE_BUTTON_WAIT_TIMEOUT/1000)
		WaitForBlueButton($BLUE_BUTTON_WAIT_TIMEOUT)
		Sleep($BLUE_BUTTON_STATIC_SLEEP)

		If BlueButtonExists() Then ; if helped after all, add to helped.txt
			$text = "adding hash to helped.txt:  " & $hash
			ConsoleWrite($text & @LF)
			TrayTip("",$text,1)
			jx_arrayToFileAppend($helpedFilepath,$hash)
		Else
			$text = "I clicked POMOZ but am not sure if it worked for hash: " & $hash
			jx_arrayToFileAppend($FILE_HASHES_SKIPPED,$hash)
			ConsoleWrite($text & @LF)
			TrayTip("",$text,1)
		EndIf
		Sleep(100)
	Else
		If BlueButtonExists() Then ;I helped already, adding to helped.txt
			$text = "adding hash to helped.txt:  " & $hash
			ConsoleWrite($text & @LF)
			TrayTip("",$text,1)
			jx_arrayToFileAppend($helpedFilepath,$hash)
		Else
			$text = "None of the buttons was found. Skipping hash: " & $hash
			ConsoleWrite($text & @LF)
			TrayTip("",$text,1)
			jx_arrayToFileAppend($FILE_HASHES_SKIPPED,$hash)
		EndIf
		Sleep(100)
	EndIf
EndFunc
Func hashHelpingCycle($hashesToHelp)

	$text = "Hashes to help: " & UBound($hashesToHelp)
	ConsoleWrite($text & @LF)
	TrayTip("",$text,2)

	;For $i = 0 To UBound($hashesToHelp)-1 Step +1
	For $i = UBound($hashesToHelp)-1 To 0 Step -1
		TrayTip("",$i,10)
		If $hashesToHelp[$i] == "" Then
			ContinueLoop
		EndIf
		$pid = openHashWindow($hashesToHelp[$i])

		helpIfPossible($winmatcherComplex, $hashesToHelp[$i],10)
		If $USE_CHROME Then
			killWindowsChrome()
		Else
			killWindowsIE()
		EndIf
	Next
EndFunc
Func makeHashes()
	TrayTip("","creating hash list...",10)

	Dim $initialHashes
	jx_fileToArray($hashesFilepath, $initialHashes)
	Dim $helpedHashes
	jx_fileToArray($helpedFilepath, $helpedHashes)

	$hashes = jx_arrayExclude($initialHashes,$helpedHashes)
	return $hashes
EndFunc

Func generateTmpHashes()
	jx_fileRecordsUnique($helpedFilepath)
	$tmp_hashes = makeHashes()
	jx_arrayToFile($tmp_hashes_file, $tmp_hashes)
EndFunc
Func runTmpHashes()
	Dim $tmp_hashes
	jx_fileToArray($tmp_hashes_file, $tmp_hashes)
	hashHelpingCycle($tmp_hashes)
EndFunc
Func runTmpHashesNoSkipped()
	Dim $tmp_hashes
	jx_fileToArray($tmp_hashes_file, $tmp_hashes)
	Dim $skippedHashes
	jx_fileToArray($FILE_HASHES_SKIPPED, $skippedHashes)

	$hashes = jx_arrayExclude($tmp_hashes,$skippedHashes)
	hashHelpingCycle($hashes)
EndFunc

;generateTmpHashes()
runTmpHashes()
;runTmpHashesNoSkipped()


;---------------------------------------------------------




;jx_fileRecordsUnique($hashesFilepath)

;ConsoleWrite("-------------" & not StringInStr($helpButtonLabelPrefix,$helpingbuttonLabelMatcher) & "-------------" & @LF)
;ConsoleWrite("-------------" & not StringInStr($helpButtonLabelPrefix,"blablabla") & "-------------" & @LF)
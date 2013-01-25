#include <ext_lib.au3>

HotKeySet("x","end")
Func end()
	Exit
EndFunc

$RED_BUTTON_WAIT_TIMEOUT = 20000
$BLUE_BUTTON_WAIT_TIMEOUT = 20000
$RED_BUTTON_STATIC_SLEEP = Random(1000,1200)
$BLUE_BUTTON_STATIC_SLEEP = $RED_BUTTON_STATIC_SLEEP

$AWAIT_PAGELOAD_DELAY=15000
$AWAIT_AFTER_HELP_CLICKED_DELAY=15000

$AWAIT_PAGELOAD_RANDOM_DIST=5000


$READ_WRITE_APPEND = 1

$hashesFilepath = "X:\test_popular2.txt"
$hashesFilepathInput = "X:\popular2.txt"

$helpedFilepath = "X:\helped.txt"
$iePath = 'C:\Program Files\Internet Explorer\iexplore.exe'
Global $winmatcherComplex = 'Toshibobranie on Facebook - Windows Internet Explorer'
;$winmatcherComplex = 'Windows Internet Explorer'
$profileLinkPrefix = 'http://facebook.zeroproblemu.pl/laptop/show/'
$sampleHash = 'b4xfjbnskf' ;unknown guy
$sampleHashHelped = 'a8bepxhjrz' ;sanecki
;$iconX = 141 ; 142 original -1 for 100% hit
;$iconY = 54 ;55 original -1 for 100% hit
$iconX = 100 ; 142 original -1 for 100% hit - A BIT TIGHTER
$iconY = 30 ;55 original -1 for 100% hit - A BIT TIGHTER


$helpButtonX=740
$helpButtonY=600
$helpButtonLabelPrefix='http://facebook.zeroproblemu.pl/laptop/show/b4xfjbnskf/?session=%7B%22uid%22%3A%22709945659%22%2C%22session_key%22%3A%222.oKqpoDI3lQOO68OMJvuJAA__.3600.1290474000-709945659%22%2C%22secret%22%3A%22MWJtf5hKBGaBenCUo_1daQ__%22%2C%22expires%22%3A1290474000%2C%22access_token%22%3A%22153578481351853%7C2.oKqpoDI3lQOO68OMJvuJAA__.3600.1290474000-709945659%7CTL4baljkzE2C2hMSrm-z0Zo5Ikg%22%2C%22sig%22%3A%22a12afab83e355050f4338b288058d51b%22%7D&session=%7B%22uid%22%3A%22709945659%22%2C%22session_key%22%3A%222.oKqpoDI3lQOO68OMJvuJAA__.3600.1290474000-709945659%22%2C%22secret%22%3A%22MWJtf5hKBGaBenCUo_1daQ__%22%2C%22expires%22%3A1290474000%2C%22access_token%22%3A%22153578481351853%7C2.oKqpoDI3lQOO68OMJvuJAA__.3600.1290474000-709945659%7CTL4baljkzE2C2hMSrm-z0Zo5Ikg%22%2C%22sig%22%3A%22a12afab83e355050f4338b288058d51b%22%7D#'
$doneButtonX=600
$doneButtonY=600
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
	;WinActivate($winmatcher)
	;Sleep(200)
	;WinWaitActive($winmatcher)
	
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
	run($iePath & ' ' & $url)

	TrayTip("sleeping","waiting for the red button",$RED_BUTTON_WAIT_TIMEOUT/1000)
	WaitForAnyButton($RED_BUTTON_WAIT_TIMEOUT)
	Sleep($RED_BUTTON_STATIC_SLEEP)
EndFunc
Func BlueButtonExists()
	;Return PixelGetColor(563,602) = 0x6079AB ;PHOENIX
	;Return PixelGetColor(563,602) = 0x6079AB ;XP2 1280x800
	Return PixelGetColor(500,593) = 0x6079AB ;XP2 1152x770
	
EndFunc
Func RedButtonExists()
	;Return PixelGetColor(791,624) = 0xF6001C ;PHOENIX
	;Return PixelGetColor(791,611) = 0xF6001C ;XP2 1280x800
	Return PixelGetColor(727,611) = 0xF6001C ;XP2 1152x770
EndFunc
Func WaitForBlueButton($timeout)
	$totalWaited = 0
	$loopSleep = 100
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
	$loopSleep = 100
	While not RedButtonExists()
		If $totalWaited >= $timeout Then
			Return
		EndIf
		Sleep($loopSleep)
		$totalWaited = $totalWaited + $loopSleep
	WEnd
EndFunc
Func WaitForAnyButton($timeout)
	$totalWaited = 0
	$loopSleep = 100
	While ( not RedButtonExists() ) and ( not BlueButtonExists() )
		If $totalWaited >= $timeout Then
			Return
		EndIf
		Sleep($loopSleep)
		$totalWaited = $totalWaited + $loopSleep
	WEnd
EndFunc
Func hashGatheringCycle()
	Dim $initialHashes
	jx_fileToArray($hashesFilepathInput, $initialHashes)

	For $i = 0 To UBound($initialHashes)-1 Step +1
		openHashWindow($initialHashes[$i])
		scrollDownOnePage()
		$hashes = extractHashes($winmatcherComplex,$iconX,$iconY,5)

		killWindowsIE()
		
		jx_arrayToFileAppend($hashesFilepath, $hashes)
		jx_fileRecordsUnique($hashesFilepath)
	Next
EndFunc
		
;~ Func helpIfPossible($winmatcher, $hash,$jumpSleep)
;~ 	If checkButtonExists($winmatcher, $helpButtonX, $helpButtonY,100) Then ;POMOZ button detected
;~ 		
;~ 		MouseMove($helpButtonX,$helpButtonY,50)
;~ 		Sleep(200)
;~ 		MouseClick("left") ;POMOZ click
;~ 		Sleep(200)
;~ 		MouseClick("left") ;POMOZ click
;~ 		Sleep(200)
;~ 		MouseClick("left") ;POMOZ click
;~ 		
;~ 		$delay = Random($AWAIT_AFTER_HELP_CLICKED_DELAY,$AWAIT_AFTER_HELP_CLICKED_DELAY+$AWAIT_PAGELOAD_RANDOM_DIST)
;~ 		
;~ 		ConsoleWrite("delay:" & $delay)
;~ 		
;~ 		TrayTip("sleeping","after POMOZ button clicked",$delay/1000)
;~ 		Sleep($delay); sleep after POMOZ click
;~ 		
;~ 		
;~ 		If checkButtonExists($winmatcher, $doneButtonX,$doneButtonY,100) Then ; if helped after all, add to helped.txt
;~ 			jx_arrayToFileAppend($helpedFilepath,$hash) 
;~ 		Else
;~ 			ConsoleWrite("I clicked POMOZ but am not sure if it worked for hash: " & $hash & @LF)
;~ 		EndIf
;~ 	Else
;~ 		Sleep(1000)
;~ 		If checkButtonExists($winmatcher, $doneButtonX,$doneButtonY,100) Then ;I helped already, adding to helped.txt
;~ 			jx_arrayToFileAppend($helpedFilepath,$hash) ;
;~ 		Else
;~ 			ConsoleWrite("no button found.... skipping hash: " & $hash & @LF)
;~ 		EndIf
;~ 	EndIf
;~ EndFunc

;~ Func hashHelpingCycle()
;~ 	Dim $initialHashes
;~ 	jx_fileToArray($hashesFilepath, $initialHashes)
;~ 	Dim $helpedHashes
;~ 	jx_fileToArray($helpedFilepath, $helpedHashes)
;~ 	$hashesToHelp = jx_arrayExclude($initialHashes,$helpedHashes)
;~ 	For $i = 0 To UBound($hashesToHelp)-1 Step +1 ;start from 1 to skip myself
;~ 		openHashWindow($hashesToHelp[$i])
;~ 		;WinActivate($winmatcherComplex)
;~ 		helpIfPossible($winmatcherComplex, $hashesToHelp[$i],10)
;~ 		WinClose($winmatcherComplex)
;~ 	Next
;~ EndFunc

While True
	hashGatheringCycle()
WEnd
;hashHelpingCycle()

;jx_fileRecordsUnique($hashesFilepath)

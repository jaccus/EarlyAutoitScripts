#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ext_lib.au3>
#include <ie.au3>

HotKeySet("{F10}","end")
Func end()
	Exit
EndFunc

If $CmdLine[0] = 2 Then
	Global Const $FILE_HASHES_INPUT  = $CmdLine[1]
	Global Const $FILE_HASHES_OUTPUT = $CmdLine[2];"X:\test.txt"
Else
	ConsoleWrite("missing parameter to hashes file (input & output)" & @CRLF)
	Exit
EndIf

Global Const $PROFILE_LINK_PREFIX = 'http://facebook.zeroproblemu.pl/laptop/show/'
Global Const $PERSON_ICON_SIZE_X = 125 ; 142 original -1 for 100% hit - A BIT TIGHTER
Global Const $PERSON_ICON_SIZE_Y = 45 ;55 original -1 for 100% hit - A BIT TIGHTER
Global Const $MOUSE_JUMP_SLEEP = 3

AutoItSetOption("WinTitleMatchMode", 2)

Func extractHashes($ie_handle, $jumpX, $jumpY)
	$stepsY = ( @DesktopHeight / $jumpY ) - 1
	$stepsX = ( @DesktopWidth / $jumpX ) - 1

	Dim $profileLinks[1]
	$nrOfLinks = 0
	For $x = 1 to $stepsX - 1 Step +1 ;start from 1 to skip desktop border
		For $y = 1 to $stepsY Step +1
			MouseMove($x * $jumpX, $y * $jumpY,0)
			Sleep($MOUSE_JUMP_SLEEP)

			;eg: http://facebook.zeroproblemu.pl/laptop/show/bnfhpy7q2f/
			;trimming left to: http://facebook.zeroproblemu.pl/laptop/show/ = 44
			;trimming right eg: bnfhpy7q2f/ = 11

			$status = _IEPropertyGet($ie_handle,"statustext")
			$trimmed = StringTrimRight($status, 11)

			If $trimmed == $PROFILE_LINK_PREFIX Then

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
Func hashGatheringCycle()
	Dim $initialHashes
	jx_fileToArray($FILE_HASHES_INPUT, $initialHashes)

	For $i = UBound($initialHashes)-1 To 0 Step -1

		$oIE = _IECreate($PROFILE_LINK_PREFIX & $initialHashes[$i])
		$hHWnd = _IEPropertyGet($oIE, "hwnd"); get handle
		WinSetState($hHWnd, "", @SW_MAXIMIZE);
		send("{DOWN}{DOWN}{DOWN}{DOWN}")
		$hashes = extractHashes($oIE, $PERSON_ICON_SIZE_X, $PERSON_ICON_SIZE_Y)
		_IEQuit($oIE)

		jx_arrayToFileAppend($FILE_HASHES_OUTPUT, $hashes)
		jx_fileRecordsUnique($FILE_HASHES_OUTPUT)
	Next
EndFunc

While True
	hashGatheringCycle()
WEnd

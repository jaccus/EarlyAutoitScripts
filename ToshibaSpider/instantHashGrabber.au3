#include <ext_lib.au3>
$profileLinkPrefix = 'http://facebook.zeroproblemu.pl/laptop/show/'
$profileLinkPrefix2 = 'http://apps.facebook.com/toshibobranie/laptop/show/'

$newHashesFile = 'D:\new.txt'
$winmatcherComplex = 'Windows Internet Explorer'
AutoItSetOption("WinTitleMatchMode", 2)

HotKeySet("x","end")
Func end()
	Exit
EndFunc

;Dim $profileLinks[1]
while True
	$status = StatusbarGetText($winmatcherComplex, "", 1)

	$trimmed = StringTrimRight($status, 11)
	If $trimmed == $profileLinkPrefix Then
		$hash = StringTrimRight(StringTrimLeft($status,44),1)
		TrayTip($hash,"adding hash to new.txt",1)
		jx_arrayToFileAppend($newHashesFile,$hash)
		jx_fileRecordsUnique($newHashesFile)

	ElseIf $trimmed = $profileLinkPrefix2 Then
		$hash = StringTrimRight(StringTrimLeft($status,51),1)
		TrayTip($hash,"adding hash to new.txt",1)
		jx_arrayToFileAppend($newHashesFile,$hash)
		jx_fileRecordsUnique($newHashesFile)

	EndIf



	Sleep(50)
WEnd

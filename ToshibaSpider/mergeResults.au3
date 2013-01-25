#include <ext_lib.au3>

Dim $resultFiles[5]
$resultFiles[0] = "D:\all.txt"
$resultFiles[1] = "D:\xp2.txt"
$resultFiles[2] = "D:\test_popular.txt"
$resultFiles[3] = "D:\test_popular2.txt"
$resultFiles[4] = "D:\new.txt"

$f_all = "D:\all.txt"


Dim $aAll

For $i = 0 To 4
	ConsoleWrite("beginning loop " & $i & @CRLF)
	Dim $aTemp
	jx_fileToArray($resultFiles[$i], $aTemp)
	ConsoleWrite(UBound($aTemp) & @CRLF)
	$text = "reading file " & ($i+1) & ": " & $resultFiles[$i] & "..."
	ConsoleWrite($text & @CRLF)
	TrayTip("",$text,30)
	;_ArrayConcatenate($aTemp,$aAll)
	jx_arrayToFileAppend($f_all, $aTemp)
	;ConsoleWrite(UBound($aAll) & @CRLF)
Next

$text = "removing duplicates..."
ConsoleWrite($text & @CRLF)
TrayTip("",$text,30)
;jx_arrayUnique($aAll)
jx_fileRecordsUnique($f_all)

;$text = "writing results to " & $f_all & "..."
;ConsoleWrite($text & @CRLF)
;TrayTip("",$text,30)
;jx_arrayToFile($f_all, $aAll)
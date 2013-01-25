#include <Array.au3>
#include <file.au3>

Func _ArrayUniqueFast(Const ByRef $aArray, ByRef $aUnique)
    Local $sData = '', $sSep = ChrW(160)

    For $i = 0 To UBound($aArray) - 1
        If Not IsDeclared($aArray[$i] & '$') Then
            Assign($aArray[$i] & '$', 0, 1)
            $sData &= $aArray[$i] & $sSep
        EndIf
    Next
    $aUnique = StringSplit(StringTrimRight($sData, 1), $sSep)
EndFunc   ;==>_ArrayUniqueFast

Func jx_fileToArray($fname, ByRef $array)
	If Not _FileReadToArray($fname,$array) Then
		MsgBox(4096,"Error", " Error reading file to Array:" & @error)
		Exit
	EndIf
	_ArrayDelete($array,0)
EndFunc

Func jx_arrayToFile($fname, $array)
	If Not _FileWriteFromArray($fname, $array) Then
		MsgBox(4096,"Error", " Error writing Array to file:" & @error)
		Exit
	EndIf
EndFunc

Func jx_arrayToFileAppend($fname, $array)
	$fhandle = FileOpen($fname, 1) ; 1 = append
	If IsArray($array) Then
		If Not _FileWriteFromArray($fhandle, $array) Then
			MsgBox(4096,"Error", " Error appending Array to file:" & @error)
			Exit
		EndIf
	Else
		FileWrite($fhandle, $array & @CRLF)

	EndIf
	FileClose($fhandle)
EndFunc

Func jx_arrayUnique(ByRef $array)
	_ArrayUniqueFast($array, $array)
	_ArrayDelete($array,0)
EndFunc

Func jx_fileRecordsUnique($fname)
	Dim $aRecords
	jx_fileToArray($fname, $aRecords)
	jx_arrayUnique($aRecords)
	jx_arrayToFile($fname, $aRecords)
EndFunc

Func jx_arrayExclude($a, $b)
	$removedCount = 0
	;_ArraySort($a)
	For $i = 0 To UBound($b) - 1
		;Local $index = _ArrayBinarySearch( $a, $b[$i] )
		Local $index = _ArraySearch( $a, $b[$i] )
		If not @error Then
            _ArrayDelete($a, $index)
        EndIf
	Next
	Return $a
EndFunc

Func killWindowsIE()
	AutoItSetOption("WinTitleMatchMode", 2)
	$windows = ProcessList("iexplore.exe")
	;$windows = WinList("Internet Explorer")
	For $i = 1 To $windows[0][0]
		ProcessClose($windows[$i][1])
		;WinClose($windows[$i][0])
	Next
EndFunc

Func killWindowsChrome()
	AutoItSetOption("WinTitleMatchMode", 2)
	$windows = WinList("Google Chrome")
	For $i = 1 To $windows[0][0]
		;ConsoleWrite($windows[$i][0] & @CRLF)
		;ProcessClose($windows[$i][1])
		WinClose($windows[$i][0])
	Next
EndFunc

Func WinGetActive()
	Dim $window[2]
	Dim $winlist
	$winlist = WinList()
	For $i = 1 to $winlist[0][0]
		If $winlist[$i][0] <> "" AND IsVisible($winlist[$i][1]) Then
			$window[0] = $winlist[$i][0]
			$window[1] = $winlist[$i][1]
			ExitLoop
		EndIf
	Next
	Return $window
EndFunc


Func IsVisible($handle)
  If BitAnd( WinGetState($handle), 2 ) Then
    Return 1
  Else
    Return 0
  EndIf
EndFunc

Func jx_log($text, $delay)
	ConsoleWrite($text & @CRLF)
	TrayTip("",$text,$delay)
EndFunc

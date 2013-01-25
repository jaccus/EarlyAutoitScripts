Func showsplash($name, $version, $author,$msg,$delay)
	SplashTextOn($name & " " & $version & " by " & $author, "Starting..." & @CRLF & $msg  , 300,100)
	Sleep($delay)
	SplashOff()
EndFunc
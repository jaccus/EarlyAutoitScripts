#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.8.1
 Author:         someone

 Script Function:
	MouseClickPlus

#ce ----------------------------------------------------------------------------

Func _MouseClickPlus($Window, $Button = "left", $X = "", $Y = "", $Clicks = 1)
  Local $MK_LBUTTON       =  0x0001
  Local $WM_LBUTTONDOWN   =  0x0201
  Local $WM_LBUTTONUP     =  0x0202
  
  Local $MK_RBUTTON       =  0x0002   
  Local $WM_RBUTTONDOWN   =  0x0204
  Local $WM_RBUTTONUP     =  0x0205

  Local $WM_MOUSEMOVE     =  0x0200
  
  Local $i                = 0
  
  Select 
  Case $Button = "left"
     $Button     =  $MK_LBUTTON
     $ButtonDown =  $WM_LBUTTONDOWN
     $ButtonUp   =  $WM_LBUTTONUP
  Case $Button = "right"
     $Button     =  $MK_RBUTTON
     $ButtonDown =  $WM_RBUTTONDOWN
     $ButtonUp   =  $WM_RBUTTONUP
  EndSelect
  
  If $X = "" OR $Y = "" Then
     $MouseCoord = MouseGetPos()
     $X = $MouseCoord[0]
     $Y = $MouseCoord[1]
  EndIf
  
  For $i = 1 to $Clicks
     DllCall("user32.dll", "int", "SendMessage", _
        "hwnd",  WinGetHandle( $Window ), _
        "int",   $WM_MOUSEMOVE, _
        "int",   0, _
        "long",  _MakeLong($X, $Y))
        
     DllCall("user32.dll", "int", "SendMessage", _
        "hwnd",  WinGetHandle( $Window ), _
        "int",   $ButtonDown, _
        "int",   $Button, _
        "long",  _MakeLong($X, $Y))
        
     DllCall("user32.dll", "int", "SendMessage", _
        "hwnd",  WinGetHandle( $Window ), _
        "int",   $ButtonUp, _
        "int",   $Button, _
        "long",  _MakeLong($X, $Y))
  Next
EndFunc

Func _MakeLong($LoWord,$HiWord)
  Return BitOR($HiWord * 0x10000, BitAND($LoWord, 0xFFFF))
EndFunc

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <IE.au3>

$profileLinkPrefix = 'http://facebook.zeroproblemu.pl/laptop/show/'
$sampleHash = 'b4xfjbnskf' ;unknown guy
$sampleHashHelped = 'a8bepxhjrz' ;sanecki

$iew = 1000
$ieh = 600
$oIE = _IECreateEmbedded ()
$gui = GUICreate("Embedded Web control Test", $iew, $ieh, _
        (@DesktopWidth - $iew) / 2, (@DesktopHeight - $ieh) / 2, _
        $WS_OVERLAPPEDWINDOW + $WS_VISIBLE + $WS_CLIPSIBLINGS + $WS_CLIPCHILDREN)
$GUIActiveX = GUICtrlCreateObj($oIE, 10, 40, $iew, $ieh)
GUISetState()       ;Show GUI
;_IENavigate ($oIE, "http://www.autoitscript.com")
$1 = _IEAttach($gui,"Embedded")
_IENavigate ($1, $profileLinkPrefix & $sampleHashHelped)
While 1
    Sleep(10)
WEnd
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.8.1
 Author:         Jaccus

 Script Function:
	GrushHelper GUI

#ce ----------------------------------------------------------------------------

#include <GuiConstants.au3>
#include <MouseClickPlus.au3>

$GHTitle = "GrushHelper v0.1"


GuiCreate($GHTitle, 95, 500)
GuiSetIcon(@SystemDir & "\mspaint.exe", 0)

;ontop
$OnTopCheckBox = GUICtrlCreateCheckbox("Always On Top",1,1,100,20)
;party
$PartyAll = GUICtrlCreateButton("PartyAll",1,20,75,20)
$PartyNone = GUICtrlCreateButton("PartyNone",1,40,75,20)
;move up
$MoveUpLeft = GUICtrlCreateButton("NW",1,70,25,25)
$MoveUp = GUICtrlCreateButton("N",26,70,25,25)
$MoveUpRight = GUICtrlCreateButton("NE",51,70,25,25)
;move center
$MoveLeft = GUICtrlCreateButton("W",1,95,25,25)
$MoveLabel = GUICtrlCreateLabel("MV",31,100,25,25)
$MoveRight = GUICtrlCreateButton("E",51,95,25,25)
;move down
$MoveDownLeft = GUICtrlCreateButton("SW",1,120,25,25)
$MoveDown = GUICtrlCreateButton("S",26,120,25,25)
$MoveDownRight = GUICtrlCreateButton("SE",51,120,25,25)
;join
$JoinMules = GUICtrlCreateButton("JoinMules",1,145,75,20)
$DropAnnis = GUICtrlCreateButton("DropAnnis",1,165,75,20)
$KillAnners = GUICtrlCreateButton("KillAnners",1,185,75,20)
$KillStorers = GUICtrlCreateButton("KillStorers",1,205,75,20)
;running sitters
$RunFirstSitters = GUICtrlCreateButton("Sitters1st",1,245,75,20)
$RunSecondSitters = GUICtrlCreateButton("Sitters2nd",1,265,75,20)
$RunThirdSitters = GUICtrlCreateButton("Sitters3rd",1,285,75,20)
;config
$OpenButton = GUICtrlCreateButton("Open Config",1,325,80,20)
$ReloadButton = GUICtrlCreateButton("Reload Config",1,345,80,20)
;pwe
$KillSittersButton = GUICtrlCreateButton("Kill Sitters",1,385,80,20)
$KillDiablosButton = GUICtrlCreateButton("Kill Diablos",1,405,80,20)
;copyright
$AuthorLabel = GUICtrlCreateLabel("(c) 2007 by Jaccus",1,480,100,20)

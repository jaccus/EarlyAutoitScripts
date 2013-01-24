#include <px_gui.au3>

$ProcessSC = "sc32.exe"
$TitleSC = "SocksCap Control"
$IniName = "px_settings.ini"
$ResizeHeight = 645
$ResizeWidth = 254
$ErrorTitle = "Error"
$ErrorExist = "Run SocksCap first..."
Opt("GUIResizeMode", 0)
Opt("GUICoordMode",1)

$IniLocation = @WorkingDir & "\" & $IniName
$DirSC = IniRead($IniLocation,"data","address","NotFound")
$AdresSC = $DirSC & $ProcessSC
$IniDir = @WorkingDir & "\"
Func CheckSections()
If Not SectionCheckExists("proxy1") Then
GUICtrlSetState($Import1Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import1Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy2") Then
GUICtrlSetState($Import2Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import2Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy3") Then
GUICtrlSetState($Import3Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import3Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy4") Then
GUICtrlSetState($Import4Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import4Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy5") Then
GUICtrlSetState($Import5Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import5Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy6") Then
GUICtrlSetState($Import6Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import6Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy7") Then
GUICtrlSetState($Import7Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import7Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy8") Then
GUICtrlSetState($Import8Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import8Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy9") Then
GUICtrlSetState($Import9Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import9Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy10") Then
GUICtrlSetState($Import10Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import10Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy11") Then
GUICtrlSetState($Import11Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import11Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy12") Then
GUICtrlSetState($Import12Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import12Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy13") Then
GUICtrlSetState($Import13Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import13Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy14") Then
GUICtrlSetState($Import14Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import14Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy15") Then
GUICtrlSetState($Import15Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import15Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy16") Then
GUICtrlSetState($Import16Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import16Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy17") Then
GUICtrlSetState($Import17Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import17Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy18") Then
GUICtrlSetState($Import18Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import18Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy19") Then
GUICtrlSetState($Import19Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import19Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy20") Then
GUICtrlSetState($Import20Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import20Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy21") Then
GUICtrlSetState($Import21Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import21Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy22") Then
GUICtrlSetState($Import22Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import22Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy23") Then
GUICtrlSetState($Import23Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import23Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy24") Then
GUICtrlSetState($Import24Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import24Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy25") Then
GUICtrlSetState($Import25Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import25Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy26") Then
GUICtrlSetState($Import26Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import26Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy27") Then
GUICtrlSetState($Import27Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import27Button,$GUI_ENABLE)
EndIf
If Not SectionCheckExists("proxy28") Then
GUICtrlSetState($Import28Button,$GUI_DISABLE)
Else
GUICtrlSetState($Import28Button,$GUI_ENABLE)
EndIf
EndFunc
Func RunSC()
	Run($AdresSC,$DirSC)
	If WinExists($TitleSC) Then
		ShowSC()
	Else
		Run($AdresSC,$DirSC)
		WaitForSC()	
		ShowSC()
	EndIf
EndFunc
Func ResizeSC()
		If WinExists($TitleSC) Then
		WinActivate($TitleSC)
		;WinSetState($TitleSC,"",@SW_MAXIMIZE)
		WinMove($TitleSC,"",0,0,$ResizeWidth,$ResizeHeight)
		WinSetState($TitleSC,"",@SW_MINIMIZE)
	Else 
		MsgBox(0,$ErrorTitle,$ErrorExist)
	
	EndIf
EndFunc
Func ShowSC()
	MinimizeSC()
	If WinExists($TitleSC) Then
		WinActivate($TitleSC)
	Else
		MsgBox(0,$ErrorTitle,$ErrorExist)
	EndIf
EndFunc
Func WaitForSC()
	Sleep(10)
	MouseClick("left",@DesktopWidth/2,@DesktopHeight/2,1)
	Sleep(10)
	MouseClick("right",@DesktopWidth/2,@DesktopHeight/2,1)
	WinWait("SocksCap Username/Password Authentication")
	Send("{ENTER}")
EndFunc
Func MinimizeSC()
	WinSetState($TitleSC,"",@SW_MINIMIZE)
EndFunc
Func CloseSC()
	If ProcessExists($ProcessSC) Then
		ProcessClose($ProcessSC)
	Else
		MsgBox(0,$ErrorTitle,$ErrorExist)
	EndIf
	
EndFunc
Func ProxyRead($SectionName)
	Dim $ProxyData[4]
	$ProxyData[0] = IniRead($IniLocation,$SectionName,"ip","")
	$ProxyData[1] = IniRead($IniLocation,$SectionName,"port","")
	$ProxyData[2] = IniRead($IniLocation,$SectionName,"user","")
	$ProxyData[3] = IniRead($IniLocation,$SectionName,"pass","")
	Return $ProxyData
EndFunc
Func ApplyProxy($SectionName)
	If WinExists($TitleSC) Then
		$Proxy = ProxyRead($SectionName)
		ShowSC()
		Sleep(50)
		ApplyIpPort($Proxy[0],$Proxy[1])
		Sleep(50)
		ApplyAuth($Proxy[2],$Proxy[3])
	Else 
		MsgBox(0,$ErrorTitle,$ErrorExist)
	EndIf
EndFunc
Func ApplyIpPort($Ip,$Port)
	Send("{ALT}"&"fs"&$Ip&"{TAB}"&$Port&"{ENTER}")
EndFunc
Func ApplyAuth($Auth_Name,$Auth_Pass)
	Send("{ALT}"&"f")
	Sleep(50)
	;Send("{UP}"&"{UP}")
	Send("u")
	;Send("{ENTER}")
	Sleep(50)
	;MsgBox(0,"",$Auth_Name)
	Send($Auth_Name)
	Sleep(50)
	Send("{TAB}"&$Auth_Pass&"{ENTER}")
EndFunc
Func SectionCheckExists($SectionName)
	$var = IniReadSectionNames($IniLocation)
	$bool = 0
		For $i = 1 To $var[0] Step +1
			If $SectionName = $var[$i] Then
				$bool = 1
				ExitLoop
			EndIf
		Next
	Return $bool
EndFunc
Func ReloadConfig()
CheckSections()
MsgBox(0,"Reload Config", "Config Reloaded Successfully")
EndFunc
Func OpenConfig()
If FileExists($IniLocation) Then
	Run("notepad.exe " & $IniLocation, $IniDir)
EndIf
EndFunc
Func ImportProfile($ProfileName,$IniLocation)
	$SC_profile = IniRead($IniLocation,"data",$ProfileName,"NotFound")
	ShowSC()
	Send("{ALT}"&"fi")
	Sleep(50)
	Send("{TAB 3}"&"{SPACE}"&"{TAB}"&"{ENTER}")
	Send($SC_profile)
	Send("{ENTER 2}")
	WinWaitActive("SocksCap information")
	Send("{ENTER}")
EndFunc
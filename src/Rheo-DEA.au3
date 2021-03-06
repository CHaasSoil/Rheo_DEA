;Created by Christoph Haas Christoph_Haas@gmx.de Sept. 2021
#include <AutoItConstants.au3>
#include <FileConstants.au3>
#Include <Misc.au3>
Local $Datenreihen = InputBox("Datasets","Enter the number of Datasets in the ORX-file:",4)
Local $delay = InputBox("Delay","Enter a value for the delay. 200 for small datasets and fast PCs, 400 or more for large datasets, i.e. >500 entrys. Enter 2000 for slow PCs. Delay:",400)
Local $n = 0
Global $data_nr = 0
Global $pos = 0

Global $square_pos = 0
Global $x = 1
Global $sFldr_LVE = @ScriptDir & "\LVE\"
Global $sFldr_Curve = @ScriptDir & "\Curve\"
Global $sFldr_Cross = @ScriptDir & "\Cross\"
Global $sFldr_Yield = @ScriptDir & "\Yield\"
Global $sFldr_undefined = @ScriptDir & "\undefined\"
Global $sFldr_Integral = @ScriptDir & "\Integral\"
Global $sFldr_data = @ScriptDir & "\data\"
ConsoleWrite("Cursor ueber Name in Tabellenblatt positionieren und Leertaste druecken!!")
Opt("WinTitleMatchMode", 2)
AutoItSetOption("WinTitleMatchMode",2)
$RheoPlus = WinActivate("ORX")
ControlClick($RheoPlus, "","[CLASS:ToolbarWindow32; INSTANCE:2]","left", 1,325,15)


ConsoleWrite("Where is the square?")
While $x=1
	If _IsPressed("20") Then
		$square_pos = MouseGetPos()
		$x=0
	EndIf
WEnd
ConsoleWrite($square_pos[0] &","& $square_pos[1])

Sleep($delay)
$x=1
ConsoleWrite("Where is the name of the sample?")
While $x=1
	If _IsPressed("20") Then
		$pos = MouseGetPos()
		$x=0
	EndIf
WEnd
ConsoleWrite($pos[0] &","& $pos[1])


MouseClick($MOUSE_CLICK_LEFT, $square_pos[0], $square_pos[1], 1)
MouseClick($MOUSE_CLICK_LEFT, $square_pos[0]+30, $square_pos[1], 1)
Sleep($delay)

ConsoleWrite("Start")



If DirGetSize($sFldr_LVE) <> -1 Then
	ConsoleWrite("Directory already exists!")
;	Return False
Else
	DirCreate($sFldr_LVE)
EndIf

If DirGetSize($sFldr_Curve) <> -1 Then
	ConsoleWrite("Directory already exists!")
;	Return False
Else
	DirCreate($sFldr_Curve)
EndIf
If DirGetSize($sFldr_Cross) <> -1 Then
	ConsoleWrite("Directory already exists!")
;	Return False
Else
	DirCreate($sFldr_Cross)
EndIf
If DirGetSize($sFldr_Yield) <> -1 Then
	ConsoleWrite("Directory already exists!")
;	Return False
Else
	DirCreate($sFldr_Yield)
EndIf
If DirGetSize($sFldr_undefined) <> -1 Then
	ConsoleWrite("Directory already exists!")
;	Return False
Else
	DirCreate($sFldr_undefined)
EndIf
If DirGetSize($sFldr_Integral) <> -1 Then
	ConsoleWrite("Directory already exists!")
;	Return False
Else
	DirCreate($sFldr_Integral)
EndIf
If DirGetSize($sFldr_data) <> -1 Then
	ConsoleWrite("Directory already exists!")
;	Return False
Else
	DirCreate($sFldr_data)
EndIf


While $n < $Datenreihen
   MouseClick($MOUSE_CLICK_LEFT, $square_pos[0], $square_pos[1], 1)
   Sleep($delay)
   ControlClick(WinActivate("ORX"), "","[CLASS:PYCCKTBL32; INSTANCE:1]","left", 1)
   MouseClick($MOUSE_CLICK_LEFT, $pos[0], $pos[1], 1)
   Sleep($delay)
   Send("^c")
   Sleep($delay)
   $File_name = StringReplace(StringReplace(ClipGet(),@CRLF ,""),"/" ,"von")
   ConsoleWrite($File_name)
   Sleep($delay)
   $n = $n + 1
   If StringInStr($File_name,"LVE")>1  Then
		ConsoleWrite("LVE")
		Send("^a")
		Sleep($delay)
		Send("^c")
		Sleep($delay)
		Local $out_file_name = StringReplace($sFldr_LVE & $File_name & ".txt", " ","_")
		FileOpen($out_file_name,0)
		FileWrite($out_file_name, ClipGet())
		FileClose($out_file_name)


	ElseIf StringInStr($File_name,"Curve")>1 Then
		ConsoleWrite("Curve")
		Send("^a")
		Sleep($delay)
		Send("^c")
		Sleep($delay)
		Local $out_file_name = StringReplace($sFldr_Curve & $File_name & ".txt", " ","_")
		FileOpen($out_file_name,0)
		FileWrite($out_file_name, ClipGet())
		FileClose($out_file_name)


	ElseIf StringInStr($File_name,"Cross")>1  Then
		ConsoleWrite("Cross")
				Send("^a")
		Sleep($delay)
		Send("^c")
		Sleep($delay)
		Local $out_file_name = StringReplace($sFldr_Cross & $File_name & ".txt", " ","_")
		FileOpen($out_file_name,0)
		FileWrite($out_file_name, ClipGet())
		FileClose($out_file_name)

	ElseIf StringInStr($File_name,"Integral")>1 Then
		ConsoleWrite("Integral")
				Send("^a")
		Sleep($delay)
		Send("^c")
		Sleep($delay)
		Local $out_file_name = StringReplace($sFldr_Integral & $File_name & ".txt", " ","_")
		FileOpen($out_file_name,0)
		FileWrite($out_file_name, ClipGet())
		FileClose($out_file_name)

	ElseIf StringInStr($File_name,"[")>1 Then
		ConsoleWrite("Etwas komisches")
				Send("^a")
		Sleep($delay)
		Send("^c")
		Sleep($delay)
		Local $out_file_name = StringReplace($sFldr_undefined & $File_name & ".txt", " ","_")
		FileOpen($out_file_name,0)
		FileWrite($out_file_name, ClipGet())
		FileClose($out_file_name)

	ElseIf StringInStr($File_name,"Yield")>1 Then
		ConsoleWrite("Yield")
		Send("^a")
		Sleep($delay)
		Send("^c")
		Sleep($delay)
		Local $out_file_name = StringReplace($sFldr_Yield & $File_name & ".txt", " ","_")
		FileOpen($out_file_name,0)
		FileWrite($out_file_name, ClipGet())
		FileClose($out_file_name)

;		Else
;			ConsoleWrite("Etwas komisches passierte")
		;EndIf
	ElseIf ClipGet()=="" Then
		ConsoleWrite("empty clipboard => Exit")
		Break
	Else
		ConsoleWrite("Probe, rein")
		;Sleep(500)
		Send("^a")
		Sleep($delay)
		Send("^c")
		Sleep($delay)
		Local $filename =  $sFldr_data & $data_nr & ".txt"
		ConsoleWrite($filename)
		FileOpen($filename,2)
		FileWrite($filename, ClipGet())
		FileClose($filename)
		$data_nr = $data_nr + 1
   EndIf
   MouseClick($MOUSE_CLICK_LEFT, $square_pos[0]+30, $square_pos[1], 1)
   Send("{DELETE}")
   Sleep($delay)
   Send("{ENTER}")
   Sleep($delay)
WEnd

;Sleep(2000)

#NoEnv
#SingleInstance, Force
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SendMode Play
SetTitleMatchMode 2
SetKeyDelay, 100, 80, Play
SetMouseDelay 500
SetBatchLines -1
#Include %A_ScriptDir%\ToolTip.ahk

if FileExist("food.ini") {
	IniRead, x, food.ini, Values, x
	IniRead, y, food.ini, Values, y
	IniRead, c, food.ini, Values, c
	MsgBox,,, exist!`nx=%x%`ny=%y%`nc=%c%
}
else {
	MsgBox,,, not exist!
	FileAppend, [Values]`nx=`ny=`nc=, food.ini
}

If  not (x <= A_ScreenWidth and y <= A_ScreenHeight) {
	While not GetKeyState("LCtrl")
	{
		MouseGetPos, x, y
		PixelGetColor, c, x, y, RGB
		Tooltip, x=%x%`ny=%y%`nc=%c%
		Sleep, 10
	}
	IniWrite, %x%, food.ini, Values, x
	IniWrite, %y%, food.ini, Values, y
	IniWrite, %c%, food.ini, Values, c
	ToolTip,
}
SetTimer, buff_search, 60000
Loop {
	PixelGetColor, color, x, y, RGB
	if (color = c) {
		val := "Food is here, all right :3"
	}
	else {
		val := "Food not found"
	}
	ToolTip, My color=%c%`nI find color=%color%`n`n%val%`n`nF3 to take color`nF4 to exit app
	Sleep, 10
}


return

F4::ExitApp

F1::
buff_search:
PixelGetColor, color, x, y, RGB
if (color = c) {
	return
	val := "Found is here, all right :3"
}
else {
	val := "Food not found"
	SendPlay, {5}
}
return

F3::
SetTimer,, Off
While not GetKeyState("LCtrl")
{
	MouseGetPos, x, y
	PixelGetColor, c, x, y, RGB
	Tooltip, x=%x%`ny=%y%`nc=%c%
	Sleep, 10
}
IniWrite, %x%, food.ini, Values, x
IniWrite, %y%, food.ini, Values, y
IniWrite, %c%, food.ini, Values, c
ToolTip,
SetTimer,, 60000
return

#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

buttoncontinueonthisversion:
Gui, Destroy
start:
gui, +resize
Gui, Add, ListView, r12 w200 gMyListView, Name
Loop, %A_ScriptDir%\Scripts\*.*
{
    if A_LoopFileName contains .ahk
    {
        OutputDebug, %A_LoopFileName%
        if A_LoopFileName not contains LogClass
            LV_Add("", A_LoopFileName)
    }
}

Gui, add, button,, Check for updates
Gui, show

MyListView:
if (A_GuiEvent = "DoubleClick")
{
    LV_GetText(RowText, A_EventInfo)  ; Get the text from the row's first field.
    MsgBox,4,, Do you want to compile %RowText% into an executable file?
    IfMsgBox, Yes
    {
        If not FileExist("Executables")
            FileCreateDir, Executables
        Sleep, 500
        If not FileExist("Executables\Logs")
            FileCreateDir, Executables\Logs
        Sleep, 500
        If not FileExist("Executables\settings.ini")
            FileAppend, , Executables\settings.ini
        Sleep, 500
        Run, "AutoHotKey\Compiler\Ahk2Exe" /in "Scripts\%RowText%" /out "Executables\%RowText%"
    }
}

return

ButtonCheckforupdates:
Gui, Submit
Gui, Destroy
owner := "koetsmax"
repo := "ashen-macros"
res := WebRequest("https://api.github.com/repos/" . owner . "/" . repo . "/releases/latest",,,, error := "")
if error
    MsgBox,, Error, % error . "`n`nresponse:`n" . res
else
    pos := RegExMatch(res, """tag_name"":\s*""\K[^""]*", github)
FileRead, Local, version
if (Local == "")
    Local = 0
Version1 := github
Version2 := Local
Latest := VersionCompare(Version1, Version2)
if (latest == 0)
    MsgBox, You are currently on the latest release
else if (Latest == 1)
{
    Gui, Add, Text,, There is an update available! `n`nYour version:    %Local%. `nLatest version: %github%
    Gui, Add, Button,x10 y+5n, Download the new version
    Gui, Add, Button,x+10p, Continue on this version
    Gui, Show
}
else if (Latest == 2)
{
    MsgBox, You are currently ahead of the github release
    Goto, start
}
return

VersionCompare(version1, version2)
{
	StringSplit, verA, version1, .
	StringSplit, verB, version2, .
	Loop, % (verA0> verB0 ? verA0 : verB0)
	{
		if (verA0 < A_Index)
			verA%A_Index% := "0"
		if (verB0 < A_Index)
			verB%A_Index% := "0"
		if (verA%A_Index% > verB%A_Index%)
			return 1
		if (verB%A_Index% > verA%A_Index%)
			return 2
	}
	return 0
}
return

WebRequest(url, method := "GET", HeadersArray := "", body := "", ByRef error := "") 
{
    Whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    Whr.Open(method, url, true)
    for name, value in HeadersArray
        Whr.SetRequestHeader(name, value)
    Whr.Send(body)
    Whr.WaitForResponse()
    status := Whr.status
    if (status == 403)
        MsgBox, Your ip is being rate limited. Please try again later.
    if (status != 200)
        error := "HttpRequest error, status: " . status
    
    Arr := Whr.responseBody
    pData := NumGet(ComObjValue(arr) + 8 + A_PtrSize)
    length := Arr.MaxIndex() + 1
    Return StrGet(pData, length, "UTF-8")
}
return

buttondownloadthenewversion:
Gui, Destroy
run, https://github.com/koetsmax/Ashen-macros/releases//latest

Return
#x::
GuiEscape:
GuiClose:
ExitApp
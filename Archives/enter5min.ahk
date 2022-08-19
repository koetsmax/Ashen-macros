#SingleInstance, Force

SetWorkingDir, %A_ScriptDir%

Goto, start
start:
Sleep, 250
WinActivate, ahk_exe SoTGame.exe
Mousemove, 600, 404
Mousemove, 610, 410, 100
SLeep, 1200
Send, {Enter}
Sleep, 300000
WinActivate, ahk_exe SoTGame.exe
Send, {Enter}
Goto, start

Return
#x:: ExitApp
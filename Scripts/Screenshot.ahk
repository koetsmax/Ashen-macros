#SingleInstance, Force
; SendMode Input
SetWorkingDir, %A_ScriptDir%

#x::

Sleep, 500

MouseMove, 2585, 0,
MouseMove, 1885, 1195
Send, #+s
Sleep, 800
MouseClickDrag, L, 2585, 1845, 3615, 1888, 25
Return

; 2585, 1845
; 3615, 1888
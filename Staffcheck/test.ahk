#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; Read:
IniRead, Key1, staffcheck.ini , settings, goodtocheckmsg

OutputDebug, %Key1%
; Write:
IniWrite, %key1%, %A_ScriptFullPath%, settings, key1


[settings]
key1=test

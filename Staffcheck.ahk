#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
SetTitleMatchMode, slow

; Variables

commandschannel = {#}command-testing
invitetracker = {#}invite-tracker
info = info data
lhist = loghistory full
noteslist = notes list
notesnew = notes new

; User input of GamerTag

InputBox, userID, UserID, Please enter the ID of the user to staffcheck, , , 125
InputBox, XboxGT, Xbox Gamertag, Please enter the Xbox Gamertag of the user to Staffcheck, , , 125
Sleep, 1500

; Activate Discord.exe and move to on-duty-commands

WinActivate, ahk_exe Discord.exe
Send, {Escape}
Sleep, 120
Send, ^k
Sleep, 100
Send, %commandschannel%
Sleep, 120
Send, {enter}
Sleep, 1300

; Delete all text in msg box

Send, a
Sleep, 150
Send, ^a{Backspace}

; check info data

Sleep, 800
Send, /%info%
Sleep, 1200
Send, {enter}user{enter}
Sleep, 500
Send, %userID%
Sleep, 300
Send, {enter}{enter}

; check log hist

Sleep, 150
Send, /%lhist%
Sleep, 1200
Send, {enter}
Sleep, 500
Send, %userID%
Sleep, 300
Send, {enter}{enter}

; check notes

Sleep, 150
Send, /%noteslist%
Sleep, 1200
Send, {enter}
Sleep, 500
Send, %userID%
Sleep, 300
Send, {enter}{enter}

; add GT to notes if needed

Sleep, 2500
PixelGetColor, RGBcolour, 963, 1791, RGB
OutputDebug, %RGBcolour%
if (RGBcolour == 0x49443C) {
    OutputDebug, Adding GT to notes
    Sleep, 150
    Send, /%notesnew%
    Sleep, 1200
    Send, {enter}
    Sleep, 500
    Send, %userID%
    Sleep, 500
    Send, {enter}
    Sleep, 500
    Send, GT: %XboxGT%
    Sleep, 300
    Send, {enter}{enter}
} else {
    OutputDebug, not adding GT to notes
}
MsgBox, 0, Elemental commands, Press OK once you have looked through the basic commands

; Ashen commands

Send, {!}search %userID%{enter}
Sleep, 50
Send, {!}xsearch %XboxGT%{enter}
MsgBox, 0, Elemental commands, Press OK once you have looked through the basic commands

; Invite Tracker

Send, ^k
Sleep, 100
Send, %commandschannel%
Sleep, 120
Send, {enter}
Sleep, 1300
Send, ^f
Sleep, 150
Send, ^a{Backspace}
Send, {Escape}
Sleep, 150
Send, ^f
Sleep, 120
Send, %userID%
MsgBox, 0, Invite Tracker, Press OK once you have looked through the invite tracker



exit
; 863914391065853983
;/info data user:863914391065853983



;msgbox to add GT to notes anyway
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
SetTitleMatchMode, slow


; Variables

commandschannel = {#}command-testing
invitetracker = {#}invite-tracker
sotofficial = {#}official-swag
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
Send, {Escape}
Sleep, 120
Send, ^k
Sleep, 120
Send, %commandschannel%
Sleep, 300
Send, {enter}
Sleep, 10000

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
    MsgBox, 4, Add note with GT?, Press YES to place a note with the gamertag if the autoplacement failed.
    IfMsgBox, Yes
    {
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
    }
}
MsgBox, 0, Elemental commands, Press OK once you have looked through the Elemental commands

; Ashen commands

WinActivate, ahk_exe Discord.exe
Sleep, 250
Send, {!}search %userID%{enter}
Sleep, 250
Send, {!}xsearch %XboxGT%{enter}
Sleep, 250
MsgBox, 0, Ashen commands, Press OK once you have looked through the Ashen commands

; Invite Tracker

WinActivate, ahk_exe Discord.exe
Send, ^k
Sleep, 100
Send, %invitetracker%
Sleep, 300
Send, {enter}
Sleep, 10000
Send, ^f
Sleep, 150
Send, ^a{Backspace}
Send, {Escape}
Sleep, 150
Send, ^f
Sleep, 120
Send, %userID%
Sleep, 80
Send, {enter}
MsgBox, 0, Invite Tracker, Press OK once you have looked through the invite tracker

; Check sot official posts

WinActivate, ahk_exe Discord.exe
Send, ^a{Backspace}
Send, {Escape}
Sleep, 150
Send, ^k
Sleep, 100
Send, %sotofficial%
Sleep, 300
Send, {enter}
Sleep, 10000
Send, ^f
Sleep, 150
Send, ^a{Backspace}
Sleep, 120
Send, from: %userID% 
Sleep, 150
Send, {enter}
MsgBox, 4, Sot Official, Press YES if there are a lot of messages and the search results need to be narrowed down. press NO if there are no Anti-alliance messages.
IfMsgBox, Yes
{
    WinActivate, ahk_exe Discord.exe
    Send, ^f
    Sleep, 300
    Send, {Space}alliance
    Sleep, 100
    Send, {enter}
    MsgBox, 0, Sot Official, Press OK Once you have looked through their messages in Sot Official
}

; Staffcheck complete
MsgBox, 0, Staffcheck complete, Press OK to exit the script
exit
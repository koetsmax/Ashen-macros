#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%


MsgBox, 4, In case of booboo, Press Windows x in case of big explosion

; Variables

ondutychat = {#}on-duty-chat
commandschannel = {#}on-duty-commands
invitetracker = {#}invite-tracker
sotofficial = {#}official-swag
info = info data
lhist = loghistory full
noteslist = notes list
notesnew = notes new
pagenumber = 1
OutputDebug, Variables Initialized

; Check if .ini file exists

If !FileExist("settings.ini")
{
    MsgBox, settings.ini file not found. Creating file...
    FileAppend, , settings.ini
    IniWrite, % "", settings.ini, staffcheck, gtcbeforeid
    IniWrite, Good to check -- GT:, settings.ini, staffcheck, gtcafterid
    IniWrite, % "", settings.ini, staffcheck, gtcaftergt
    IniWrite, % "", settings.ini, staffcheck, notgtcbeforeid
    IniWrite, **Not** Good to check -- GT:, settings.ini, staffcheck, notgtcafterid
    IniWrite, --, settings.ini, staffcheck, notgtcaftergt
    IniWrite, % "", settings.ini, staffcheck, notgtcafterreason
}

; User input of userID & GamerTag

InputBox, userID, UserID, Please enter the ID of the user to staffcheck, , , 125
InputBox, xboxGT, Xbox Gamertag, Please enter the Xbox Gamertag of the user to Staffcheck, , , 125
OutputDebug, input received
MsgBox, 0, , DO NOT TOUCH YOUR MOUSE OR KEYBOARD WHEN THIS SCRIPT IS RUNNING. ONLY TOUCH YOUR MOUSE AND OR KEYBOARD WHEN ONE OF THESE BOXES HAVE POPPED UP. The script will now start
MsgBox, 0, , There is a 2 second delay in between switching channels. So be wary of that
Sleep, 1500

; Activate Discord.exe and move to on-duty-commands

WinActivate, ahk_exe Discord.exe
OutputDebug, entered discord
Send, {Escape}
Sleep, 120
Send, {Escape}
Sleep, 120
Send, ^k
Sleep, 120
Send, %commandschannel%
Sleep, 350
Send, {enter}
OutputDebug, Opened on-duty-commands
Sleep, 2000

; Delete all text in msg box

Send, a
Sleep, 150
Send, ^a{Backspace}

; check info data

Sleep, 800
Send, /%info%
Sleep, 1600
Send, {enter}user{enter}
Sleep, 500
Send, %userID%
Sleep, 300
Send, {enter}{enter}
OutputDebug, executed info data user

; check log hist

Sleep, 150
Send, /%lhist%
Sleep, 1600
Send, {enter}
Sleep, 500
Send, %userID%
Sleep, 300
Send, {enter}{enter}
OutputDebug, executed log history

; check notes

Sleep, 150
Send, /%noteslist%
Sleep, 1600
Send, {enter}
Sleep, 500
Send, %userID%
Sleep, 300
Send, {enter}{enter}
OutputDebug, executed notes list

; Multiple pages of notes?

Loop,
{
    MsgBox, 4, Another page of notes?, Press YES if there is another page of notes.
    IfMsgBox, Yes
    {
        WinActivate, ahk_exe Discord.exe
        pagenumber++
        Sleep, 150
        Send, /%noteslist%
        Sleep, 1600
        Send, {enter}
        Sleep, 500
        Send, %userID%
        Sleep, 300
        Send, {Tab}{Tab}{Tab}
        Sleep, 300
        Send, %pagenumber%
        Sleep, 300
        Send, {enter}
    }
    IfMsgBox, No
    {
        Break
    }
}

; add GT to notes if needed


Sleep, 2500
PixelGetColor, RGBcolour, 963, 1791, RGB
OutputDebug, %RGBcolour%
if (RGBcolour == 0x49443C) {
    OutputDebug, Adding GT to notes
    Sleep, 150
    Send, /%notesnew%
    Sleep, 1600
    Send, {enter}
    Sleep, 500
    Send, %userID%
    Sleep, 500
    Send, {enter}
    Sleep, 500
    Send, GT: %xboxGT%
    Sleep, 300
    Send, {enter}{enter}
} else if (RGBcolour == 0x32353B){
    OutputDebug, not adding GT to notes
    MsgBox, 4, Add note with GT?, Press YES to place a note with the gamertag if the autoplacement failed.
    IfMsgBox, Yes
    {
        WinActivate, ahk_exe Discord.exe
        OutputDebug, Adding GT to notes
        Sleep, 150
        Send, /%notesnew%
        Sleep, 1600
        Send, {enter}
        Sleep, 500
        Send, %userID%
        Sleep, 500
        Send, {enter}
        Sleep, 500
        Send, GT: %xboxGT%
        Sleep, 300
        Send, {enter}{enter}
    }
} else if (RGBcolour == 0x36393F){
    OutputDebug, not adding GT to notes
    MsgBox, 4, Add note with GT?, Press YES to place a note with the gamertag if the autoplacement failed.
    IfMsgBox, Yes
    {
        WinActivate, ahk_exe Discord.exe
        OutputDebug, Adding GT to notes
        Sleep, 150
        Send, /%notesnew%
        Sleep, 1600
        Send, {enter}
        Sleep, 500
        Send, %userID%
        Sleep, 500
        Send, {enter}
        Sleep, 500
        Send, GT: %xboxGT%
        Sleep, 300
        Send, {enter}{enter}
    }
} else {
    MsgBox, 4, Pixelcheck failed, Press Yes to add GT to notes anyway if necessary
    IfMsgBox, Yes
    {
        WinActivate, ahk_exe Discord.exe
        OutputDebug, Pixelcheck failed, add GT to notes anyway
        Sleep, 150
        Send, /%notesnew%
        Sleep, 1200
        Send, {enter}
        Sleep, 500
        Send, %userID%
        Sleep, 500
        Send, {enter}
        Sleep, 500
        Send, GT: %xboxGT%
        Sleep, 300
        Send, {enter}{enter}
    }
}

MsgBox, 0, Elemental commands, Press OK once you have looked through the Elemental commands

; Ashen commands

WinActivate, ahk_exe Discord.exe
OutputDebug, entered discord
Sleep, 250
Send, {!}search %userID%{enter}
Sleep, 250
Send, {!}xsearch %xboxGT%{enter}
Sleep, 250
OutputDebug, !search and !xsearch done
MsgBox, 0, Ashen commands, Press OK once you have looked through the Ashen commands

; Invite Tracker

WinActivate, ahk_exe Discord.exe
OutputDebug, entered discord
Send, ^k
Sleep, 100
Send, %invitetracker%
Sleep, 350
Send, {enter}
OutputDebug, Opened invite tracker
Sleep, 2000
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
OutputDebug, Searched invite tracker
MsgBox, 0, Invite Tracker, Press OK once you have looked through the invite tracker


; Check sot official posts

WinActivate, ahk_exe Discord.exe
OutputDebug, entered discord
Send, ^a{Backspace}
Send, {Escape}
Sleep, 150
Send, ^k
Sleep, 100
Send, %sotofficial%
Sleep, 350
Send, {enter}
OutputDebug, Opened sot official
Sleep, 2000
Send, ^f
Sleep, 150
Send, ^a{Backspace}
Sleep, 120
Send, from: %userID% 
Sleep, 150
Send, {enter}
OutputDebug, Opened SOT official messages
MsgBox, 4, Sot Official, Press YES if there are a lot of messages and the search results need to be narrowed down. press NO if there are no Anti-alliance messages.
IfMsgBox, Yes
{
    WinActivate, ahk_exe Discord.exe
    OutputDebug, entered discord
    Send, ^f
    Sleep, 300
    Send, {Space}alliance
    Sleep, 100
    Send, {enter}
    OutputDebug, narrowed search in sot official
    MsgBox, 0, Sot Official, Press OK Once you have looked through their messages in Sot Official
}


; Staffcheck complete
WinActivate, ahk_exe Discord.exe
Sleep, 250
Send, ^a{Backspace}
Sleep, 100
Send, {Escape}
Sleep, 100
MsgBox, 4, Good to check?, Is this person good to check
IfMsgBox, Yes
{
    IniRead, gtcbeforeid, settings.ini , staffcheck, gtcbeforeid
    IniRead, gtcafterid, settings.ini , staffcheck, gtcafterid
    IniRead, gtcaftergt, settings.ini , staffcheck, gtcaftergt
    OutputDebug, Read good to check message
    Sleep, 150
    Send, ^k
    Sleep, 100
    Send, %ondutychat%
    Sleep, 350
    Send, {enter}
    OutputDebug, Opened ondutychat
    Sleep, 2000
    Send, a
    Sleep, 150
    Send, ^a{Backspace}
    Sleep, 100
    Send, %gtcbeforeid% <@%userID%> %gtcafterid% %xboxGT% %gtcaftergt%
    Sleep, 3500
    Send, {enter}
    OutputDebug, Good to check message sent
}
IfMsgBox, No
{
    IniRead, notnotgtcbeforeid, settings.ini , staffcheck, notgtcbeforeid
    IniRead, notgtcafterid, settings.ini , staffcheck, notgtcafterid
    IniRead, notgtcaftergt, settings.ini , staffcheck, notgtcaftergt
    IniRead, notgtcafterreason, settings.ini , staffcheck, notgtcafterreason

    InputBox, Reason, Reason, Please enter the Reason that the user is not good to check, , , 125
    Send, ^k
    Sleep, 100
    Send, %ondutychat%
    Sleep, 350
    Send, {enter}
    OutputDebug, Opened ondutychat
    Sleep, 2000
    Send, a
    Sleep, 150
    Send, ^a{Backspace}
    Sleep, 100
    Send, %notgtcbeforeid% <@%userID%> %notgtcafterid% %xboxGT% %notgtcaftergt% %Reason% %notgtcafterreason%
    Sleep, 3500
    Send, {enter}
    OutputDebug, Not good to check message sent
}

OutputDebug, Script finished
ExitApp
Return
#x::ExitApp
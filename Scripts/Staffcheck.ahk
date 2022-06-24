#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

warning =
(
Ranged and Melee Weapon Hit Detection
In areas of intense action, players may find themselves firing shots or landing strikes that do not cause damage to their targets.
While small improvements continue to be delivered during our regular updates, we are continuing to investigate and identify further improvements to the player combat experience.

AKA. Press Windows+X to force quit the program
)

MsgBox, %warning%
start:

; Variables

tutorial = 
(
The input tab is to enter the ID and gamertag of the user you want to check.
In the options tab you can select what you want to check. (default is all)

After you have set everything up press Continue and the script will run.
)
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

; Gui with input and options

Gui, Add, Tab3,, Input|How to use

Gui, Add, Text,, Discord ID:
Gui, Add, Text,, xbox Gamertag:
Gui, Add, Edit, vuserID ym x100 y31
Gui, Add, Edit, vxboxGT
Gui, Add, Radio, vall Checked x225 y34, Entire staffcheck
Gui, Add, Radio, velemental, Elemental commands
Gui, Add, Radio, vashen, Ashen commands
Gui, Add, Radio, vinvites, Check Invite tracker
Gui, Add, Radio, vsot, Check Sot official
Gui, Add, Radio, vgoodtocheck, Good to check

Gui, Tab, 2
Gui, Add, Text,, %tutorial%
Gui, Tab
Gui, Add, Button, x10, Continue
Gui, show, w400 h185
OutputDebug, Opened GUI

Return
ButtonContinue:
Gui, Submit

if userID is not integer
{
    OutputDebug, %userID%
    Gui, Destroy
    MsgBox, Error, Userid: %userID% is invalid. UserID MUST only consist of numbers
    Goto start
}

MsgBox, 0, , DO NOT TOUCH YOUR MOUSE OR KEYBOARD WHEN THIS SCRIPT IS RUNNING. ONLY TOUCH YOUR MOUSE AND OR KEYBOARD WHEN ONE OF THESE BOXES HAVE POPPED UP. The script will now start
Sleep, 1500

WinActivate, ahk_exe Discord.exe
OutputDebug, entered discord
Send, {Escape}
Sleep, 120
Send, {Escape}

; Go to sub-routine
Gui, Destroy
if (all == 1)
    Goto all
else if (elemental == 1)
    Goto elemental
else if (ashen == 1)
    Goto ashen
else if (invites == 1)
    Goto invites
else if (sot == 1)
    Goto sotofficial
else if (goodtocheck == 1)
    Goto goodtocheck
else
{
    MsgBox, An error has ocured, please try again
    Goto start
}
Return
all:

elemental:

; Move to on duty commands

Sleep, 120
Send, ^k
Sleep, 120
Send, %commandschannel%
Sleep, 350
Send, {enter}
OutputDebug, Opened on-duty-commands
Sleep, 2000

; delete all text in message box

Send, a
Sleep, 150
Send, ^a{Backspace}

; check info data

Sleep, 800
Send, /%info%
Sleep, 1600
Send, {enter}user{enter}
Sleep, 600
Send, %userID%
Sleep, 300
Send, {enter}{enter}
OutputDebug, executed info data user

; check log hist

Sleep, 150
Send, /%lhist%
Sleep, 1600
Send, {enter}
Sleep, 600
Send, %userID%
Sleep, 300
Send, {enter}{enter}
OutputDebug, executed log history

; check notes

Sleep, 150
Send, /%noteslist%
Sleep, 1600
Send, {enter}
Sleep, 600
Send, %userID%
Sleep, 300
Send, {enter}{enter}
OutputDebug, executed notes list
Sleep, 2500

; get RGB value of specific Pixel

PixelGetColor, RGBcolour, 963, 1791, RGB

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

; Check if radio = all

if (all != 1){
    Goto, start
}

ashen:

; Go to on-duty-commands
if (all != 1){
    Sleep, 120
    Send, ^k
    Sleep, 120
    Send, %commandschannel%
    Sleep, 350
    Send, {enter}
    OutputDebug, Opened on-duty-commands
    Sleep, 2000
}
; Delete all text in msg box

Send, a
Sleep, 150
Send, ^a{Backspace}

; Check ashen commands

WinActivate, ahk_exe Discord.exe
OutputDebug, entered discord
Sleep, 250
Send, {!}search %userID%{enter}
Sleep, 250
Send, {!}xsearch %xboxGT%{enter}
Sleep, 250
OutputDebug, !search and !xsearch done
MsgBox, 0, Ashen commands, Press OK once you have looked through the Ashen commands

; Check if radio = all

if (all != 1){
    Goto, start
}

invites:

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

; Check if radio = all

if (all != 1){
    Goto, start
}

sotofficial:

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

; Check if radio = all

if (all != 1){
    Goto, start
}

goodtocheck:

; Staffcheck complete

WinActivate, ahk_exe Discord.exe
Sleep, 250
Send, ^a{Backspace}
Sleep, 100
Send, {Escape}
Sleep, 100
MsgBox, 3, Good to check?, Is this person good to check? Press cancel to cancel if you have to look into this person more.
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
    Send,{Raw} %notgtcbeforeid% <@%userID%> %notgtcafterid% %xboxGT% %notgtcaftergt% %Reason% %notgtcafterreason%
    Sleep, 3500
    Send, {enter}
    OutputDebug, Not good to check message sent
}


Goto, start
GuiClose:
GuiEscape:
ExitApp
Return
#x::ExitApp
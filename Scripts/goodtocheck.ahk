#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

MsgBox, 0, In case of unexpected behaviour, Press Windows+X if the program shows unexpected behaviour like opening up different programs

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
Sleep, 1500

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
    Send,{Raw} %gtcbeforeid% 
    Sleep, 100
    Send,{Raw} <@%userID%> 
    Sleep, 100
    Send,{Raw} %gtcafterid% 
    Sleep, 100
    Send,{Raw} %xboxGT% 
    Sleep, 100
    Send,{Raw} %gtcaftergt%
    Sleep, 100
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
    Send,{Raw} %notgtcbeforeid% 
    Sleep, 100
    Send,{Raw} <@%userID%> 
    Sleep, 100
    Send,{Raw} %notgtcafterid% 
    Sleep, 100
    Send,{Raw} %xboxGT% 
    Sleep, 100
    Send,{Raw} %notgtcaftergt% 
    Sleep, 100
    Send,{Raw} %Reason% 
    Sleep, 100
    Send,{Raw} %notgtcafterreason%
    Sleep, 3500
    Send, {enter}
    OutputDebug, Not good to check message sent
}

OutputDebug, Script finished
ExitApp
Return
#x::ExitApp
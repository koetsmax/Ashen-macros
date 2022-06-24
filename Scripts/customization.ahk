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

; Variables

userID = 272001404086910977
xboxGT = M A X10815
ondutychat = {#}on-duty-chat

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

;GOOD TO CHECK RESET

MsgBox, 4, Reset to Default?, RESET THE CURRENT GOOD TO CHECK MESSAGE TO DEFAULT? THIS CANNOT BE UNDONE. Click Yes to reset and Click no to cancel
IfMsgBox, Yes
{
    IniWrite, % "", settings.ini, staffcheck, gtcbeforeid
    IniWrite, Good to check -- GT:, settings.ini, staffcheck, gtcafterid
    IniWrite, % "", settings.ini, staffcheck, gtcaftergt
}

IniRead, gtcbeforeid, settings.ini , staffcheck, gtcbeforeid
IniRead, gtcafterid, settings.ini , staffcheck, gtcafterid
IniRead, gtcaftergt, settings.ini , staffcheck, gtcaftergt
OutputDebug, Read current goodtocheckmsg


;GOOD TO CHECK

MsgBox, 4, Change good to check message?, The current good to check message is: %gtcbeforeid% <@userid> %gtcafterid% <xboxGT> %gtcaftergt%. Click Yes to change the message and Click no to cancel
IfMsgBox, Yes
{
    InputBox, newgtcbeforeid, New Good to check message BEFORE THE USERID, edit part of good to check message BEFORE THE USERID. Currently it is: %gtcbeforeid% `(If nothing is shown before this it means there is no text`), , , 200

    InputBox, newgtcafterid, New Good to check message AFTER THE USERID, edit part of good to check message AFTER THE USERID. Currently it is: %gtcafterid% `(If nothing is shown before this it means there is no text`), , , 200

    InputBox, newgtcaftergt, New Good to check message AFTER THE GAMERTAG, edit part of good to check message AFTER THE GAMERTAG. Currently it is: %gtcaftergt% `(If nothing is shown before this it means there is no text`), , , 200

    MsgBox, 0, Making changes, Making changes to config file, click OK
    IniWrite, %newgtcbeforeid%, settings.ini, staffcheck, gtcbeforeid
    IniWrite, %newgtcafterid%, settings.ini, staffcheck, gtcafterid
    IniWrite, %newgtcaftergt%, settings.ini, staffcheck, gtcaftergt

    MsgBox, 0, Done making changes to good to check file, Done writing changes, click OK
    MsgBox, 4, Discord?, Do you want to see what this would look like in discord?
    IfMsgBox, Yes
    {
        WinActivate, ahk_exe Discord.exe
        Sleep, 250
        Send, ^k
        Sleep, 100
        Send, %ondutychat%
        Sleep, 300
        Send, {enter}
        OutputDebug, Opened ondutychat
        Sleep, 2000
        Send, a
        Sleep, 150
        Send, ^a{Backspace}
        Sleep, 100
        Send, %newgtcbeforeid% <@%userID%> %newgtcafterid% %xboxGT% %newgtcaftergt%
        Sleep, 750
    }
}

; NOT GOOD TO CHECK RESET

MsgBox, 4, Reset to Default?, RESET THE CURRENT NOT GOOD TO CHECK MESSAGE TO DEFAULT? THIS CANNOT BE UNDONE. Click Yes to reset and Click no to cancel
IfMsgBox, Yes
{
    IniWrite, % "", settings.ini, staffcheck, notgtcbeforeid
    IniWrite, **Not** Good to check -- GT:, settings.ini, staffcheck, notgtcafterid
    IniWrite, --, settings.ini, staffcheck, notgtcaftergt
    IniWrite, % "", settings.ini, staffcheck, notgtcafterreason
}

; NOT GOOD TO CHECK

IniRead, notnotgtcbeforeid, settings.ini , staffcheck, notgtcbeforeid
IniRead, notgtcafterid, settings.ini , staffcheck, notgtcafterid
IniRead, notgtcaftergt, settings.ini , staffcheck, notgtcaftergt
IniRead, notgtcafterreason, settings.ini , staffcheck, notgtcafterreason
MsgBox, 4, Change NOT good to check message?, The current NOT good to check message is: %notgtcbeforeid% <@userid> %notgtcafterid% <xboxGT> %notgtcaftergt%. Click Yes to change the message and Click no to cancel
IfMsgBox, Yes
{
    InputBox, newnotgtcbeforeid, New not Good to check message BEFORE THE USERID, edit part of not good to check message BEFORE THE USERID. Currently it is: %notgtcbeforeid% `(If nothing is shown before this it means there is no text`), , , 200

    InputBox, newnotgtcafterid, New not Good to check message AFTER THE USERID, edit part of not good to check message AFTER THE USERID. Currently it is: %notgtcafterid% `(If nothing is shown before this it means there is no text`), , , 200

    InputBox, newnotgtcaftergt, New not Good to check message AFTER THE GAMERTAG, edit part of not good to check message AFTER THE GAMERTAG. Currently it is: %notgtcaftergt% `(If nothing is shown before this it means there is no text`), , , 200

    InputBox, newnotgtcafterreason, New not Good to check message AFTER THE REASON, edit part of not good to check message AFTER THE REASON. Currently it is: %notgtcafterreason% `(If nothing is shown before this it means there is no text`), , , 200

    MsgBox, 0, Making changes, Making changes to config file, click OK
    IniWrite, %newnotgtcbeforeid%, settings.ini, staffcheck, notgtcbeforeid
    IniWrite, %newnotgtcafterid%, settings.ini, staffcheck, notgtcafterid
    IniWrite, %newnotgtcaftergt%, settings.ini, staffcheck, notgtcaftergt
    IniWrite, %newnotgtcafterreason%, settings.ini, staffcheck, notgtcafterreason

    MsgBox, 0, Done making changes to not good to check file, Done writing changes, click OK
    MsgBox, 4, Discord?, Do you want to see what this would look like in discord?
    IfMsgBox, Yes
    {
        WinActivate, ahk_exe Discord.exe
        Sleep, 250
        Send, ^k
        Sleep, 100
        Send, %ondutychat%
        Sleep, 300
        Send, {enter}
        OutputDebug, Opened ondutychat
        Sleep, 2000
        Send, a
        Sleep, 150
        Send, ^a{Backspace}
        Sleep, 100
        Send, %newnotgtcbeforeid% <@%userID%> %newnotgtcafterid% %xboxGT% %newnotgtcaftergt% <Reason> %newnotgtcafterreason%
        Sleep, 750
    }
}


ExitApp
Return
#x::ExitApp
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

MsgBox, 4, In case of booboo, Press Windows x in case of big explosion

;variables 

commandschannel = {#}on-duty-commands
addwarn = warn
OutputDebug, Variables Initialized

; User input for userID & note to add

InputBox, userID, ID of user to add warnings to, Please enter the ID of the user to add a rule 5 warning to, , , 125

OutputDebug, input received
Sleep, 1500

WinActivate, ahk_exe Discord.exe
OutputDebug, entered discord
Send, {Escape}
Sleep, 120
Send, {Escape}
Sleep, 120
Send, ^k
Sleep, 120
Send, %commandschannel%
Sleep, 300
Send, {enter}
OutputDebug, Opened on-duty-commands
Sleep, 2000
Send, a
Sleep, 150
Send, ^a{Backspace}

if userID is Integer
{
    Sleep, 150
    Send, /%addwarn%
    Sleep, 1200
    Send, {enter}
    Sleep, 500
    Send, %userID%
    Sleep, 300
    Send, {Right}{Down}{Tab}
    Sleep, 300
    Send{Raw}Rule #5: You must give a warning before leaving a ship by using !leave 10 minutes before you plan to leave the ship. Leaving significantly before or after the 10 minutes is not acceptable.
    Sleep, 1200
    Send, {enter}
    OutputDebug, Added warning
} Else {
    MsgBox, userID %userID% contains Illegal characters
}

ExitApp
Return
#x::ExitApp
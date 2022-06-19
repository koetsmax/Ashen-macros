#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%


MsgBox, 4, In case of booboo, Press Windows x in case of big explosion

;variables 

commandschannel = {#}on-duty-commands
addwarn = warn
OutputDebug, Variables Initialized

; User input for userID & note to add

InputBox, userIDs, IDs of users to add warnings to, Please enter the IDs of the users to add warnings to seperated by a comma ex. 272001404086910977`,863914391065853983, , , 160
InputBox, Reason, Reason to warn, Please enter the reason that should be added to the warning, , , 125

OutputDebug, input received
Sleep, 1500

WinActivate, ahk_exe Discord.exe
OutputDebug, entered discord
OutputDebug, %A_LoopField%
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

Loop, parse, userIDs, `,
{
    WinActivate, ahk_exe Discord.exe
    OutputDebug, %A_LoopField%
    if A_LoopField is Integer
    {
        Sleep, 150
        Send, /%addwarn%
        Sleep, 1200
        Send, {enter}
        Sleep, 500
        Send, %A_LoopField%
        Sleep, 300
        Send, {Right}{Down}{Tab}
        Sleep, 300
        Send {Raw}%Reason%
        Sleep, 1200
        Send, {enter}
        OutputDebug, Added warning
    } Else {
        MsgBox, userID %A_LoopField% contains Illegal characters
    }
}
MsgBox, No Next ID found. Script is finished
OutputDebug, Script finished
ExitApp
Return
#x::ExitApp
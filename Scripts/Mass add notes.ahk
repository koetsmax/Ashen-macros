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
;variables 

commandschannel = {#}on-duty-commands
noteslist = notes list
notesnew = notes new
OutputDebug, Variables Initialized

; User input for userID & note to add

InputBox, userIDs, IDs of users to add notes to, Please enter the IDs of the users to add notes to seperated by a comma ex. 272001404086910977`,863914391065853983, , , 150
InputBox, Note, Note to add, Please enter the note that should be added to the userIDs, , , 125

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
        Send, /%noteslist%
        Sleep, 1200
        Send, {enter}
        Sleep, 500
        Send, %A_LoopField%
        Sleep, 300
        Send, {enter}{enter}
        OutputDebug, executed notes list
        MsgBox, 4, Does this note still need to be added?, Press YES to place the note, and NO to cancel
        IfMsgBox, Yes
        {
            OutputDebug, Adding note
            Sleep, 150
            Send, /%notesnew%
            Sleep, 1200
            Send, {enter}
            Sleep, 500
            Send, %A_LoopField%
            Sleep, 500
            Send, {enter}
            Sleep, 500
            Send {Raw}%Note%
            Sleep, 300
            Send, {enter}{enter}
        }
        IfMsgBox, No
        {
            OutputDebug, Not adding notes
            MsgBox, 0, Skipping to next ID, Skipping to next ID
        }
    } Else {
        MsgBox, userID %A_LoopField% contains Illegal characters
    }
}
MsgBox, No Next ID found. Script is finished
OutputDebug, Script finished
ExitApp
Return
#x::ExitApp
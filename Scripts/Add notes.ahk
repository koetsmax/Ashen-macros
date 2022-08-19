#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

warning =
(
Ranged and Melee Weapon Hit Detection
In areas of intense action, players may find themselves firing shots or landing strikes that do not cause damage to their targets.
While small improvements continue to be delivered during our regular updates, we are continuing to investigate and identify further improvements to the player combat experience.

TLDR: Press Windows+X to force quit the program
)

MsgBox, %warning%
start:

; Variables

tutorial = 
(
The input tab is to enter the ID and gamertag of the user you want to check.
You can use multiple IDs by seperating them with a comma
You can also select an option to check the notes list before adding the note.

After you have set everything up press Continue and the script will run.
)
noteslist = notes list

Gui, Add, Tab3,, Input|How to use

Gui, Add, Text,, Discord ID(s):
Gui, Add, Text,, Note to add:
Gui, Add, Text,, Channel:
Gui, Add, Checkbox, vchecklist Checked y+15p, Check notes list before adding note
Gui, Add, Edit, vuserIDs ym x100 y31
Gui, Add, Edit, vnote
Gui, Add, ComboBox, vchannel, staff-commands|on-duty-commands||captain-commands|admin-commands

Gui, Tab, 2
Gui, Add, Text,, %tutorial%
Gui, Tab
Gui, Add, Button, x10, Continue
Gui, show

Return
ButtonContinue:
Gui, Submit

commandschannel = {#}%channel%

MsgBox, DO NOT TOUCH YOUR MOUSE OR KEYBOARD WHEN THIS SCRIPT IS RUNNING. ONLY TOUCH YOUR MOUSE AND OR KEYBOARD WHEN ONE OF THESE BOXES HAVE POPPED UP. The script will now start
Sleep, 1000

WinActivate, ahk_exe Discord.exe
Send, {Escape}
Sleep, 120
Send, {Escape}


switchchannel(commandschannel)
cleartypingbar()
Sleep, 800

Loop, parse, userIDs, `,
{
    userID := A_LoopField
    OutputDebug, loop
    if checklist
    {
        Send, /%noteslist%
        Sleep, 1600
        Send, {enter}
        Sleep, 600
        Send, %userID%
        Sleep, 300
        Send, {enter}{enter}
        MsgBox, 4, Add note?, Add note to this user?
        IfMsgBox, Yes
            addNote(userID, note)
    }
    else
        addNote(userID, note)
}
MsgBox, Note added to last ID, returning to start
Gui, Destroy
Goto, start
return

addNote(x,y)
{
    notesnew = notes new
    Sleep, 150
    Send, /%notesnew%
    Sleep, 1200
    Send, {enter}
    Sleep, 500
    Send, %x%
    Sleep, 500
    Send, {enter}
    Sleep, 500
    Send, %y%
    Sleep, 300
    Send, {enter}{enter}
}

return
switchchannel(x)
{
    WinActivate, ahk_exe Discord.exe
    Sleep, 250
    Send, ^k
    Sleep, 100
    Send, % x
    Sleep, 600
    Send, {enter}
    Sleep, 2000
}
return

cleartypingbar()
{
    WinActivate, ahk_exe Discord.exe
    sleep, 150
    Send, a
    Sleep, 150
    Send, ^a{Backspace}
    Sleep, 100
    OutputDebug, Cleared typing bar
}
return

#x::
GuiClose:
GuiEscape:
ExitApp
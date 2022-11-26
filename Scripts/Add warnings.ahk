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

PVPRule = **Rule {#}1:** No PVP or hostile action towards any players. This rule, like all others **also applies after server shutdown.
AFKRule = **Rule {#}2:** No extended periods of AFK, leeching or use of macros.
leaveWarnRule = **Rule {#}5:** You must give a warning before leaving a ship using {!}leave 10 minutes in advance.
followSellPlanRule = **Rule {#}6:** The <{#}906559855186288690> must be followed while on an active fleet.

tutorial = 
(
The input tab is to enter the ID and gamertag of the user you want to check.
You can use multiple IDs by seperating them with a comma
You can also select an option to check the log history before adding the warning.

After you have set everything up press Continue and the script will run.
)
report = loghistory report

Gui, Add, Tab3,, Input|How to use

Gui, Add, Text,, Discord ID(s):
Gui, Add, Text,, Warning to add:
Gui, Add, Text,, Channel:
Gui, add, text,, Common warnings:
Gui, Add, Checkbox, vchecklist Checked y+15, Check log hist before adding warning
Gui, Add, Edit, vuserIDs ym x125 y31
Gui, Add, Edit, vwarning
Gui, Add, ComboBox, vchannel, staff-commands|on-duty-commands||captain-commands|admin-commands
Gui, Add, Combobox, vrule, PVP|AFK|leave warning||Sell plan|Custom
Gui, Tab, 2
Gui, Add, Text,, %tutorial%
Gui, Tab
Gui, Add, Button, x10, Continue
Gui, show

Return
ButtonContinue:
Gui, Submit

commandschannel = {#}%channel%


if (rule == "leave warning")
    warning := leaveWarnRule
else if (rule == "PVP")
    warning := PVPRule
else if (rule == "AFK")
    warning := AFKRule
else if (rule == "Sell plan")
    warning := followSellPlanRule

OutputDebug, warning = %warning%
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
        Send, /%report%
        Sleep, 1600
        Send, {enter}
        Sleep, 600
        Send, %userID%
        Sleep, 300
        Send, {enter}{enter}
        MsgBox, 4, Add Warning?, Add Warning to this user?
        IfMsgBox, Yes
            addWarn(userID, warning)
    }
    else
        addWarn(userID, warning)
}
MsgBox, Warning added to last ID, returning to start
Gui, Destroy
Goto, start
return

addWarn(x,y)
{
    warn = warn
    Sleep, 150
    Send, /%warn%
    Sleep, 1200
    Send, {enter}
    Sleep, 500
    Send, %x%
    Sleep, 500
    Send, {Right}
    Sleep, 500
    Send, {Down}
    Sleep, 500
    Send, {Tab}
    Sleep, 500
    Send, %y%
    Sleep, 600
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
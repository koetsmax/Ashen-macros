#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; Include logclass

#Include %A_ScriptDir%/LogClass.ahk

; Initizalize log

global log := new LogClass("id_to_mention")
lineStr := log.dividerString
varH     := log.scriptEnvReport
varPreE  := "%A_Now% -- "
varPostE := lineStr . . "`n" . lineStr
varF     :=  "`n" . lineStr . "Log file made by %A_UserName% on %A_ComputerName%" . "`n" . lineStr
log.initalizeNewLogFile(true,varH, varPreE, varPostE, varF)
log.maxNumbOldLogs := 1


warning =
(
Ranged and Melee Weapon Hit Detection
In areas of intense action, players may find themselves firing shots or landing strikes that do not cause damage to their targets.
While small improvements continue to be delivered during our regular updates, we are continuing to investigate and identify further improvements to the player combat experience.

TLDR: Press Windows+X to force quit the program
)

MsgBox, %warning%
; log.addLogEntry("Starting authenticator")
; auth()

; return
start:

; Variables

tutorial = 
(
The input tab is to enter the ID and gamertag of the user you want to check.
In the options tab you can select what you want to check. (default is all)

After you have set everything up press Continue and the script will run.
)
ondutychat = {#}on-duty-chat
invitetracker = {#}invite-tracker
sotofficial = {#}official-swag
info = info data
lhist = loghistory full
noteslist = notes list
notesnew = notes new
pagenumber = 1
log.addLogEntry("Variables initialized")

; Gui with input and options

Gui, Add, Tab3,, Input|How to use

Gui, Add, Text,, Channel:
Gui, Add, Text,, Discord IDs:
Gui, Add, ComboBox, vchannel ym x100 y31, staff-commands|on-duty-commands||captain-commands|
Gui, Add, Edit, r5 w135 vuserID

Gui, Tab, 2
Gui, Add, Text,, %tutorial%
Gui, Tab
Gui, Add, Button, x10, Continue
Gui, show, w400 h185
log.addLogEntry("Created GUI")

Return
ButtonContinue:
Gui, Submit


; RegEx magic bullshittery

userID := StrReplace(userID, " " , "")

StringReplace,userID,userID,`n,,A
StringReplace,userID,userID,`r,,A

userID := RegExReplace(userID, "^", "`r`n")

userID := RegExReplace(userID, ".{18}(?!$)", "$0`r`n")

userID := RegExReplace(userID, "`r`n", "<@")

userID := RegExReplace(userID, ".{20}(?!$)", "$0`r`n")

userID := RegExReplace(userID, "`r`n", ">")

userID := RegExReplace(UserID, "$", ">")

userID := RegExReplace(userID, ".{21}(?!$)", "$0`r`n")

MsgBox, %userID%

Clipboard := userID

MsgBox, Mentions copied to clipboard

GuiClose:
GuiEscape:
log.addLogEntry("Script closed by closing GUI...")
log.finalizeLog()
ExitApp
Return
#x::
{   
    log.addLogEntry("Script force closed by using Windows + X")
    log.finalizeLog()
    ExitApp
}
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; Include logclass

#Include %A_ScriptDir%/LogClass.ahk

; Initizalize log

global log := new LogClass("Staffcheck")
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



; Gui with input and options

Gui, Add, Tab3,, Input|How to use

Gui, Add, Text,, Discord ID:
Gui, Add, Text,, Channel:
Gui, Add, Checkbox, vsearchid, Search ID and GT through Ashen to see`nif they have already been checked before?
Gui, Add, Edit, vuserID ym x100 y31
Gui, Add, ComboBox, vchannel, staff-commands|on-duty-commands||captain-commands|
Gui, Add, Radio, vall Checked x250 y34, Entire staffcheck
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
log.addLogEntry("Created GUI")

Return
ButtonContinue:
Gui, Submit

commandschannel = {#}%channel%
userID := userID
; Do some checks on the userID

if userID is not integer
{
    log.addLogEntry("Userid invalid (not integer). UserID entered: "userID)
    OutputDebug, %userID%
    Gui, Destroy
    MsgBox, Error, Userid: %userID% is invalid. UserID MUST only consist of numbers
    Goto start
}

useridLength := StrLen(userID)

if (useridLength != 18)
{   
    log.addLogEntry("Userid invalid (invalid length): " . useridLength . " (should be 18) userID entered: "userID)
    OutputDebug, %userID%
    Gui, Destroy
    MsgBox, Error, Userid: %userID% is invalid. UserID MUST be 18 characters in length
    Goto start
}

MsgBox, 0, , DO NOT TOUCH YOUR MOUSE OR KEYBOARD WHEN THIS SCRIPT IS RUNNING. ONLY TOUCH YOUR MOUSE AND OR KEYBOARD WHEN ONE OF THESE BOXES HAVE POPPED UP. The script will now start
Sleep, 1500
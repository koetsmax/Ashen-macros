#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
StringCaseSense, On
#Include %A_ScriptDir%/LogClass.ahk

; Read INI

IfNotExist, settings.ini
{
    MsgBox, settings.ini file not found. Creating file...
    FileAppend, , settings.ini
    IniWrite, userID Good to check -- GT: xboxGT, settings.ini, staffcheck, goodtocheckmessage
    IniWrite, userID **Not** Good to check -- GT: xboxGT -- Reason, settings.ini, staffcheck, notgoodtocheckmessage
    log.addLogEntry("Created settings.ini")
}

IniRead, gtc, settings.ini , staffcheck, goodtocheckmessage
IniRead, ngtc, settings.ini , staffcheck, notgoodtocheckmessage

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
start:
Gui, destroy

;variables

tutorial = 
(
The input tab is to enter the ID and gamertag of the user you want to check.

In the customization tab you can change the check messages to your personal liking

After you have set everything up press Continue and the script will run.
)
ondutychat = {#}on-duty-chat
invitetracker = {#}invite-tracker
sotofficial = {#}official-swag
report = loghistory report
noteslist = notes list
notesnew = notes new
pagenumber = 1
log.addLogEntry("Variables initialized")
IniRead, gtc, settings.ini , staffcheck, goodtocheckmessage
IniRead, ngtc, settings.ini , staffcheck, notgoodtocheckmessage

; Gui with input and options

Gui, Add, Tab3,, Input|Customization|How to use

Gui, Add, Text,, Discord ID:
Gui, Add, Text,, Xbox Gamertag:
Gui, Add, Text,, Channel:
Gui, Add, Checkbox, vsearchid y+15p, Search ID and GT through Ashen to see`nif they have already been checked before?
Gui, Add, Edit, vuserID ym x100 y31
Gui, Add, Edit, vxboxGT
Gui, Add, ComboBox, vchannel, staff-commands|on-duty-commands||captain-commands|admin-commands
Gui, Add, Radio, vall Checked x250 y34, Entire staffcheck
Gui, Add, Radio, velemental, Elemental commands
Gui, Add, Radio, vashen, Ashen commands
Gui, Add, Radio, vinvites, Check Invite tracker
Gui, Add, Radio, vsot, Check Sot official
Gui, Add, Radio, vgoodtocheck, Good to check

Gui, Tab, 2
Gui, Add, Text,, discord id = userID. gamertag = xboxGT. reason = Reason. (case sensitive)
Gui, Add, Text,, Good to check message:
Gui, Add, Edit, r1 vgtc w400, %gtc%
Gui, Add, Text,, Not Good to check message:
Gui, Add, Edit, r1 vngtc w400, %ngtc%
Gui, Add, Button,, Save changes
Gui, Add, Button,x+10p, Reset to default

Gui, Tab, 3
Gui, Add, Text,, %tutorial%
Gui, Tab
Gui, Add, Button, x10, Continue
Gui, Add, Button, x+10p, Check for updates
Gui, show
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

if not (useridLength == 17 or useridLength == 18 or useridLength == 19)
{   
    log.addLogEntry("Userid invalid (invalid length): " . useridLength . " (should be 17, 18 or 19) userID entered: "userID)
    OutputDebug, %userID%
    Gui, Destroy
    MsgBox, Error, Userid: %userID% is invalid. UserID MUST be 17, 18 or 19 characters in length
    Goto start
}

MsgBox, DO NOT TOUCH YOUR MOUSE OR KEYBOARD WHEN THIS SCRIPT IS RUNNING. ONLY TOUCH YOUR MOUSE AND OR KEYBOARD WHEN ONE OF THESE BOXES HAVE POPPED UP. The script will now start
Sleep, 1000

WinActivate, ahk_exe Discord.exe
log.addLogEntry("Entered discord")
Send, {Escape}
Sleep, 120
Send, {Escape}

; check if searchid is checked

log.addLogEntry("Check if searchid is enabled...")

if searchid
{
    log.addLogEntry("Searchid is enabled")
    cleartypingbar()
    Send, {Escape}
    switchchannel(commandschannel)
    search(userID)
    log.addLogEntry("Started search for ID in ashen")
    MsgBox, Click OK when you are ready to continue
    WinActivate, ahk_exe Discord.exe   
    search(xboxGT)
    log.addLogEntry("Started search for gamertag in ashen")
    MsgBox, Click OK when you are ready to continue
    Send, {Escape}
    Sleep, 120
    Send, {Escape}
    MsgBox, 4,, Do you want to continue with this staffcheck? Press YES to continue and NO to cancel.
    IfMsgBox, No
    {
        log.addLogEntry("Staffcheck canceled after pressing No")
        Gui, Destroy
        Goto, start
    }
    
}
log.addLogEntry("Check which radio was entered")

; Go to sub-routine
Gui, Destroy
if all
    Goto elemental
else if elemental
    Goto elemental
else if ashen
    Goto ashen
else if invites
    Goto invites
else if sot
    Goto sotofficial
else if goodtocheck
    Goto goodtocheck
else
{
    MsgBox, An error has ocured, please try again
    Goto start
}
Return

elemental:

switchchannel(commandschannel)
cleartypingbar()
Sleep, 800
Send, /%report%
Sleep, 1600
Send, {enter}
Sleep, 600
Send, %userID%
Sleep, 300
Send, {enter}{enter}
log.addLogEntry("Executed command: /loghistory report")
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
        Break
}


MsgBox, 4, Add GT to notes?, Press Yes to add GT to notes if necessary
IfMsgBox, Yes
{
    WinActivate, ahk_exe Discord.exe
    log.addLogEntry("Adding GT to notes (manual)")
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
MsgBox, 0, Elemental commands, Press OK once you have looked through the Elemental commands

if !all
    Goto, start

ashen:

switchchannel(commandschannel)
cleartypingbar()
WinActivate, ahk_exe Discord.exe
OutputDebug, entered discord
Sleep, 250
Send, {!}search %userID%{enter}
log.addLogEntry("Executed command: !search")
Sleep, 250
Send, {!}xsearch %xboxGT%{enter}
log.addLogEntry("Executed command: !xsearch")
Sleep, 250
MsgBox, 0, Ashen commands, Press OK once you have looked through the Ashen commands

if !all
    Goto, start

invites:

WinActivate, ahk_exe Discord.exe
log.addLogEntry("Opened discord")
switchchannel(invitetracker)
search("in:#invite-tracker "userID)
log.addLogEntry("Searched ID in invite tracker")
MsgBox, 0, Invite Tracker, Press OK once you have looked through the invite tracker

if !all
    Goto, start

sotofficial:

WinActivate, ahk_exe Discord.exe
log.addLogEntry("Opened discord")
Send, ^a{Backspace}
Send, {Escape}
switchchannel(sotofficial)
search("from: "userID)
log.addLogEntry("Searched sot official messages")
MsgBox, 4, Sot Official, Press YES if there are a lot of messages and the search results need to be narrowed down. press NO if there are no Anti-alliance messages.
IfMsgBox, Yes
{
    WinActivate, ahk_exe Discord.exe
    log.addLogEntry("Opened discord")
    Send, ^f
    Sleep, 300
    Send, {Space}alliance
    Sleep, 200
    Send, {enter}
    log.addLogEntry("Narrowed down search results")
    MsgBox, 0, Sot Official, Press OK Once you have looked through their messages in Sot Official
}

if !all
    Goto, start

goodtocheck:

WinActivate, ahk_exe Discord.exe
log.addLogEntry("Opened discord")
cleartypingbar()
Send, {Escape}
Sleep, 100
MsgBox, 3, Good to check?, Is this person good to check? Press cancel to cancel if you have to look into this person more.
IfMsgBox, Yes
{
    oldclipboard := clipboard
    gtc := StrReplace(gtc, "userID", "<@" . userID . ">")
    gtc := StrReplace(gtc, "xboxGT", xboxGT)
    clipboard := gtc
}
IfMsgBox, No
{
    InputBox, Reason, Reason, Please enter the Reason that the user is not good to check, , , 125
    oldclipboard := clipboard
    ngtc := StrReplace(ngtc, "userID", "<@" . userID . ">")
    ngtc := StrReplace(ngtc, "xboxGT", xboxGT)
    ngtc := StrReplace(ngtc, "Reason", Reason)
    clipboard := ngtc
}
IfMsgBox, Cancel
{
    log.addLogEntry("Cancel was pressed in post check message")
    Goto, start
}
switchchannel(ondutychat)
cleartypingbar()
Send, ^v
log.addLogEntry("Sent (not) good to check message")
Sleep, 500
Send, {Enter}
Clipboard := oldClipboard
Goto, start
return

Buttonsavechanges:
Gui, Submit
IniWrite, %gtc%, settings.ini, staffcheck, goodtocheckmessage
IniWrite, %ngtc%, settings.ini, staffcheck, notgoodtocheckmessage
Gui, Destroy
Goto, start
return

Buttonresettodefault:
MsgBox, 4,, Are you sure you want to reset these options to default?
IfMsgBox, Yes
{
    IniWrite, userID Good to check -- GT: xboxGT, settings.ini, staffcheck, goodtocheckmessage
    IniWrite, userID **Not** Good to check -- GT: xboxGT -- Reason, settings.ini, staffcheck, notgoodtocheckmessage
}

Gui, Destroy
Goto, start
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
    log.addLogEntry("Opened: "x)
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
}
return

search(x)
{
    oldClipboard := Clipboard
    Clipboard := x
    WinActivate, ahk_exe Discord.exe
    Send, ^f
    cleartypingbar()
    Send, ^v
    Sleep, 150
    Send, {enter}
    Clipboard := oldClipboard
}
return

GuiClose:
GuiEscape:
log.addLogEntry("Script closed by closing GUI")
log.finalizeLog()
ExitApp
return

ButtonCheckforupdates:
Gui, Submit
Gui, Destroy
owner := "koetsmax"
repo := "ashen-macros"
res := WebRequest("https://api.github.com/repos/" . owner . "/" . repo . "/releases/latest",,,, error := "")
if error
    MsgBox,, Error, % error . "`n`nresponse:`n" . res
else
    pos := RegExMatch(res, """tag_name"":\s*""\K[^""]*", github)
FileRead, Local, ..\version
if (Local == "")
    Local = 0
Version1 := github
Version2 := Local
Latest := VersionCompare(Version1, Version2)
if (latest == 0)
    MsgBox, You are currently on the latest release
else if (Latest == 1)
{
    Gui, Add, Text,, There is an update available! `n`nYour version:    %Local%. `nLatest version: %github%
    Gui, Add, Button,x10 y+5n, Download the new version
    Gui, Add, Button,x+10p, Continue on this version
    Gui, Show
}
else if (Latest == 2)
{
    MsgBox, You are currently ahead of the github release
    Goto, start
}
return

VersionCompare(version1, version2)
{
	StringSplit, verA, version1, .
	StringSplit, verB, version2, .
	Loop, % (verA0> verB0 ? verA0 : verB0)
	{
		if (verA0 < A_Index)
			verA%A_Index% := "0"
		if (verB0 < A_Index)
			verB%A_Index% := "0"
		if (verA%A_Index% > verB%A_Index%)
			return 1
		if (verB%A_Index% > verA%A_Index%)
			return 2
	}
	return 0
}
return

WebRequest(url, method := "GET", HeadersArray := "", body := "", ByRef error := "") 
{
    Whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    Whr.Open(method, url, true)
    for name, value in HeadersArray
        Whr.SetRequestHeader(name, value)
    Whr.Send(body)
    Whr.WaitForResponse()
    status := Whr.status
    if (status == 403)
        MsgBox, Your ip is being rate limited. Please try again in an hour
    if (status != 200)
        error := "HttpRequest error, status: " . status
    
    Arr := Whr.responseBody
    pData := NumGet(ComObjValue(arr) + 8 + A_PtrSize)
    length := Arr.MaxIndex() + 1
    Return StrGet(pData, length, "UTF-8")
}
return

buttondownloadthenewversion:
Gui, Destroy
run, https://github.com/koetsmax/Ashen-macros/releases//latest

#x::
log.addLogEntry("Script force closed by using Windows + X")
log.finalizeLog()
ExitApp
return
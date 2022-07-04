#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; Include logclass

#Include LogClass.ahk

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

; Check if .ini file exists

IfNotExist, settings.ini
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
    log.addLogEntry("Created settings.ini")
}

; Gui with input and options

Gui, Add, Tab3,, Input|How to use

Gui, Add, Text,, Discord ID:
Gui, Add, Text,, Xbox Gamertag:
Gui, Add, Text,, Channel:
Gui, Add, Checkbox, vsearchid, Search ID and GT through Ashen to see`nif they have already been checked before?
Gui, Add, Edit, vuserID ym x100 y31
Gui, Add, Edit, vxboxGT
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
    Send, ^a{Backspace}
    Send, {Escape}
    Sleep, 150
    Send, ^k
    Sleep, 100
    Send, %commandschannel%
    Sleep, 350
    Send, {enter}
    log.addLogEntry("Opened: "commandschannel)
    Sleep, 2000
    Send, ^f
    Sleep, 150
    Send, ^a{Backspace}
    Sleep, 120
    Send, %userID% 
    Sleep, 150
    Send, {enter}
    log.addLogEntry("Started search for ID in ashen")
    MsgBox, Click OK when you are ready to continue

    Send, ^a{Backspace}
    Sleep, 500
    Send, %xboxGT% 
    Sleep, 150
    Send, {enter}
    Sleep, 800
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
if (all == 1)
    Goto all
else if (elemental == 1)
    Goto elemental
else if (ashen == 1)
    Goto ashen
else if (invites == 1)
    Goto invites
else if (sot == 1)
    Goto sotofficial
else if (goodtocheck == 1)
    Goto goodtocheck
else
{
    MsgBox, An error has ocured, please try again
    Goto start
}
Return
all:

elemental:

; Move to on duty commands

Sleep, 120
Send, ^k
Sleep, 120
Send, %commandschannel%
Sleep, 350
Send, {enter}
log.addLogEntry("Entered: "commandschannel)
Sleep, 2000

; delete all text in message box

Send, a
Sleep, 150
Send, ^a{Backspace}

; check info data

Sleep, 800
Send, /%info%
Sleep, 1600
Send, {enter}user{enter}
Sleep, 600
Send, %userID%
Sleep, 300
Send, {enter}{enter}
log.addLogEntry("Executed command: /info data user")

; check log hist

Sleep, 150
Send, /%lhist%
Sleep, 1600
Send, {enter}
Sleep, 600
Send, %userID%
Sleep, 300
Send, {enter}{enter}
log.addLogEntry("Executed command: /loghistory full")

; check notes

Sleep, 150
Send, /%noteslist%
Sleep, 1600
Send, {enter}
Sleep, 600
Send, %userID%
Sleep, 300
Send, {enter}{enter}
log.addLogEntry("Executed command: /notes list")
Sleep, 2500

; get RGB value of specific Pixel

PixelGetColor, RGBcolour, 963, 1791, RGB

; Multiple pages of notes?

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
    {
        Break
    }
}

; add GT to notes if needed

Sleep, 2500
if (RGBcolour == 0x49443C) {
    log.addLogEntry("Adding GT to notes (pixelcheck)")
    Sleep, 150
    Send, /%notesnew%
    Sleep, 1600
    Send, {enter}
    Sleep, 500
    Send, %userID%
    Sleep, 500
    Send, {enter}
    Sleep, 500
    Send, GT: %xboxGT%
    Sleep, 300
    Send, {enter}{enter}
} else if (RGBcolour == 0x32353B){
    log.addLogEntry("not adding gt to notes (pixelcheck)")
    MsgBox, 4, Add note with GT?, Press YES to place a note with the gamertag if the autoplacement failed.
    IfMsgBox, Yes
    {
        WinActivate, ahk_exe Discord.exe
        log.addLogEntry("Adding GT to notes (manual)")
        Sleep, 150
        Send, /%notesnew%
        Sleep, 1600
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
} else if (RGBcolour == 0x36393F){
    log.addLogEntry("not adding gt to notes (pixelcheck)")
    MsgBox, 4, Add note with GT?, Press YES to place a note with the gamertag if the autoplacement failed.
    IfMsgBox, Yes
    {
        WinActivate, ahk_exe Discord.exe
        log.addLogEntry("Adding GT to notes (manual)")
        Sleep, 150
        Send, /%notesnew%
        Sleep, 1600
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
} else {
    MsgBox, 4, Pixelcheck failed, Press Yes to add GT to notes anyway if necessary
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
}

MsgBox, 0, Elemental commands, Press OK once you have looked through the Elemental commands

; Check if radio = all

if !all
    Goto, start

ashen:

; Go to on-duty-commands
if !all{
    Sleep, 120
    Send, ^k
    Sleep, 120
    Send, %commandschannel%
    Sleep, 350
    Send, {enter}
    log.addLogEntry("Opened: "commandschannel)
    Sleep, 2000
}

if (all == 1){
    Sleep, 120
    Send, ^k
    Sleep, 120
    Send, %commandschannel%
    Sleep, 350
    Send, {enter}
    log.addLogEntry("Opened: "commandschannel)
    Sleep, 800
}

; Delete all text in msg box

Send, a
Sleep, 150
Send, ^a{Backspace}

; Check ashen commands

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

; Check if radio = all

if !all
    Goto, start

invites:

; Invite Tracker

WinActivate, ahk_exe Discord.exe
log.addLogEntry("Opened discord")
Send, ^k
Sleep, 100
Send, %invitetracker%
Sleep, 350
Send, {enter}
log.addLogEntry("Opened invite tracker")
Sleep, 2000
Send, ^f
Sleep, 150
Send, ^a{Backspace}
Send, {Escape}
Sleep, 150
Send, ^f
Sleep, 120
Send, %userID%
Sleep, 80
Send, {enter}
log.addLogEntry("Searched ID in invite tracker")
MsgBox, 0, Invite Tracker, Press OK once you have looked through the invite tracker

; Check if radio = all

if !all
    Goto, start

sotofficial:

; Check sot official posts

WinActivate, ahk_exe Discord.exe
log.addLogEntry("Opened discord")
Send, ^a{Backspace}
Send, {Escape}
Sleep, 150
Send, ^k
Sleep, 100
Send, %sotofficial%
Sleep, 350
Send, {enter}
log.addLogEntry("Opened sot official")
Sleep, 2000
Send, ^f
Sleep, 150
Send, ^a{Backspace}
Sleep, 120
Send, from: %userID% 
Sleep, 150
Send, {enter}
log.addLogEntry("Searched sot official messages")
MsgBox, 4, Sot Official, Press YES if there are a lot of messages and the search results need to be narrowed down. press NO if there are no Anti-alliance messages.
IfMsgBox, Yes
{
    WinActivate, ahk_exe Discord.exe
    log.addLogEntry("Opened discord")
    Send, ^f
    Sleep, 300
    Send, {Space}alliance
    Sleep, 100
    Send, {enter}
    log.addLogEntry("Narrowed down search results")
    MsgBox, 0, Sot Official, Press OK Once you have looked through their messages in Sot Official
}

; Check if radio = all

if !all
    Goto, start

goodtocheck:

; Staffcheck complete

WinActivate, ahk_exe Discord.exe
log.addLogEntry("Opened discord")
Sleep, 250
Send, ^a{Backspace}
Sleep, 100
Send, {Escape}
Sleep, 100
MsgBox, 3, Good to check?, Is this person good to check? Press cancel to cancel if you have to look into this person more.
IfMsgBox, Yes
{
    IniRead, gtcbeforeid, settings.ini , staffcheck, gtcbeforeid
    IniRead, gtcafterid, settings.ini , staffcheck, gtcafterid
    IniRead, gtcaftergt, settings.ini , staffcheck, gtcaftergt
    log.addLogEntry("Read .ini file for good to check message")
    Sleep, 150
    Send, ^k
    Sleep, 100
    Send, %ondutychat%
    Sleep, 350
    Send, {enter}
    log.addLogEntry("Opened on duty chat")
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
    Sleep, 250
    Send, {enter}
    log.addLogEntry("Sent good to check message")
}
IfMsgBox, No
{
    IniRead, notnotgtcbeforeid, settings.ini , staffcheck, notgtcbeforeid
    IniRead, notgtcafterid, settings.ini , staffcheck, notgtcafterid
    IniRead, notgtcaftergt, settings.ini , staffcheck, notgtcaftergt
    IniRead, notgtcafterreason, settings.ini , staffcheck, notgtcafterreason
    log.addLogEntry("Read .ini file for not good to check message")
    InputBox, Reason, Reason, Please enter the Reason that the user is not good to check, , , 125
    Send, ^k
    Sleep, 100
    Send, %ondutychat%
    Sleep, 350
    Send, {enter}
    log.addLogEntry("Opened on duty chat")
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
    Sleep, 250
    Send, {enter}
    log.addLogEntry("Sent not good to check message")
}


Goto, start
GuiClose:
GuiEscape:
log.addLogEntry("Script closed by closing GUI...")
log.finalizeLog()
ExitApp
return

ihidestr(thisstr)
{
	return thisstr
}


decode_hidestr(startstr) 
{
	global	
;$OBFUSCATOR: $DEFGLOBVARS: hexdigits
	critical
	static newstr, startstrlen, charnum, hinibble, lownibble, mybinary
;$OBFUSCATOR: $DEFLOSVARS: newstr, startstrlen, charnum, hinibble, lownibble, mybinary

	hexdigits = % "0123456789abcdef"
		
	decode_hexshiftkeys(startstr)
	
	startstr = % substr(startstr, 1, 1) . substr(startstr, 6)
	startstrlen = % strlen(startstr)
		
	newstr = 
	loop, % strlen(startstr) 
		newstr = % substr(startstr, a_index, 1) . newstr
	
	startstr = % newstr
	newstr = 
	charnum = 1
	loop
	{
		if (charnum >startstrlen)
			break
			
		hinibble = % substr(startstr, charnum, 1)
		hinibble = % instr(hexdigits, hinibble) - 1
		
		lownibble = % substr(startstr, charnum + 1, 1)
		lownibble = % instr(hexdigits, lownibble) - 1
		
		hinibble := decode_shifthexdigit(hinibble)
		lownibble := decode_shifthexdigit(lownibble)
		
		mybinary = % hinibble * 16 + lownibble
		newstr .= chr(mybinary)
		
		charnum += 2		
	}
		
	newstr = % fixescapes(newstr)
		
	return, newstr	
}
decode_hexshiftkeys(startstr)
{
	global
;$OBFUSCATOR: $DEFGLOBVARS: decodekey, ishexchar, useshiftkey
	
	decodekey := "fff@kkf1ffkfkfkfff#k1fk@kf#@fffk@#kk"
	ishexchar := "fff@f1ff@kffkk#f1fffffkf"
	
	%decodekey%%ishexchar%1 = % substr(startstr, 2, 1)
	%decodekey%%ishexchar%2 = % substr(startstr, 3, 1)
	%decodekey%%ishexchar%3 = % substr(startstr, 4, 1)
	%decodekey%%ishexchar%4 = % substr(startstr, 5, 1)
	
	loop, 4
		%decodekey%%a_index% = % instr(hexdigits, %decodekey%%ishexchar%%a_index%) - 1
			
	useshiftkey = 0
}	

decode_shifthexdigit(hexvalue)
{
	global
	
	useshiftkey++
	if (useshiftkey > 4)
		useshiftkey = 1	
	
	hexvalue -= %decodekey%%useshiftkey%
	
	if (hexvalue < 0) 
		hexvalue += 16
		
	return hexvalue	
}

fixescapes(forstr)
{
	global
	
	StringReplace, forstr, forstr, % "````", % "``", all
	StringReplace, forstr, forstr, % "``n", % "`n", all
	StringReplace, forstr, forstr, % "``r", % "`r", all
	StringReplace, forstr, forstr, % "``,", % "`,", all
	StringReplace, forstr, forstr, % "``%", % "`%", all	
	StringReplace, forstr, forstr, % "``;", % "`;", all	
	StringReplace, forstr, forstr, % "``t", % "`t", all
	StringReplace, forstr, forstr, % "``b", % "`b", all
	StringReplace, forstr, forstr, % "``v", % "`v", all
	StringReplace, forstr, forstr, % "``a", % "`a", all
	
	StringReplace, forstr, forstr, % """""", % """", all
	
	return forstr
}

;$OBFUSCATOR: $END_AUTOEXECUTE:

auth()
{
	; Variables
	2commandschannel = {#}staff-commands
	getid = getid user
	userlist:= decode_hidestr("ad3b900ec09e402e901e30de30de409e30bea0beff0e700ec09e709e609eb02e60ae400ea0ee705da0cea0fe40ce400e40ae30deb0be609e80beffde70ee70deb0be80de50fe80eec0aea0be405d502e80fe900e50dea01e70ce40ae70de60eeffbea0be90de90dea00e80ae90ee50de90be405d70ae40ae609e90dec0ee409e909e700e70beffbea09ec0ae90ce302ec02e50ce501e60be605d500eb02e802e30ae50ce40de700e70ae80aeffee30eea0ae80beb01ea0ae50beb0fe70fe50")
    log.addLogEntry("Initialized variables for authorisation")
    
	; Authentication

	WinActivate, ahk_exe Discord.exe
	WinGet, iswinmax, MinMax, ahk_exe discord.exe
	WinRestore, ahk_exe discord.exe
	OutputDebug, %iswinmax%
	WinGetPos, X, Y, W, H, ahk_exe discord.exe
	WinActivate, ahk_exe Discord.exe
	OutputDebug, entered discord
	Send, {Escape}
	Sleep, 120
	Send, {Escape}
	Sleep, 120
	Send, ^k
	Sleep, 120
	Send, %2commandschannel%
	Sleep, 350
	Send, {enter}
	log.addLogEntry("Opened staff commands")
	Sleep, 2000

	; Move discord window

	WinMove, ahk_exe discord.exe,, 300, 150, 1200, 820
	WinActivate, ahk_exe discord.exe
	Sleep, 200
	Send, a
	Sleep, 100
	Send, ^a
	Sleep, 100
	Send, {BackSpace}
    log.addLogEntry("Activated Discord")

	; Execute command

	Send, /%getid%
	Sleep, 1000
	Send, {Enter}{Enter}
	Sleep, 1500
	MouseClickDrag, L, 751, 715, 715, 623
	Send, ^c
    log.addLogEntry("Sent getid command")

	; Move window back to original position

	WinMove, ahk_exe discord.exe,, %X%, %Y%, %W%, %H%
    global xx := x
    global yy := y
    global ww := w
    global hh := h
    global iswinmaximized := iswinmax
    log.addLogEntry("Moved discord back to %xx%, %yy%, %ww%, %hh%, %iswinmaximized%")
	if (iswinmax == 1)
	{
		WinMaximize ahk_exe discord.exe
	}

	loop, parse, Clipboard, `n,`r
	{
	e .= A_LoopField . a_space
	loop, parse, A_LoopField, {Space}
	{
		if A_LoopField is Integer
			authID = %A_LoopField%
	}
	}

	Loop, parse, userlist, `,
	{
		if (%A_LoopField% == %authID%)
			{
                log.addLogEntry("authID: "authID)
				MsgBox, Logged in as: %authID%
				Gosub, start
				Exit
			}
	}

	MsgBox, Authentication failed, see log for errors
    log.addLogEntry("Authentication failed, Report to Max if you are authorized to use this" Clipboard)
	ExitApp
}

Return
#x::
{   
    log.addLogEntry("Script force closed by using Windows + X")
    log.finalizeLog()
    ExitApp
}

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
For ashen bans open the Ashen tab and enter the specific info.
this will add them to the ban list and add them in AoA.

For requiem bans enter the entire entry as shown in AoA. INCLUDING GT:

For fortune bans enter the info separate as shown

Do not forget to still react with an ashen emote to the entry.
This might be made automatic in the future.
but I haven't really found a good way to do this yet.
)
count = 0
reqcount = 0
fofcount = 0
loopCount = 0
alreadyopen = 0
banlist = {#}ban-list

; Gui with input and options

Gui, Add, Tab3,, Ashen|Requiem|Fleets of Fortune|How to use

Gui, Add, Text,, Discord Name:
Gui, Add, Text,, xbox Gamertag:
Gui, Add, Text,, Discord ID:
Gui, Add, Text,, Reason:
Gui, Add, Text,, your name:
Gui, Add, Text,, your Timezone:
Gui, Add, Edit, vdiscordname ym x100 y31
Gui, Add, Edit, vxboxGT
Gui, Add, Edit, vuserID
Gui, Add, Edit, vreason
Gui, Add, Edit, vname
Gui, Add, Edit, vtimezone

Gui, Tab, 2
Gui, Add, Text,, Full ban entry as listed in AoA:
Gui, Add, Edit, vreqban ym x167 y31
Gui, Add, Text,x22 y55, Enter multiple entries by separating them with an = sign

Gui, Tab, 3
Gui, Add, Text,, Discord Name:
Gui, Add, Text,, xbox Gamertag:
Gui, Add, Text,, Discord ID:
Gui, Add, Text,, Reason:
Gui, Add, Edit, vfofname ym x100 y31
Gui, Add, Edit, vfofxboxGT
Gui, Add, Edit, vfofuserID
Gui, Add, Edit, vfofreason

Gui, Tab, 4
Gui, Add, Text,, %tutorial%
Gui, Tab
Gui, Add, Button, x10, Continue
Gui, Add, Checkbox, x+10p y208 vstephmode, Steph Mode
Gui, show, w400 h235
OutputDebug, Opened GUI

Return
ButtonContinue:
Gui, Submit

if (userID is not integer or "")
{
    OutputDebug, %userID%
    Gui, Destroy
    MsgBox, Error, Userid: %userID% is invalid. UserID MUST only consist of numbers
    Goto start
}
if (fofuserID is not Integer or "")
{
    OutputDebug, %fofuserID%
    Gui, Destroy
    MsgBox, Error, Userid: %fofuserID% is invalid. UserID MUST only consist of numbers
    Goto start
}

; Check not empty text boxes

if not (discordname == "")
    count++
if not (xboxGT == "")
    count++
if not (userID == "")
    count++
if not (reason == "")
    count++
if not (name == "")
    count++
if not (timezone == "")
    count++
if not (reqban == "")
    reqcount++
if not (fofname == "")
   fofcount++
if not (fofxboxGT == "")
    fofcount++
if not (fofuserID == "")
    fofcount++
if not (fofreason == "")
    fofcount++
OutputDebug, count %count%
OutputDebug, reqcount %reqcount%
OutputDebug, fofcount %fofcount%


OutputDebug, Determining behaviour

Gui, Destroy
if (count == 6 and reqcount == 0 and fofcount == 0)
    Goto ashen
else if (count == 0 and reqcount == 1 and fofcount == 0)
    Goto requiem
else if (count == 0 and reqcount == 0 and fofcount == 4)
    Goto fof
Else
{
    MsgBox, Invalid amount of arguments entered, please try again
    Goto start
}
Return

ashen:

; Add ashen ban
if stephmode
{
    WinActivate, ahk_exe firefox.exe
    WinActivate, ahk_exe msedge.exe
    WinActivate, ahk_exe chrome.exe
    Winactivate, ahk_exe operagx.exe
    Sleep, 1500
}
else if not stephmode
{
    url := "https://docs.google.com/spreadsheets/d/1V5Z61CKmJoNZn7L3PWziJdbHRVzYuxaZU4qTOIRHfWg/edit#gid=2129628623"
    ; a temporary file, running directory must be writeable
    outputFile := "a$$$$$$.html"
    if (FileExist(outputFile))
        FileDelete, %outputFile%

    FileAppend,
    (
    <html>
    <body>
    <script>
    document.location.href="
    ),%outputFile%
    FileAppend,%url%,%outputFile%
    FileAppend,
    (
    "
    </script>
    </body>
    </html>
    ),%outputFile%

    cmdToRun := "cmd /c " . outputFile
    run, %cmdToRun%

    Sleep, 8000

    ; remove temporary file
    if (FileExist(outputFile))
        FileDelete, %outputFile%

    Sleep, 3000
Send, {CtrlDown}{Down}{CtrlUp}{Down}
}

send, %A_MM%/%A_DD%/%A_YYYY%
Sleep, 250
Send, {Right}
Sleep, 200
Send, {Raw}%A_Hour%:%A_Min% %timezone%
Sleep, 300
Send, {Right}
Sleep, 200
Send, {Raw}%discordname%
Sleep, 300
Send, {Right}
Sleep, 200
Send, {Raw}%xboxGT%
Sleep, 300
Send, {Right}
Sleep, 200
Send, {Raw}%userID%
Sleep, 300
Send, {Right}
Sleep, 200
Send, {Raw}%reason%
Sleep, 300
Send, {Right}
Sleep, 200
Send, {Raw}%name%
Sleep, 300
OutputDebug, Added ban to ban list

; Add ban to AoA

MsgBox, 4, Add to AoA?, Do you want to post this ban to AoA?
IfMsgBox, No
    Goto, start

Clipboard := A_Tab

WinActivate, ahk_exe Discord.exe
OutputDebug, entered discord
Send, {Escape}
Sleep, 120
Send, {Escape}

Sleep, 120
Send, ^k
Sleep, 120
Send, %banlist%
Sleep, 350
Send, {enter}
OutputDebug, Opened banlist
Sleep, 2000

Send, {Raw}%discordname%
Sleep, 300
Send, ^v
Send, {Raw}%xboxGT%
Sleep, 300
Send, ^v
Send, {Raw}%userID%
Sleep, 300
Send, ^v
Send, {Raw}%reason%
Sleep, 300
Send, {Enter}
Send, {Right}

Goto, start
Return
requiem:

Loop, parse, reqban, `=
{
    requiemban := A_LoopField
    Outputdebug, %requiemban%
    Loop, parse, requiemban, -
    {
        ban := Trim(A_LoopField)
        OutputDebug, ban = %ban%
        if ban Contains GT:
        {
        gamertag := SubStr(ban, 4)
        gamertag := Trim(gamertag)
        }
        else if ban is integer
            userID = %ban%
        else if ban contains #
            discordname = %ban%
        else if ban not contains ???
            reason = %ban%
        Else
            Outputdebug, no matches found for %ban% in `n %reqban%
    }

    if stephmode
    {
    WinActivate, ahk_exe firefox.exe
    WinActivate, ahk_exe msedge.exe
    WinActivate, ahk_exe chrome.exe
    Winactivate, ahk_exe operagx.exe
    Sleep, 1500
    }
    else if not stephmode
    {
        if not alreadyopen
        {
        url := "https://docs.google.com/spreadsheets/d/1V5Z61CKmJoNZn7L3PWziJdbHRVzYuxaZU4qTOIRHfWg/edit#gid=125271616"
        outputFile := "a$$$$$$.html"
        if (FileExist(outputFile))
            FileDelete, %outputFile%

        FileAppend,
        (
        <html>
        <body>
        <script>
        document.location.href="
        ),%outputFile%
        FileAppend,%url%,%outputFile%
        FileAppend,
        (
        "
        </script>
        </body>
        </html>
        ),%outputFile%

        cmdToRun := "cmd /c " . outputFile
        run, %cmdToRun%
        Sleep, 8000

        if (FileExist(outputFile))
            FileDelete, %outputFile%
        Sleep, 3000
        Send, {CtrlDown}{Down}{CtrlUp}{Down}
        Sleep, 250
        }
    }
    if alreadyopen
    {
        Sleep, 250
        Send, {Down}
        Sleep, 250
        Send, {CtrlDown}{Left}{CtrlUp}
        Sleep, 600
    }
    oldClipboard := Clipboard
    Clipboard := discordname
    if (Clipboard == "")
        Clipboard := "N/A"
    Send, ^v
    Sleep, 600
    Send, {Right}
    Sleep, 250
    Clipboard := gamertag
    if (Clipboard == "")
        Clipboard := "N/A"
    else if Clipboard contains ???
        Clipboard := "N/A"
    Send, ^v
    Sleep, 600
    Send, {Right}
    Sleep, 250
    Clipboard := userID
    if (Clipboard == "")
        Clipboard := "N/A"
    else if Clipboard contains ???
        Clipboard := "N/A"
    Send, ^v
    Sleep, 600
    Send, {Right}
    Sleep, 250
    Clipboard := "Requiem"
    Send, ^v
    Sleep, 600
    Send, {Right}
    Sleep, 250
    Clipboard := reason
    if (Clipboard == "")
        Clipboard := "N/A"
    else if Clipboard contains ???
        Clipboard := "N/A"
    Send, ^v
    Sleep, 600
    Send, {Right}
    Sleep, 250
    alreadyopen = 1
}
CLipboard := oldClipboard
Goto, start
Return
fof:

; Add fof ban to shared list
if stephmode
{
    WinActivate, ahk_exe firefox.exe
    WinActivate, ahk_exe msedge.exe
    WinActivate, ahk_exe chrome.exe
    Winactivate, ahk_exe operagx.exe
    Sleep, 1500
}
else if not stephmode
{
    url := "https://docs.google.com/spreadsheets/d/1V5Z61CKmJoNZn7L3PWziJdbHRVzYuxaZU4qTOIRHfWg/edit#gid=125271616"
    ; a temporary file, running directory must be writeable
    outputFile := "a$$$$$$.html"
    if (FileExist(outputFile))
        FileDelete, %outputFile%

    FileAppend,
    (
    <html>
    <body>
    <script>
    document.location.href="
    ),%outputFile%
    FileAppend,%url%,%outputFile%
    FileAppend,
    (
    "
    </script>
    </body>
    </html>
    ),%outputFile%

    cmdToRun := "cmd /c " . outputFile
    run, %cmdToRun%
    Sleep, 8000
    ; remove temporary file
    if (FileExist(outputFile))
        FileDelete, %outputFile%

    Sleep, 3000
    Send, {CtrlDown}{Down}{CtrlUp}{Down}
}
if fofname Contains ???
{
    fofname = N/A
    Sleep, 200
    Send, {Raw}%fofname%
    Sleep, 250
} else {
    Sleep, 200
    Send, {Raw}%fofname%
    Sleep, 250
}
if fofxboxGT contains ???
{
    fofxboxGT = N/A
    Send, {Right}
    Sleep, 200
    Send, {Raw}%fofxboxGT%
    Sleep, 250
} else {
    Send, {Right}
    Sleep, 200
    Send, {Raw}%fofxboxGT%
    Sleep, 250
}
if fofuserID contains ???
{
    fofuserID = N/A
    Send, {Right}
    Sleep, 200
    Send, {Raw}%fofuserID%
    Sleep, 250
} else {
    Send, {Right}
    Sleep, 200
    Send, {Raw}%fofuserID%
    Sleep, 250
}
Send, {Right}
Sleep, 200
Send, Fortune
Sleep, 200
Send, {right}
if fofreason contains ???
{
    fofreason = N/A
    Sleep, 200
    Send, {Raw}%fofreason%
    Sleep, 250
} else {
    Sleep, 200
    Send, {Raw}%fofreason%
    Sleep, 250
    Send, {Right}
}

Goto, start
return

#x::
GuiClose:
GuiEscape:
ExitApp
Return
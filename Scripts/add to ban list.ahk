#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

MsgBox, 0, In case of unexpected behaviour, Press Windows+X if the program shows unexpected behaviour like opening up different programs

start:

; Variables

tutorial =
(
ddfgdsdassdkjhgggggggggggggggggggggggggggggggggggggggggg
df
sdf
sd
fs
ds
)
count = 0
reqcount = 0
fofcount = 0
loopCount = 0

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
{
    count++
}
if not (xboxGT == "")
{
    count++
}
if not (userID == "")
{
    count++
}
if not (reason == "")
{
    count++
}
if not (name == "")
{
    count++
}
if not (timezone == "")
{
    count++
}
if not (reqban == "")
{
    reqcount++
}
if not (fofname == "")
{
   fofcount++
}
if not (fofxboxGT == "")
{
    fofcount++
}
if not (fofuserID == "")
{
    fofcount++
}
if not (fofreason == "")
{
    fofcount++
}
OutputDebug, count %count%
OutputDebug, reqcount %reqcount%
OutputDebug, fofcount %fofcount%


OutputDebug, Determining behaviour

Gui, Destroy
if (count == 6 and reqcount == 0 and fofcount == 0)
{
    MsgBox, Ashen
    Goto ashen
}
else if (count == 0 and reqcount == 1 and fofcount == 0)
{
    MsgBox, Requiem
    Goto requiem
}
else if (count == 0 and reqcount == 0 and fofcount == 4)
{
    MsgBox, FoF
    Goto fof
}
Else
{
    MsgBox, Invalid amount of arguments entered, please try again
    Goto start
}
Return

ashen:

; Add ashen ban

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

Goto, start
Return
requiem:

; Add requiem ban to shared list

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

Loop, parse, reqban, -
{
    Sleep, 150
    ban := Trim(A_LoopField)
    OutputDebug, %ban%
    loopCount++
    OutputDebug, Current loopcount = %loopCount%
    if (loopCount == 1){
        if A_LoopField Contains ???
        {
            ban = N/A
            Send, {Right}
            Sleep, 200
            Send, {Raw}%ban%
            Sleep, 250
        } else {
            gamertag := SubStr(ban, 4)
            gamertag := Trim(gamertag)
            OutputDebug, %gamertag%
            Send, {Right}
            Sleep, 200
            Send, {Raw}%gamertag%
            Sleep, 250
        }
    } else if (loopCount == 2){
        if A_LoopField Contains	???
        {
            ban = N/A
            Send, {Right}
            Sleep, 200
            Send, {Raw}%ban%
            Sleep, 250
        } else {
            Send, {Right}
            Sleep, 200
            Send, {Raw}%ban%
            Sleep, 250
        }
    } else if (loopCount == 3){
        if A_LoopField Contains ???
        {
            ban = N/A
            Send, {Left}
            Sleep, 200
            Send, {Left}
            Sleep, 200
            Send, {Raw}%ban%
            Sleep, 250
            Send, {Right}
            Sleep, 300
            Send, {Right}
            Sleep, 300
            Send, {Right}
            Sleep, 300
            Send, Requiem
            Sleep, 250
        } else {
            Send, {Left}
            Sleep, 200
            Send, {Left}
            Sleep, 200
            Send, {Raw}%ban%
            Sleep, 250
            Send, {Right}
            Sleep, 300
            Send, {Right}
            Sleep, 300
            Send, {Right}
            Sleep, 300
            Send, Requiem
            Sleep, 250
        }
    } else if (loopCount == 4){
        if A_LoopField Contains ???
        {
            ban = N/A
            Send, {Right}
            Sleep, 200
            Send, {Raw}%ban%
            Sleep, 500
        } else {
            Send, {Right}
            Sleep, 200
            Send, {Raw}%ban%
            Sleep, 500         
        }
    }
}

Goto, start
Return
fof:

; Add fof ban to shared list

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
    Send, {Right}
    Sleep, 200
    Send, {Raw}%fofreason%
    Sleep, 250
} else {
    Send, {Right}
    Sleep, 200
    Send, {Raw}%fofreason%
    Sleep, 250
}

Goto, start
GuiClose:
GuiEscape:
ExitApp
Return
#x::ExitApp

Return
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

MsgBox, 0, In case of unexpected behaviour, Press Windows+X if the program shows unexpected behaviour like opening up different programs

; Variables

url := "https://docs.google.com/spreadsheets/d/1V5Z61CKmJoNZn7L3PWziJdbHRVzYuxaZU4qTOIRHfWg/edit#gid=125271616"
loopCount = 0

MsgBox, 4, Requiem ban?, Press YES if this ban is from Requiem.
IfMsgBox, Yes
{
    InputBox, reqban, ban message, Please enter the entire entry as written in AoA, , , 125
} Else IfMsgBox, No
{
    inputBox, usertag, Usertag of FoF ban, Please enter the user#tag from the FoF ban. ex Max#0001, , ,125
    inputBox, gamertag, Usergt of FoF ban, Please enter the user's gamertag from the FoF ban, , ,125
    inputBox, userID, UserID of FoF ban, Please enter the userID from the FoF ban, , ,125
    inputBox, reason, reason of FoF ban, Please enter the reason from the FoF ban, , ,125
}

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

Sleep, 1500
Send, {CtrlDown}{Down}{CtrlUp}{Down}

; Requiem ban

IfMsgBox, Yes
{
    Loop, parse, reqban, -
    {
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
                    Sleep, 100
                    Send, {Raw}%ban%
                    Sleep, 175
                } else {
                    gamertag := SubStr(ban, 4)
                    gamertag := Trim(gamertag)
                    OutputDebug, %gamertag%
                    Send, {Right}
                    Sleep, 100
                    Send, {Raw}%gamertag%
                    Sleep, 175
                }
            } else if (loopCount == 2){
                if A_LoopField Contains	???
                {
                    ban = N/A
                    Send, {Right}
                    Sleep, 100
                    Send, {Raw}%ban%
                    Sleep, 175
                } else {
                    Send, {Right}
                    Sleep, 100
                    Send, {Raw}%ban%
                    Sleep, 175
                }
            } else if (loopCount == 3){
                if A_LoopField Contains ???
                {
                    ban = N/A
                    Send, {Left}
                    Sleep, 100
                    Send, {Left}
                    Sleep, 100
                    Send, {Raw}%ban%
                    Sleep, 175
                    Send, {Right}
                    Sleep, 150
                    Send, {Right}
                    Sleep, 150
                    Send, {Right}
                    Sleep, 150
                    Send, Requiem
                    Sleep, 125
                } else {
                    Send, {Left}
                    Sleep, 100
                    Send, {Left}
                    Sleep, 100
                    Send, {Raw}%ban%
                    Sleep, 175
                    Send, {Right}
                    Sleep, 150
                    Send, {Right}
                    Sleep, 150
                    Send, {Right}
                    Sleep, 150
                    Send, Requiem
                    Sleep, 125
                }
            } else if (loopCount == 4){
                if A_LoopField Contains ???
                {
                    ban = N/A
                    Send, {Right}
                    Sleep, 100
                    Send, {Raw}%ban%
                    Sleep, 250
                } else {
                    Send, {Right}
                    Sleep, 100
                    Send, {Raw}%ban%
                    Sleep, 250           
                }

            }
        }
    }
    
} 
IfMsgBox, No
{
    if usertag Contains ???
    {
        usertag = N/A
        Sleep, 100
        Send, {Raw}%usertag%
        Sleep, 175
    } else {
        Sleep, 100
        Send, {Raw}%usertag%
        Sleep, 175
    }
    if gamertag contains ???
    {
        gamertag = N/A
        Send, {Right}
        Sleep, 100
        Send, {Raw}%gamertag%
        Sleep, 175
    } else {
        Send, {Right}
        Sleep, 100
        Send, {Raw}%gamertag%
        Sleep, 175
    }
    if userID contains ???
    {
        userID = N/A
        Send, {Right}
        Sleep, 100
        Send, {Raw}%userID%
        Sleep, 175
    } else {
        Send, {Right}
        Sleep, 100
        Send, {Raw}%userID%
        Sleep, 175
    }
    Send, {Right}
    Sleep, 100
    Send, Fortune
    Sleep, 100
    Send, {right}
    if reason contains ???
    {
        reason = N/A
        Send, {Right}
        Sleep, 100
        Send, {Raw}%reason%
        Sleep, 175
    } else {
        Send, {Right}
        Sleep, 100
        Send, {Raw}%reason%
        Sleep, 175
    }
}

ExitApp
Return
#x::ExitApp
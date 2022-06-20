#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

; Variables


url := "https://docs.google.com/spreadsheets/d/1V5Z61CKmJoNZn7L3PWziJdbHRVzYuxaZU4qTOIRHfWg/edit#gid=125271616"

MsgBox, 4, Requiem ban?, Press YES if this ban is from Requiem.
IfMsgBox, Yes
{
    InputBox, reqban, ban message, Please enter the full ban message from AoA, , , 125
} Else IfMsgBox, No
{
    inputBox, usertag, Usertag of FoF ban, Please enter the user#tag from the FoF ban. ex Max#0001, , ,125
    inputBox, userGT, Usergt of FoF ban, Please enter the user's gamertag from the FoF ban, , ,125
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

sleep,5000

; remove temporary file
if (FileExist(outputFile))
    FileDelete, %outputFile%

Sleep, 1500
Send, {CtrlDown}{Down}{CtrlUp}{Down}

IfMsgBox, Yes
{
    MsgBox, test
} else IfMsgBox, No
{
    MsgBox, Test
}

ExitApp
Return
#x::ExitApp
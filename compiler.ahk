#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

IniRead, version, Scripts\settings.ini, settings, version

Run, "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe" /in "Scripts\customization.ahk" /out Executables\customization_%version%.exe
Run, "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe" /in "Scripts\goodtocheck.ahk" /out Executables\goodtocheck_%version%.exe
Run, "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe" /in "Scripts\mass add notes.ahk" /out Executables\mass_add_notes_%version%.exe
Run, "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe" /in "Scripts\mass add warnings.ahk" /out Executables\mass_add_warnings_%version%.exe
Run, "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe" /in "Scripts\staffcheck.ahk" /out Executables\staffcheck_%version%.exe"
FileCopy, Scripts\staffcheck.ini, Executables\
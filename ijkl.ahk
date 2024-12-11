; Starting the script as admin, so it can be used in applications with elevated permissions (Like the Task Manager).
full_command_line := DllCall("GetCommandLine", "str")

if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try
    {
        if A_IsCompiled
            Run '*RunAs "' A_ScriptFullPath '" /restart'
        else
            Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"'
    }
    ExitApp
}

MsgBox "Running as admin: " A_IsAdmin

; Navigation mappings
CAPSLOCK & j::MoveCursor("{LEFT}")
CAPSLOCK & l::MoveCursor("{RIGHT}")
CAPSLOCK & i::MoveCursor("{UP}")
CAPSLOCK & k::MoveCursor("{DOWN}")
CAPSLOCK & u::MoveCursor("{HOME}")
CAPSLOCK & o::MoveCursor("{END}")
CAPSLOCK & BACKSPACE::Send("{DELETE}")

MoveCursor(key) {
    modKeys := Map(
        "SHIFT", "+",
        "CONTROL", "^",
        "ALT", "!",
        "LWin", "#"
    )

    prefixString := ""

    for name, prefix IN modKeys {
        if GetKeyState(name, "P") {
            prefixString := prefixString . prefix
        }
    }

    send(prefixString . key)
}
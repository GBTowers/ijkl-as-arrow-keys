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

; Caps remaps
*CapsLock::CapsDoubleTap(), KeyWait('CapsLock')

; Navigation mappings
#HotIf GetKeyState('CapsLock', 'P')

*i::Up
*j::Left
*k::Down
*l::Right

*f::LWin
*d::Shift
*c::Control
*.::Escape
*u::Home
*o::End

*`;::BackSpace
*'::Delete

; Virtual Desktop navigation
*w::#^Left
*e::#^Right
#HotIf

class CapsDoubleTap {
    static __New() => SetCapsLockState('AlwaysOff')
    
    static call() {
        static last := 0
        if (A_TickCount - last < 250)
            last := 0
            ,this.ToggleCapsLock()
        else last := A_TickCount
    }
    
    static ToggleCapsLock() {
        state := GetKeyState('CapsLock', 'T') ? 'Off' : 'On'
        ,SetCapsLockState('Always' state)
    }
}
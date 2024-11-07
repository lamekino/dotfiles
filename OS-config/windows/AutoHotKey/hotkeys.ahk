#NoEnv
#SingleInstance force
#KeyHistory 0

;; The Best
CapsLock::Ctrl

;; Functions
; Toggles the active window between maximized and restored
; http://xahlee.info/mswin/autohotkey_toggle_maximize_window.html
ToggleMaximize() {
    WinGet, WinState, MinMax, A
    if (WinState = 1) {
        WinRestore, A
    }
    else {
        WinMaximize, A
    }
    return
}

; Opens a wider volume mixer
VolumeMixerWide() {
    if not WinExist("ahk_exe SndVol.exe") {
        Run, SndVol.exe,, Max
        ; Fix it being behind the taskbar
        WinWait, ahk_exe SndVol.exe
        ControlFocus ahk_exe SndVol.exe
        WinSet, Transparent, 245
        WinSet, Style, -0xC00000, A
        WinSet, AlwaysOnTop
    }
    else {
        WinClose ahk_exe SndVol.exe
    }
    return
}

;; OS
; Restart explorer
^!Backspace::
    Runwait TASKKILL /F /IM explorer.exe
    Run explorer.exe
return

; Reload this script
^!r::
    Reload
    TrayTip %A_ScriptFullPath%, Script Reloaded, 3, 16
return

; Suspend all hotkeys
^!s::
    Suspend, Toggle
    TrayTip %A_ScriptFullPath%, Hotkeys toggled, 3, 16
return

; Shutdown wsl
^!F12::Run wsl --shutdown --all

;; Window Management
; Minimize Window
#h::WinMinimize, A

; Toggle titlebar
^!Enter::WinSet, Style, ^0xC00000, A

; Toggle maximize
#f::ToggleMaximize()

; Switch Desktop Right
#PgDn::SendInput #^{Right}

; Switch Desktop Left
#PgUp::SendInput #^{Left}

;; Spawn Processes
; Open Volume Mixer
#;::VolumeMixerWide()

;; Per-Program Keybinds
; Windows Fax and Scan Keybinds
#IfWinActive ahk_exe wfs.exe
; Create a new scan in Windows Fax and Scan
^s::
    Send !f ; File
    Send n  ; New
    Send s  ; Scan
    WinWait, New Scan ; Wait for the scan window to come up
    Send !s ; Press scan button
return
#IfWinActive

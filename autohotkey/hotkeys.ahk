#NoEnv
#SingleInstance force
;#KeyHistory 0
; +--------------------------------------------------------------------------+ ;
; |                                  MAIN.AHK                                | ;
; +--------------------------------------------------------------------------+ ;

CapsLock::Ctrl
; Global Vim binds {{{
^!=::AdjustScreenBrightness(15)
^!-::AdjustScreenBrightness(-15)
^!.::SoundSet +3
^!,::SoundSet -5

^!h::SendInput {Left}
^!j::SendInput {Down}
^!k::SendInput {Up}
^!l::SendInput {Right}

^!u::SendInput {PgUp}
^!d::SendInput {PgDn}
^!g::SendInput {Home}
^!+g::SendInput {End}
; }}}
; OS Stuff: {{{
; disable annoying shit
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

; Toggle titlebar
^!Enter::WinSet, Style, ^0xC00000, A

; Run xkill
;#+c::Run C:\Utils\bin\xkill.exe

; Shutdown wsl
^!F12::Run wsl --shutdown --all

; Better alt-f4
#q::WinKill, A
; }}}
; Fullsize keybinds {{{
; https://gist.github.com/krrr/3c3f1747480189dbb71f
AdjustScreenBrightness(step) {
    service := "winmgmts:{impersonationLevel=impersonate}!\\.\root\WMI"
    monitors := ComObjGet(service).ExecQuery("SELECT * FROM WmiMonitorBrightness WHERE Active=TRUE")
    monMethods := ComObjGet(service).ExecQuery("SELECT * FROM wmiMonitorBrightNessMethods WHERE Active=TRUE")
    minBrightness := 5  ; level below this is identical to this

    for i in monitors {
        curt := i.CurrentBrightness
        break
    }
    if (curt < minBrightness) { ; parenthesis is necessary here
        curt := minBrightness
    }
    toSet := curt + step
    if (toSet > 100) {
        return
    }
    if (toSet < minBrightness) {
        toSet := minBrightness
    }

    for i in monMethods {
        i.WmiSetBrightness(1, toSet)
        break
    }
}
; Media key, use mneu
ScrollLock::Media_Play_Pause
PrintScreen::Media_Prev
Pause::Media_Next
; }}}
; Navigation: {{{
; Minimize window like GNOME, macOS
#h::WinMinimize, A

; Toggle maximize
#f::
    ; http://xahlee.info/mswin/autohotkey_toggle_maximize_window.html
    WinGet, WinState, MinMax, A
    if (WinState = 1) {
        WinRestore, A
    }
    else {
        WinMaximize, A
    }
return
; }}}
; Workspaces {{{
; Switch Desktop Right
#WheelDown::SendInput #^{Right}
#j::SendInput #^{Right}

; Switch Desktop Left
#WheelUp::SendInput #^{Left}
#k::SendInput #^{Left}
; }}}
; Sound Settings: {{{
; Open Volume Mixer
#;::
    if not WinExist("ahk_exe SndVol.exe") {
        Run, SndVol.exe,, Max
        ; Fix it being behind the taskbar
        WinWait, ahk_exe SndVol.exe
        ControlFocus ahk_exe SndVol.exe
        ;WinSet, Transparent, 220
        WinSet, Style, -0xC00000, A
        WinSet, AlwaysOnTop
    }
    else {
        WinClose ahk_exe SndVol.exe
    }
return
; }}}
; No focused window (on desktop) {{{
; if no window is active https://stackoverflow.com/a/61764476
; FIXME: this is kinda broken
#IfWinActive ahk_exe explorer.exe
; Toggle Desktop icons https://gist.github.com/digitalfun/3a605ff889c7e7db5281
!a::
    ControlGet, HWND, Hwnd,, SysListView321, ahk_class Progman
    if HWND =
        ControlGet, HWND, Hwnd,, SysListView321, ahk_class WorkerW

    if DllCall("IsWindowVisible", UInt, HWND) {
        WinHide, ahk_id %HWND%
    }
    else {
        WinShow, ahk_id %HWND%
    }
return
#IfWinNotActive
; }}}
; Windows Terminal: {{{
#IfWinActive ahk_exe WindowsTerminal.exe
; Enable the window's transparency and toggle the titlebar
!F12::
    WinSet, Style, ^0xC00000, A
    WinSet, Transparent, 245, A
return
#IfWinActive
; }}}
; Windows Fax and Scan: {{{
; Create a new scan in Windows Fax and Scan
#IfWinActive ahk_exe wfs.exe
^s::
    Send !f ; File
    Send n  ; New
    Send s  ; Scan
    WinWait, New Scan ; Wait for the scan window to come up
    Send !s ; Press scan button
return
#IfWinActive
; }}}
; vim:foldmethod=marker

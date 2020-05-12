#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#InstallKeybdHook
#UseHook

; The following line is a contribution of NTEmacs wiki http://www49.atwiki.jp/ntemacs/pages/20.html
SetKeyDelay 0

is_windows_terminal()
{
    Return WinActive("ahk_class CASCADIA_HOSTING_WINDOW_CLASS")
}


#Include alt-ime-ahk\alt-ime-ahk.ahk

;; Relaod script by C-s. When you are editing this file on an editor, AHK will reload this script when you type C-s.
;; `~` means, do not prevent default actions.
~^s::
    ScriptName := "tokuhirom.ahk"
    IfWinActive, %ScriptName%
    {
        MsgBox 0, Reloaded, Reloaeded tokuhirom.ahk, 1
        Send {AltDown}{Tab}{AltUp}}
        Reload
    }
return

;; Basic emacs-like cursor operation
#If !(WinActive("ahk_exe RLogin.exe") or is_windows_terminal())

    ^p::Send {Up}
    ^n::Send {Down}
    ^b::Send {Left}
    ^f::Send {Right}
    ^h::Send {BS}
    ^a::Send {HOME}
    ^e::Send {END}

    ^k::
        Send {ShiftDown}{END}{SHIFTUP}
        Sleep 50 ;[ms] this value depends on your environment
        Send ^x
        Return

#If

;; Remap C-d to DEL. But run debugger on IDEA.
#If !(WinActive("ahk_exe idea64.exe") or is_windows_terminal())
    ^d::Send {Del}
#If

; Disable Ins key
Insert::Return

;; Mac like keybinding
;; M-a as "Select all"
    !a::^a
    !c::^c
    !x::^x
    !v::^v
    !z::^z

; chrome sets C-f as find in browser
; but IDEA wants Alt-F3 as a find in text
;#IFWinActive, ahk_exe idea64.exe
;!f::
;    send {Alt down}{F3}{Alt up}
;    Return
;#IfWinActive
#IfWinNotActive, ahk_exe idea64.exe
    !f::Send ^f
#IfWinNotActive

; on visual studio code, M-p should work as command pallet.
#IFWinActive, ahk_exe Code.exe
    !p::Send ^p
#IfWinActive

; ! = Alt
; ^ = Ctrl
; # = win key
; + = shift
; ~ = Do not prevent default behaivour

﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

~^s::
    ScriptName := "tokuhirom.ahk"
    IfWinActive, %ScriptName%
    {
        Reload
    }
return


; Dislabe Ins key
Insert::Return

;; Mac like keybinding
;; M-a as "Select all"
!a::
    Send ^a
    Return
!c::
    Send ^c
    Return
!x::
    Send ^x
    Return
!v::
    Send ^v
    Return

; !n::
;     Send ^n
;    Return

!z::
    Send ^z
    Return

; chrome sets C-f as find in browser
; but IDEA wants Alt-F3 as a find in text
#IFWinActive, ahk_exe idea64.exe
!f::
    send {Alt down}{F3}{Alt up}
    Return
#IfWinActive
#IfWinNotActive, ahk_exe idea64.exe
!f::
    send ^f
    Return
#IfWinNotActive

; on visual studio code, M-p should work as command pallet.
#IFWinActive, ahk_exe Code.exe
!p::
    Send ^P
    Return
#IfWinActive

; ! = Alt
; ^ = Ctrl
; # = win key
; + = shift

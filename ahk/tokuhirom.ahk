#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

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
!n::
    Send ^n
    Return
!f::
    Send ^f
    Return

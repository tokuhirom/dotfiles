#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Emacs like shortcuts
; https://github.com/usi3/emacs.ahk/blob/master/emacs.ahk
^a::

^!t::Run, %windir%\system32\cmd.exe

; Dislabe Ins key
Insert::Return


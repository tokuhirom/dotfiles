;;
;; An autohotkey script that provides emacs-like keybinding on Windows
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEPRECATED FILE. USE tokuhirom.ahk instead.
;;;;;;;;;;;;;;



























#InstallKeybdHook
#UseHook

SetKeyDelay 0

;; Relaod script by C-s
;; `~` means, do not prevent default actions.
~^s::
    ScriptName := "emacs.ahk"
    IfWinActive, %ScriptName%
    {
        MsgBox 0, Reloaded, Reloaeded emacs.ahk, 1
        Send {AltDown}{Tab}{AltUp}}
        Reload
    }
return

is_windows_terminal()
{
    Return WinActive("ahk_class CASCADIA_HOSTING_WINDOW_CLASS")
}

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

;;
;; An autohotkey script that provides emacs-like keybinding on Windows
;;
#InstallKeybdHook
#UseHook

; The following line is a contribution of NTEmacs wiki http://www49.atwiki.jp/ntemacs/pages/20.html
SetKeyDelay 0

; turns to be 1 when ctrl-x is pressed
is_pre_x = 0

; Applications you want to disable emacs-like keybindings
; (Please comment out applications you don't use)
is_target_c_d()
{
  IfWinActive,ahk_class CASCADIA_HOSTING_WINDOW_CLASS ; Windows Terminal
    Return 1
  Return 0
}
is_target()
{
  IfWinActive,ahk_exe RLogin.exe
    Return 1
  Return 0
}

kill_line()
{
  Send {ShiftDown}{END}{SHIFTUP}
  Sleep 50 ;[ms] this value depends on your environment
  Send ^x
  Return
}
yank()
{
  Send ^v
  Return
}
undo()
{
  Send ^z
  Return
}

move_end_of_line()
{
  Send {END}
}
previous_line()
{
  Send {Up}
}
next_line()
{
  global
  if is_pre_spc
    Send +{Down}
  Else
    Send {Down}
  Return
}
forward_char()
{
  global
  if is_pre_spc
    Send +{Right}
  Else
    Send {Right}
  Return
}
backward_char()
{
  global
  if is_pre_spc
    Send +{Left}
  Else
    Send {Left}
  Return
}
scroll_up()
{
  global
  if is_pre_spc
    Send +{PgUp}
  Else
    Send {PgUp}
  Return
}
scroll_down()
{
  global
  if is_pre_spc
    Send +{PgDn}
  Else
    Send {PgDn}
  Return
}


^f::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
      forward_char()
  }
  Return

;; Run debugger on IDEA.
#IfWinNotActive, ahk_exe idea64.exe
^d::
  If is_target_c_d()
    Send %A_ThisHotkey%
  Else
    Send {Del}
  Return
#IfWinNotActive

^h::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send {BS}
  Return

^k::
  kill_line()
  Return

^y::
  If is_target()
    Send %A_ThisHotkey%
  Else
    yank()
  Return
^/::
  If is_target()
    Send %A_ThisHotkey%
  Else
    undo()
  Return

^a::
  Send {HOME}
  Return

^e::
  If is_target()
    Send %A_ThisHotkey%
  Else
    move_end_of_line()
  Return

^p::
  If is_target()
    Send %A_ThisHotkey%
  Else
    previous_line()
  Return

^n::
  If is_target()
    Send %A_ThisHotkey%
  Else
    next_line()
  Return

^b::
  If is_target()
    Send %A_ThisHotkey%
  Else
    backward_char()
  Return


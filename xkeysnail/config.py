from xkeysnail.transform import *
import re

# User management:
#
#    https://qiita.com/miy4/items/dd0e2aec388138f803c5

# https://github.com/mooz/xkeysnail

# Logitech G915 TKL の設定は、キーコードそのものをつかむ必要があるので、
# xbindkeys も併用している。

# CapsLockキー
#  Ctrl キーに。
define_modmap({
    Key.CAPSLOCK: Key.LEFT_CTRL
})

#   変換キー
#    単体で押すと変換、修飾キーとして使うとAlt
#   無変換キー
#    単体で押すと無変換、修飾キーとして使うとAlt
define_multipurpose_modmap({
    Key.LEFT_ALT:  [Key.MUHENKAN, Key.LEFT_ALT],
    Key.RIGHT_ALT: [Key.HENKAN,   Key.RIGHT_ALT]
})

define_keymap(re.compile("Firefox|Google-chrome"), {
    # Ctrl+Alt+j/k to switch next/previous tab
    # S-M-}
    K("Shift-M-RIGHT_BRACE"): K("C-TAB"),
    # S-M-[
    K("Shift-M-LEFT_BRACE"): K("C-Shift-TAB"),
    # M-l to location bar
    K("M-l"): K("C-l"),
    # M-f to find in page
    K("M-f"): K("C-f"),
}, "Firefox and Chrome")


define_keymap(lambda wm_class: wm_class not in ("Terminator", 'jetbrains-idea'), {
    K("C-a"): K("HOME"),
    K("C-e"): K("END"),

    K("M-c"): K("C-c"),
    K("M-x"): K("C-x"),
    K("M-v"): K("C-v"),

    K("C-f"): K("RIGHT"),
    K("C-b"): K("LEFT"),
    K("C-p"): K("UP"),
    K("C-n"): K("DOWN"),

    K("M-n"): K("C-n"),
}, "Not Terminator")




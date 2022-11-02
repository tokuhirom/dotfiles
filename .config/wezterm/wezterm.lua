local wezterm = require 'wezterm';

return {
  -- font = wezterm.font("Cica"), -- 自分の好きなフォントいれる
  use_ime = true,
  font_size = 14.0,
  -- https://wezfurlong.org/wezterm/colorschemes/index.html
  color_scheme = "OneHalfDark",
  -- hide_tab_bar_if_only_one_tab = true,
  -- adjust_window_size_when_changing_font_size = false,

  -- show underline for link
  -- https://github.com/wez/wezterm/issues/2496
  -- but it's not working until next release, it may release Nov 2022.
  selection_word_boundary = " \t\n{}[]()<>\"'`,;:=",
  mouse_bindings = {
    -- Default behavior is to follow open links. Disable, just select text.
    {event={Up={streak=1, button="Left"}}, mods="NONE", action=wezterm.action.CompleteSelection("PrimarySelection")},
    -- and make CTRL-Click open hyperlinks (even when mouse reporting)
    {event={Up={streak=1, button="Left"}}, mods="CTRL", action="OpenLinkAtMouseCursor", mouse_reporting=true},
    {event={Up={streak=1, button="Left"}}, mods="CTRL", action="OpenLinkAtMouseCursor"},
    -- Since we capture the 'Up' event, Disable 'Down' of ctrl-click to avoid programs from receiving it
    {event={Down={streak=1, button="Left"}}, mods="CTRL", action="Nop", mouse_reporting=true},
  },

}


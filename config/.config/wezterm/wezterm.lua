local wezterm = require 'wezterm';

return {
    -- font = wezterm.font("Cica"), -- 自分の好きなフォントいれる
    font = wezterm.font('HackGen Console NF'),
    use_ime = true,
    font_size = 14.0,
    -- https://wezfurlong.org/wezterm/colorschemes/index.html
    color_scheme = "OneHalfDark",
    -- hide_tab_bar_if_only_one_tab = true,
    -- adjust_window_size_when_changing_font_size = false,

    window_frame = {
        font_size = 16.0,
    },

    keys = {
        {
            key = 'C',
            mods = 'ALT',
            action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
        },
        {
            key = 'C',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
        },
        {
            key = 'V',
            mods = 'ALT',
            action = wezterm.action.PasteFrom 'Clipboard',
        },
        {
            key = 'V',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.PasteFrom 'Clipboard',
        },
        -- Copy Mode (vim-like selection)
        {
            key = '[',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.ActivateCopyMode,
        },
        -- QuickSelect (highlight and select text patterns)
        {
            key = 'Space',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.QuickSelect,
        },
    },

    -- QuickSelect patterns (URLs, paths, hashes, etc.)
    quick_select_patterns = {
        -- Git short hash
        '[0-9a-f]{7,40}',
        -- IPv4
        '\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}',
    },

    -- show underline for link
    -- https://github.com/wez/wezterm/issues/2496
    -- but it's not working until next release, it may release Nov 2022.
--  selection_word_boundary = " \t\n{}[]()<>\"'`,;:=",
--  mouse_bindings = {
--      -- Default behavior is to follow open links. Disable, just select text.
--      {event={Up={streak=1, button="Left"}}, mods="NONE", action=wezterm.action.CompleteSelection("PrimarySelection")},
--      -- and make CTRL-Click open hyperlinks (even when mouse reporting)
--      {event={Up={streak=1, button="Left"}}, mods="CTRL", action="OpenLinkAtMouseCursor", mouse_reporting=true},
--      {event={Up={streak=1, button="Left"}}, mods="CTRL", action="OpenLinkAtMouseCursor"},
--      -- Since we capture the 'Up' event, Disable 'Down' of ctrl-click to avoid programs from receiving it
--      {event={Down={streak=1, button="Left"}}, mods="CTRL", action="Nop", mouse_reporting=true},
--  },

}


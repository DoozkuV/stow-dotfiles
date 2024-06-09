local wezterm = require("wezterm")
local act = wezterm.action

local module = {}

local leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 2500 }
local keybinds = {
    -- Command Palette
    {
        key = 'P',
        mods = 'CTRL|SHIFT',
        action = act.ActivateCommandPalette,
    },

    -- Pane Manipulation
    {
        key = 'v',
        mods = 'LEADER',
        action = act.SplitPane {
            direction = 'Left',
            size = { Percent = 50 },
        }
    },
    {
        key = 's',
        mods = 'LEADER',
        action = act.SplitVertical {},
    },
    {
        key = 'c',
        mods = 'LEADER',
        action = act.CloseCurrentPane { confirm = false },
    },
    {
        key = 'z',
        mods = 'LEADER',
        action = wezterm.action.TogglePaneZoomState,
    },

    -- Copying and Pasting
    {
        key = 'c',
        mods = 'CTRL|SHIFT',
        action = act.CopyTo 'Clipboard'
    },
    {
        key = 'v',
        mods = 'CTRL|SHIFT',
        action = act.PasteFrom 'Clipboard'
    },




    -- Scrollback Binds
    { key = 'k', mods = 'ALT', action = act.ScrollByLine(1) },
    { key = 'j', mods = 'ALT', action = act.ScrollByLine(-1) },

    { key = 'u', mods = 'ALT', action = act.ScrollByPage(0.5) },
    { key = 'd', mods = 'ALT', action = act.ScrollByPage(-0.5) },

    -- Search
    -- {
    --         key = '/',
    --         mods = 'LEADER',
    --         action = act.Search
    --     }
}

function module.apply_to_config(config)
    config.disable_default_key_bindings = true
    config.leader = leader
    config.keys = keybinds
end

return module

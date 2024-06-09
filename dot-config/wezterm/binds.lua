local wezterm = require("wezterm")
local act = wezterm.action

local module = {}

local leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 2500 }
local LDR = 'LEADER' -- convenience constant
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
        mods = LDR,
        action = act.SplitPane {
            direction = 'Left',
            size = { Percent = 50 },
        }
    },
    {
        key = 's',
        mods = LDR,
        action = act.SplitVertical {},
    },
    {
        key = 'c',
        mods = LDR,
        action = act.CloseCurrentPane { confirm = false },
    },
    {
        key = 'z',
        mods = LDR,
        action = wezterm.action.TogglePaneZoomState,
    },

    -- Pane Direction
    { key = 'h', mods = LDR,    action = act.ActivatePaneDirection 'Left', },
    { key = 'h', mods = "CTRL", action = act.ActivatePaneDirection 'Left', },
    { key = 'l', mods = LDR,    action = act.ActivatePaneDirection 'Right', },
    { key = 'l', mods = "CTRL", action = act.ActivatePaneDirection 'Right', },
    { key = 'k', mods = LDR,    action = act.ActivatePaneDirection 'Up', },
    { key = 'k', mods = "CTRL", action = act.ActivatePaneDirection 'Up', },
    { key = 'j', mods = LDR,    action = act.ActivatePaneDirection 'Down', },
    { key = 'j', mods = "CTRL", action = act.ActivatePaneDirection 'Down', },

    -- Tab Manipulation
    {
        key = 't',
        mods = LDR,
        action = act.SpawnTab 'CurrentPaneDomain',
    },
    {
        key = 'x',
        mods = LDR,
        action = act.CloseCurrentTab { confirm = true },
    },
    { key = 'h', mods = 'META|SHIFT', action = act.ActivateTabRelative(-1) },
    { key = 'l', mods = 'META|SHIFT', action = act.ActivateTabRelative(1) },



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
    { key = 'k', mods = 'META',       action = act.ScrollByLine(-1) },
    { key = 'j', mods = 'META',       action = act.ScrollByLine(1) },

    { key = 'u', mods = 'META',       action = act.ScrollByPage(-0.5) },
    { key = 'd', mods = 'META',       action = act.ScrollByPage(0.5) },
    { key = 'g', mods = 'SHIFT|META', action = act.ScrollToTop },


    -- Search
    -- {
    --         key = '/',
    --         mods = LDR,
    --         action = act.Search
    --     }
}

function module.apply_to_config(config)
    config.disable_default_key_bindings = true
    config.leader = leader
    config.keys = keybinds
end

return module

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
    { key = 'h', mods = LDR, action = act.ActivatePaneDirection 'Left', },
    -- { key = 'h', mods = "CTRL|SHIFT", action = act.ActivatePaneDirection 'Left', },
    { key = 'l', mods = LDR, action = act.ActivatePaneDirection 'Right', },
    -- { key = 'l', mods = "CTRL|SHIFT", action = act.ActivatePaneDirection 'Right', },
    { key = 'k', mods = LDR, action = act.ActivatePaneDirection 'Up', },
    -- { key = 'k', mods = "CTRL|SHIFT", action = act.ActivatePaneDirection 'Up', },
    { key = 'j', mods = LDR, action = act.ActivatePaneDirection 'Down', },
    -- { key = 'j', mods = "CTRL|SHIFT", action = act.ActivatePaneDirection 'Down', },

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
    { key = 'h',   mods = 'META|SHIFT', action = act.ActivateTabRelative(-1) },
    { key = 'l',   mods = 'META|SHIFT', action = act.ActivateTabRelative(1) },

    -- Copying and Pasting
    { key = 'c',   mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
    { key = 'v',   mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },

    -- Scrollback Binds
    { key = 'k',   mods = 'META',       action = act.ScrollByLine(-1) },
    { key = 'j',   mods = 'META',       action = act.ScrollByLine(1) },

    { key = 'u',   mods = 'META',       action = act.ScrollByPage(-0.5) },
    { key = 'd',   mods = 'META',       action = act.ScrollByPage(0.5) },
    { key = 'g',   mods = 'SHIFT|META', action = act.ScrollToTop },


    -- Search
    -- {
    --         key = '/',
    --         mods = LDR,
    --         action = act.Search
    --     }

    -- Full-screen
    { key = 'F11', mods = '',           action = act.ToggleFullScreen },

    -- Toggling opacity
    {
        key = 'o',
        mods = LDR,
        action = wezterm.action_callback(function(win, pane)
            local overrides = win:get_config_overrides() or {}
            if not overrides.window_background_opacity then
                -- If no override is setup, override opacity value with 1.0
                overrides.window_background_opacity = 1.0
            else
                -- make override go back to default
                overrides.window_background_opacity = nil
            end
            win:set_config_overrides(overrides)
        end),
    },
}

function module.apply_to_config(config)
    config.disable_default_key_bindings = true
    config.leader = leader
    config.keys = keybinds
    local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim', {
        direction_keys = { 'h', 'j', 'k', 'l' },
        modifiers = {
            move = 'CTRL',
            resize = 'META',
        }
    })
    smart_splits.apply_to_config(config)
    -- Setup smart splits
end

return module

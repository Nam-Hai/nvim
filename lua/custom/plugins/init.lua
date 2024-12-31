-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require 'lualine'
    local lazy_status = require 'lazy.status' -- to configure lazy pending updates count
    local auto_theme_custom = require 'lualine.themes.auto'
    auto_theme_custom.normal.c.bg = 'none'
    auto_theme_custom.normal.a.bg = '#7AA89F'
    auto_theme_custom.normal.b.fg = '#7AA89F'
    auto_theme_custom.insert.a.bg = '#98BB6C'
    auto_theme_custom.command.a.bg = '#E6C384'
    -- auto_theme_custom.visual.a.bg = '#766b90'
    -- configure lualine with modified theme
    lualine.setup {
      options = {
        theme = auto_theme_custom,
        always_show_tabline = true,
        -- theme = {
        --   normal = {
        --     -- c = default_theme,
        --     -- x = default_theme,
        --     -- ... and all the sections you use
        --   },
        --   inactive = {
        --     -- c = default_theme,
        --     -- x = default_theme,
        --     -- ... and all the sections you use
        --   },
        -- },
      },
      tabline = {
        lualine_a = {
          {
            'harpoon2',
            icon = '  ',
            indicators = { '1', '2', '3', '4', '5' },
            active_indicators = { '1', '2', '3', '4', '5' },
            -- color_active = { fg = '#E82424' },
            color_active = { fg = '#DCD7BA' },
            _separator = ' - ',
            no_harpoon = 'Harpoon not loaded',
          },
        },
        lualine_b = {
          {
            'filename',
            path = 1,
          },
        },
        lualine_c = {
          {
            'searchcount',
            maxcount = 999,
            timeout = 500,
          },
        },
      },
      sections = {
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {},
      },
      -- sections = {
      --   lualine_x = {
      --     {
      --       lazy_status.updates,
      --       cond = lazy_status.has_updates,
      --       -- color = { fg = '#ff9e64' },
      --     },
      --     { 'encoding' },
      --     { 'fileformat' },
      --     { 'filetype' },
      --   },
      -- },
    }
  end,
}

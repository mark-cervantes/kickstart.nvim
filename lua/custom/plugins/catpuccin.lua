return {
  'catppuccin/nvim',
  priority = 1000,
  config = function()
    -- 1. Run the plugin's setup function (if needed)
    require('catppuccin').setup {
      -- your theme configuration options here
    }
    -- 2. Call the new colorscheme command
    vim.cmd.colorscheme 'catppuccin' -- or 'catppuccin-latte', 'catppuccin-mocha', etc.
  end,
}

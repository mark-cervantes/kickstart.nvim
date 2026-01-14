return {
  {
    'sindrets/diffview.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- Optional, but recommended for icons
      'nvim-lua/plenary.nvim', -- Required dependency
    },
    -- Optional: Add keymaps and configuration
    keys = {
      {
        'dv',
        function()
          if next(require('diffview.lib').views) == nil then
            vim.cmd 'DiffviewOpen'
          else
            vim.cmd 'DiffviewClose'
          end
        end,
        desc = 'Toggle Diffview window',
      },
      -- Add other keymaps as needed
    },
    config = function()
      require('diffview').setup {}
    end,
  },
}

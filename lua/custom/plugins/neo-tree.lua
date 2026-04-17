-- ~/.config/nvim/lua/plugins/neo-tree.lua
return {
  -- neo-tree
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('neo-tree').setup {
        close_if_last_window = true,
        popup_border_style = 'rounded',
        enable_git_status = true,
        enable_diagnostics = true,
        default_component_configs = {
          icon = {
            folder_closed = '󰉋',
            folder_open = '󰝰',
            folder_empty = '󰉖',
            folder_empty_open = '󰷏',
          },
          indent = {
            padding = 1,
            with_markers = true,
            indent_marker = '│',
          },
        },
        window = {
          position = 'left',
          width = 36,
          mappings = {
            ['<space>'] = 'toggle_node',
            ['o'] = 'open',
            ['s'] = 'open_split',
            ['v'] = 'open_vsplit',
            ['t'] = 'open_tabnew',
            ['a'] = 'add',
            ['d'] = 'delete',
            ['r'] = 'rename',
            ['h'] = 'close_node',
            ['l'] = 'open',
            ['.'] = 'set_root',
            ['R'] = 'refresh',
            ['P'] = { 'toggle_preview', config = { use_float = true } },
          },
        },
        filesystem = {
          bind_to_cwd = false,
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
          filtered_items = {
            visible = false,
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_by_name = { 'node_modules' },
          },
          window = {
            mappings = {
              ['l'] = 'open',
              ['h'] = 'close_node',
              ['/'] = { 'fuzzy_finder', config = { keep_filter_on_submit = true } },
              ['<esc>'] = 'clear_filter',
            },
          },
        },
      }

      -- toggle mapping
      vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true })
    end,
  },

  -- lsp file operations (works well with neo-tree)
  {
    'antosha417/nvim-lsp-file-operations',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neo-tree/neo-tree.nvim',
    },
    config = function()
      require('lsp-file-operations').setup()
    end,
  },

  -- window picker
  {
    's1n7ax/nvim-window-picker',
    version = '2.*',
    config = function()
      require('window-picker').setup {
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          bo = {
            filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
            buftype = { 'terminal', 'quickfix' },
          },
        },
      }
    end,
  },
}

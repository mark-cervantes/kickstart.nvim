-- In your toggleterm.nvim plugin config, add the `on_open` callback:
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    size = 15,
    direction = 'horizontal',
    start_in_insert = true,
    persist_mode = false,
    on_open = function(term)
      -- Double-escape exits terminal mode (like native Neovim)
      vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', {
        buffer = term.bufnr,
        desc = 'Exit terminal mode',
      })
    end,
  },
  keys = {
    { '<leader>t', '<cmd>ToggleTerm<CR>', desc = 'Toggle terminal', mode = { 'n', 't' } },
  },
}

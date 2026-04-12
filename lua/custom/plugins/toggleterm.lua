return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    size = 15,
    direction = 'horizontal',
    start_in_insert = true,
    persist_mode = false,
  },
  keys = {
    { '<A-t>', '<cmd>ToggleTerm<CR>', desc = 'Toggle terminal', mode = { 'n', 't' } },
  },
}

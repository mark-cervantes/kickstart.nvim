return {
  'github/copilot.vim',
  event = 'InsertEnter',
  cmd = { 'Copilot' },
  init = function()
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_enabled = 1
    vim.g.copilot_filetypes = { ['*'] = true }
    -- Enable ghost text
    vim.g.copilot_suggestion = { enabled = true }
    vim.g.copilot_panel = { enabled = true }
  end,
  config = function()
    -- Accept full suggestion: Ctrl+y (terminal-friendly)
    local function set_accept_mapping(lhs)
      pcall(vim.keymap.set, 'i', lhs, 'copilot#Accept("")', {
        expr = true,
        replace_keycodes = false,
        desc = 'Copilot accept',
      })
    end

    set_accept_mapping('<C-y>')
    -- Optional: Alt+Enter (may not be supported in all terminals)
    set_accept_mapping('<M-CR>')

    -- Accept one word: Ctrl+l
    vim.keymap.set('i', '<C-l>', 'copilot#AcceptWord()', {
      expr = true,
      replace_keycodes = false,
      desc = 'Copilot accept word',
    })

    -- Next / previous / dismiss: Ctrl+n / Ctrl+p / Ctrl+x
    vim.keymap.set('i', '<C-n>', function() vim.fn['copilot#Next']() end, { desc = 'Copilot next suggestion' })
    vim.keymap.set('i', '<C-p>', function() vim.fn['copilot#Previous']() end, { desc = 'Copilot previous suggestion' })
    vim.keymap.set('i', '<C-x>', function() vim.fn['copilot#Dismiss']() end, { desc = 'Copilot dismiss' })

    -- Manually trigger suggestion: Ctrl+g
    vim.keymap.set('i', '<C-g>', function() vim.fn['copilot#Suggest']() end, { desc = 'Copilot trigger suggestion' })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'BlinkCmpMenuOpen',
      callback = function()
        pcall(vim.fn['copilot#Dismiss'])
      end,
    })
  end,
}

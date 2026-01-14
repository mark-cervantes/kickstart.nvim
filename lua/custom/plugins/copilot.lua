return {
  'zbirenbaum/copilot.lua',
  dependencies = { 'copilotlsp-nvim/copilot-lsp' },
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = false, -- Disable built-in accept
          accept_word = false,
          accept_line = false,
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },
    }

    -- Super-Tab implementation
    vim.keymap.set('i', '<Tab>', function()
      if require('copilot.suggestion').is_visible() then
        require('copilot.suggestion').accept()
      else
        -- Fall back to regular tab
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
      end
    end, { silent = true, expr = true })

    -- Shift-Tab for NES functionality
    vim.keymap.set('i', '<S-Tab>', function()
      if require('copilot.suggestion').is_visible() then
        require('copilot.suggestion').next()
      else
        -- Your preferred Shift-Tab behavior
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<S-Tab>', true, false, true), 'n', false)
      end
    end, { silent = true, expr = true })
  end,
}

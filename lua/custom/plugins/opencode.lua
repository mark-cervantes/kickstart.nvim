return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for `snacks` provider.
    ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
    { 'folke/snacks.nvim', opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    -- Recommended/example keymaps.
    vim.keymap.set({ 'n', 'x' }, '<C-a>', function()
      require('opencode').ask('@this: ', { submit = true })
    end, { desc = 'Ask opencode' })
    vim.keymap.set({ 'n', 'x' }, '<C-x>', function()
      require('opencode').select()
    end, { desc = 'Execute opencode action…' })
    vim.keymap.set({ 'n', 'x' }, 'ga', function()
      require('opencode').prompt '@this'
    end, { desc = 'Add to opencode' })
    vim.keymap.set({ 'n', 't' }, '<A-o>', function()
      require('opencode').toggle()
    end, { desc = 'Toggle opencode' })
    vim.keymap.set('n', '<S-C-u>', function()
      require('opencode').command 'session.half.page.up'
    end, { desc = 'opencode half page up' })
    vim.keymap.set('n', '<S-C-d>', function()
      require('opencode').command 'session.half.page.down'
    end, { desc = 'opencode half page down' })
    -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
    vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
    vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })
  end,
  vim.api.nvim_create_user_command('OpencodeHardReset', function()
    -- 1. Kill any real processes
    vim.fn.system { 'pkill', '-f', 'opencode' }

    -- 2. Clear opencode.nvim internal module cache
    for k in pairs(package.loaded) do
      if k:match '^opencode' then
        package.loaded[k] = nil
      end
    end

    -- 3. Re-require and start fresh
    vim.defer_fn(function()
      local oc = require 'opencode'
      oc.start()
    end, 200)
  end, { desc = 'Hard reset opencode (process + Lua state)' }),
}

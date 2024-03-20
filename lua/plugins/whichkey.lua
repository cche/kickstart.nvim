return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  -- spelling = {
  --     enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
  --     suggestions = 20, -- how many suggestions should be shown in the list?
  --   },
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()
    require('which-key').register({
      l = {
        name = 'LSP',
      },
      t = {
        name = 'Todo',
      },
      d = {
        name = 'Test/Debug',
      },
      w = {
        name = 'Workspace',
      },
      s = {
        name = 'Spell',
        s = { '<cmd>Telescope spell_suggest<cr>', 'spelling' },
        n = { ']s', 'next' },
        p = { '[s', 'previous' },
        g = { 'zg', 'good' },
        r = { 'zg', 'right' },
        w = { 'zw', 'wrong' },
        b = { 'zw', 'bad' },
      },
      g = {
        name = 'Git',
        g = { '<cmd>Neogit<cr>', 'neogit' },
        c = { '<cmd>Neogit commit<cr>', 'commit' },
      },
      f = {
        name = 'Find/search',
        f = { '<cmd>Telescope find_files<cr>', 'files' },
        h = { '<cmd>Telescope help_tags<cr>', 'help' },
        k = { '<cmd>Telescope keymaps<cr>', 'keymaps' },
        r = { '<cmd>Telescope lsp_references<cr>', 'references' },
        g = { '<cmd>Telescope live_grep<cr>', 'grep' },
        c = { '<cmd>Telescope git_commits<cr>', 'git commits' },
        q = { '<cmd>Telescope quickfix<cr>', 'quickfix' },
        l = { '<cmd>Telescope loclist<cr>', 'loclist' },
        j = { '<cmd>Telescope jumplist<cr>', 'jumplist' },
        w = { '<cmd>Telescope file_browser<cr>', 'File browser' },
      },
      o = {
        name = 'Obsidian',
        n = { '<cmd>ObsidianNew<cr>', 'new note' },
        o = { '<cmd>ObsidianQuickSwitch<cr>', 'quick switch' },
        s = { '<cmd>ObsidianSearch<cr>', 'search' },
        f = { '<cmd>ObsidianFollowLink<cr>', 'follow link' },
        l = { '<cmd>ObsidianLink<cr>', 'create link to note' },
        L = { '<cmd>ObsidianLinkNew<cr>', 'create new link' },
        t = { '<cmd>ObsidianTemplate<cr>', 'insert template' },
        b = { '<cmd>ObsidianBacklinks<cr>', 'backlinks' },
        e = { '<cmd>ObsidianExtractNote<cr>', 'extract note' },
        a = { '<cmd>ObsidianTags<cr>', 'tags' },
      },
      c = {
        name = 'code',
        c = { ':SlimeConfig<cr>', 'slime config' },
        n = { ':split term://$SHELL<cr>', 'new terminal' },
      },
      q = {
        name = 'Quarto',
      },
      x = { '<cmd>bd<cr>', 'close buffer' },
    }, { prefix = '<leader>' })
  end,
}

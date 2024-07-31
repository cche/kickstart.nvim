return {
  {
    'Exafunction/codeium.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
    },
    -- event = 'BufEnter',
    config = function()
      require('codeium').setup {
        --  default keymap
        default_keymap = {
          -- change '<C-g>' here to any keycode you like.
          -- accept = '<C-g>',
          -- accept_word = false,
          -- accept_line = false,
          -- next = '<M-]>',
          -- prev = '<M-[>',
          -- dismiss = '<C-]>',
        },
        filetypes = {
          -- default = true
          markdown = false,
          text = false,
          mail = false,
        },
      }
    end,
  },
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter',
    config = function()
      --   vim.g.codeium_theme = 'one-dark'
      --   vim.g.codeium_theme_dark = true
      --   vim.g.codeium_no_map_tab = true
      --   vim.cmd('let g:codeium_filetypes = { "mail": v:false, "markdown": v:false, "text": v:false}' )
      --   -- vim.g.codeium_filetypes = { "mail", "text"}
      --   -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-g>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true, silent = true })
      vim.keymap.set('i', '<C-;>', function()
        return vim.fn['codeium#CycleCompletions'](1)
      end, { expr = true, silent = true })
      vim.keymap.set('i', '<C-,>', function()
        return vim.fn['codeium#CycleCompletions'](-1)
      end, { expr = true })
      vim.keymap.set('i', '<C-x>', function()
        return vim.fn['codeium#Clear']()
      end, { expr = true, silent = true })

      vim.cmd [[let g:codeium_filetypes = { "mail": v:false, "text": v:false } ]]
    end,
  },
}

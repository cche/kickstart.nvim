return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      close_if_last_window = true,
      event_handlers = {
        {
          event = 'file_opened',
          handler = function(file_path)
            require('neo-tree.command').execute { action = 'close' }
          end,
        },
      }
    }
  end,
  keys = {
    {
      '<leader>e',
      function()
        require('neo-tree.command').execute {
          toggle = true,
          source = 'filesystem',
          position = 'left',
        }
      end,
      desc = 'Toggle Neo-tree',
    },
  },
}

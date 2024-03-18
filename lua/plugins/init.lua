-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'chrishrb/gx.nvim',
    event = { 'BufEnter' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true, -- default settings
  },
  -- TODO Test documentation generation plugin at some point
  -- {
  --   "danymat/neogen",
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   config = true
  -- },
  -- NOTE  terminal
  -- {
  --   "akinsho/toggleterm.nvim",
  --   version = '*',
  --   config = function()
  --     require("toggleterm").setup {
  --       open_mapping = [[<c-\>]],
  --       direction = 'float',
  --     }
  --   end
  -- },
}

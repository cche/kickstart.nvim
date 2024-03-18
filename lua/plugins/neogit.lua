return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'nvim-telescope/telescope.nvim', -- optional
    },
    opts = {
      kind = 'split',
    },
    config = true,
  },
}

return {
  { 'snakemake/snakemake', ft = 'snakemake', rtp = 'misc/vim' },
  {
    'snakemake/snakefmt',

    ft = 'snakemake',
    config = function()
      vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
        pattern = 'Snakefile,*.smk',
        command = ':Snakefmt',
        group = vim.api.nvim_create_augroup('snakemake', { clear = true }),
      })
      vim.g.snakefmt_fmt_on_save = 1
    end,
  },
}

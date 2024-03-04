return {
  'snakemake/snakefmt',
  ft = 'snakemake',
  config = function()
    vim.g.snakefmt_fmt_on_save = 1
  end
}

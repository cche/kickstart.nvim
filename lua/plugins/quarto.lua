return {

  {
    'quarto-dev/quarto-nvim',
    dev = false,
    dependencies = {
      {
        'jmbuhr/otter.nvim',
        dev = false,
        dependencies = {
          { 'neovim/nvim-lspconfig' },
        },
        opts = {
          lsp = {
            hover = {
              border = 'rounded',
            },
          },
        },
      },
    },
    opts = {
      lspFeatures = {
        languages = { 'r', 'python', 'julia', 'bash', 'lua', 'html' },
      },
    },
    ft = 'quarto',
    keys = {
      { '<leader>qa', ':QuartoActivate<cr>', desc = 'quarto activate' },
      { '<leader>qp', ":lua require'quarto'.quartoPreview()<cr>", desc = 'quarto preview' },
      { '<leader>qq', ":lua require'quarto'.quartoClosePreview()<cr>", desc = 'quarto close' },
      { '<leader>qh', ':QuartoHelp ', desc = 'quarto help' },
      { '<leader>qe', ":lua require'otter'.export()<cr>", desc = 'quarto export' },
      { '<leader>qE', ":lua require'otter'.export(true)<cr>", desc = 'quarto export overwrite' },
      { '<leader>qrr', ':QuartoSendAbove<cr>', desc = 'quarto run to cursor' },
      { '<leader>qra', ':QuartoSendAll<cr>', desc = 'quarto run all' },
      { '<leader><cr>', ':SlimeSend<cr>', desc = 'send code chunk' },
      { '<c-cr>', ':SlimeSend<cr>', desc = 'send code chunk' },
      { '<c-cr>', '<esc>:SlimeSend<cr>i', mode = 'i', desc = 'send code chunk' },
      { '<c-cr>', '<Plug>SlimeRegionSend<cr>', mode = 'v', desc = 'send code chunk' },
      { '<cr>', '<Plug>SlimeRegionSend<cr>', mode = 'v', desc = 'send code chunk' },
      { '<leader>cp', '<esc>i```{python}<cr>```<esc>O', desc = 'New python chunk' },
      { '<leader>cr', '<esc>i```{r}<cr>```<esc>O', desc = 'New R chunk' },
      { '<leader>ctr', ':split term://R<cr>', desc = 'terminal: R' },
      { '<leader>ctp', ':split term://ipython<cr>', desc = 'terminal: ipython' },
      { '<leader>ctj', ':split term://julia<cr>', desc = 'terminal: julia' },
    },
  },

  -- send code from python/r/qmd documets to a terminal or REPL
  -- like ipython, R, bash
  {
    'jpalardy/vim-slime',
    event = 'VeryLazy',
    ft = { 'python', 'r', 'qmd', 'rmd' },
    init = function()
      -- slime, neovvim terminal
      vim.g.slime_target = 'neovim'
      vim.g.slime_python_ipython = 1
      vim.g.slime_dispatch_ipython_pause = 100
      -- vim.g.slime_cell_delimiter = '#\\s\\=%%'
      vim.g.slime_cell_delimiter = '```'

      vim.cmd [[
      function! _EscapeText_python(text)
      if slime#config#resolve("python_ipython") && len(split(a:text,"\n")) > 1
      return ["%cpaste -q\n", slime#config#resolve("dispatch_ipython_pause"), a:text, "--\n"]
      else
      let empty_lines_pat = '\(^\|\n\)\zs\(\s*\n\+\)\+'
      let no_empty_lines = substitute(a:text, empty_lines_pat, "", "g")
      let dedent_pat = '\(^\|\n\)\zs'.matchstr(no_empty_lines, '^\s*')
      let dedented_lines = substitute(no_empty_lines, dedent_pat, "", "g")
      let except_pat = '\(elif\|else\|except\|finally\)\@!'
      let add_eol_pat = '\n\s[^\n]\+\n\zs\ze\('.except_pat.'\S\|$\)'
      return substitute(dedented_lines, add_eol_pat, "\n", "g")
      end
      endfunction
      ]]
    end,
    config = function()
      vim.keymap.set({ 'n', 'i', 'v' }, '<c-cr>', ':SlimeSend<cr>', { desc = 'send code chunk' })
      vim.keymap.set({ 'n', 'i', 'v' }, '<s-cr>', '<Plug>SlimeSendCell', { desc = 'send code cell' })

      local function mark_terminal()
        vim.g.slime_last_channel = vim.b.terminal_job_id
        vim.print(vim.g.slime_last_channel)
      end

      local function set_terminal()
        vim.b.slime_config = { jobid = vim.g.slime_last_channel }
      end

      require('which-key').add {
        { '<leader>cm', mark_terminal, desc = 'mark terminal' },
        { '<leader>cs', set_terminal, desc = 'set terminal' },
      }
    end,
  },

  -- paste an image to markdown from the clipboard
  -- :PasteImg,
  { 'ekickx/clipboard-image.nvim' },

  -- preview equations
  {
    'jbyuki/nabla.nvim',
    event = 'VeryLazy',
    ft = { 'qmd', 'markdown' },
    keys = {
      { '<leader>qt', ':lua require"nabla".toggle_virt()<cr>', 'toggle equations' },
      { '<leader>qh', ':lua require"nabla".popup()<cr>', 'hover equation' },
    },
  },
}

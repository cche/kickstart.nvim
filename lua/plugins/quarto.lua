return {

  {
    'quarto-dev/quarto-nvim',
    ft = 'quarto',
    dev = false,
    opts = {},
    dependencies = {
      {
        'jmbuhr/otter.nvim',
      },
    },
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

  { -- directly open ipynb files as quarto docuements
    -- and convert back behind the scenes
    'GCBallesteros/jupytext.nvim',
    opts = {
      custom_language_formatting = {
        python = {
          extension = 'qmd',
          style = 'quarto',
          force_ft = 'quarto',
        },
        r = {
          extension = 'qmd',
          style = 'quarto',
          force_ft = 'quarto',
        },
      },
    },
  },

  -- send code from python/r/qmd documets to a terminal or REPL
  -- like ipython, R, bash
  {
    'jpalardy/vim-slime',
    dev = false,
    event = 'VeryLazy',
    ft = { 'python', 'r', 'qmd', 'rmd' },
    init = function()
      vim.b['quarto_is_python_chunk'] = false
      Quarto_is_in_python_chunk = function()
        require('otter.tools.functions').is_otter_language_context 'python'
      end

      vim.cmd [[
      let g:slime_dispatch_ipython_pause = 100
      function SlimeOverride_EscapeText_quarto(text)
      call v:lua.Quarto_is_in_python_chunk()
      if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists('b:quarto_is_r_mode') && b:quarto_is_r_mode)
      return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
      else
      if exists('b:quarto_is_r_mode') && b:quarto_is_r_mode && b:quarto_is_python_chunk
      return [a:text, "\n"]
      else
      return [a:text]
      end
      end
      endfunction
      ]]

      vim.g.slime_target = 'neovim'
      vim.g.slime_no_mappings = true
      vim.g.slime_python_ipython = 1
    end,
    config = function()
      vim.keymap.set({ 'n', 'i', 'v' }, '<c-cr>', ':SlimeSend<cr>', { desc = 'send code chunk' })
      vim.keymap.set({ 'n', 'i', 'v' }, '<s-cr>', '<Plug>SlimeSendCell', { desc = 'send code cell' })
      vim.g.slime_input_pid = false
      vim.g.slime_suggest_default = true
      vim.g.slime_menu_config = false
      vim.g.slime_neovim_ignore_unlisted = true

      local function mark_terminal()
        local job_id = vim.b.terminal_job_id
        vim.print('job_id: ' .. job_id)
      end

      local function set_terminal()
        vim.fn.call('slime#config', {})
      end
      vim.keymap.set('n', '<leader>cm', mark_terminal, { desc = '[m]ark terminal' })
      vim.keymap.set('n', '<leader>cs', set_terminal, { desc = '[s]et terminal' })
    end,
  },

  { -- paste an image from the clipboard or drag-and-drop
    'HakonHarnes/img-clip.nvim',
    event = 'BufEnter',
    ft = { 'markdown', 'quarto', 'latex' },
    opts = {
      default = {
        dir_path = 'img',
      },
      filetypes = {
        markdown = {
          url_encode_path = true,
          template = '![$CURSOR]($FILE_PATH)',
          drag_and_drop = {
            download_images = false,
          },
        },
        quarto = {
          url_encode_path = true,
          template = '![$CURSOR]($FILE_PATH)',
          drag_and_drop = {
            download_images = false,
          },
        },
      },
    },
    config = function(_, opts)
      require('img-clip').setup(opts)
      vim.keymap.set('n', '<leader>ii', ':PasteImage<cr>', { desc = 'insert [i]mage from clipboard' })
    end,
  },

  { -- preview equations
    'jbyuki/nabla.nvim',
    keys = {
      { '<leader>qm', ':lua require"nabla".toggle_virt()<cr>', desc = 'toggle [m]ath equations' },
    },
  },

  {
    'benlubas/molten-nvim',
    enabled = false,
    build = ':UpdateRemotePlugins',
    init = function()
      vim.g.molten_image_provider = 'image.nvim'
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
    end,
    keys = {
      { '<leader>mi', ':MoltenInit<cr>', desc = '[m]olten [i]nit' },
      {
        '<leader>mv',
        ':<C-u>MoltenEvaluateVisual<cr>',
        mode = 'v',
        desc = 'molten eval visual',
      },
      { '<leader>mr', ':MoltenReevaluateCell<cr>', desc = 'molten re-eval cell' },
    },
  },
}

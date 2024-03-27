return {
  'David-Kunz/gen.nvim',
  config = function()
    local gen = require 'gen'
    gen.model = 'mistral'
    gen.command = function(options)
      local body = { model = gen.model, stream = true }
      return 'curl --silent --no-buffer -X POST http://' .. options.host .. ':' .. options.port .. '/api/chat -d $body'
    end
    gen.display_mode = 'split'
    gen.prompts['Fix_Code'] = {
      prompt = 'Fix the following code. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```',
      replace = true,
      extract = '```$filetype\n(.-)```',
    }
    gen.prompts['Explain_Code'] = {
      prompt = 'Explain what the following code does:\n```$filetype\n$text\n```',
      replace = false,
      extract = '```$filetype\n(.-)```',
    }
    gen.debug = false
  end,
  vim.keymap.set({ 'v', 'n' }, '<leader>co', ':Gen<cr>', { desc = 'Generate' }),
}

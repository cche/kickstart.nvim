return {
  'David-Kunz/gen.nvim',
  opts = {
    model = 'qwen2.5-coder',
    command = function(options)
      local body = { model = options.model, stream = true }
      return 'curl --silent --no-buffer -X POST http://' .. options.host .. ':' .. options.port .. '/api/chat -d $body'
    end,
    display_mode = 'split',
    debug = false,
  },
  config = function(_, opts)
    require('gen').setup(opts)
    require('gen').prompts['Fix_Code'] = {
      prompt = 'Fix the following code. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```',
      replace = true,
      extract = '```$filetype\n(.-)```',
    }
    require('gen').prompts['Explain_Code'] = {
      prompt = 'Explain what the following code does:\n```$filetype\n$text\n```',
      replace = false,
      extract = '```$filetype\n(.-)```',
    }
  end,
}

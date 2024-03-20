return {
  'David-Kunz/gen.nvim',
  config = function()
    vim.keymap.set({ 'v', 'n' }, '<leader>co', ':Gen<CR>')
    require('gen').model = 'codellama'
    require('gen').display_mode = 'split'
    require('gen').prompts['Fix_Code'] = {
      prompt = 'Fix the following code. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```',
      replace = true,
      extract = '```$filetype\n(.-)```',
    }
    require('gen').prompts['Comment_Code'] = {
      prompt = 'Add comments to the following code so that it is clear what it does. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```',
      replace = true,
      extract = '```$filetype\n(.-)```',
    }
  end,
}

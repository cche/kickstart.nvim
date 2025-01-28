return {
  -- dir = '/home/cristian/src/github/todo-txt.nvim',
  -- config = function()
  --   require('todo-txt').setup {
  --     todo_file = '~/src/github/todo-txt.nvim/todo.txt',
  --   }
  -- end,
  {
    'cche/todo-txt.nvim',
    config = function()
      require('todo-txt').setup {
        todo_file = '~/Dropbox/Apps/Simpletask/todo.txt',
      }
    end,
  },
}

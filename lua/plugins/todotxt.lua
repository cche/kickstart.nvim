return {
  'arnarg/todotxt.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim'
  },
  config = function()
    require("todotxt-nvim").setup{
      todo_file = "~/Dropbox/Apps/Simpletask/todo.txt",
      sidebar = {
        width = 50,
        position = "right"
      },
      capture = {
        prompt = "> ",
        -- Percentage is percentage of width of the whole editor
        -- Integer is number of columns
        width = "75%",
        position = "50%",
        -- Styled after https://swiftodoapp.com/todotxt-syntax/priority/
        -- With this, if you include any of the below keywords it will
        -- automatically use the associated priority and remove that
        -- keyword from the final task.
        alternative_priority = {
          A = "now",
          B = "next",
          C = "today",
          D = "this week",
          E = "next week",
        },
      },
      -- Highlights used in both capture prompt and tasks sidebar
      -- Each highlight type can be a table with 'fg', 'bg' and 'style'
      -- options or a string referencing an existing highlight group.
      -- highlights = {
      --   project = "Identifier",
      -- }
      highlights = {
        project = {
          fg = "magenta",
          bg = "NONE",
          style = "NONE",
        },
        context = {
          fg = "cyan",
          bg = "NONE",
          style = "NONE",
        },
        date = {
          fg = "NONE",
          bg = "NONE",
          style = "underline",
        },
        done_task = {
          fg = "gray",
          bg = "NONE",
          style = "NONE",
        },
        priorities = {
          A = {
            fg = "green",
            bg = "NONE",
            style = "bold",
          },
          B = {
            fg = "magenta",
            bg = "NONE",
            style = "bold",
          },
          C = {
            fg = "yellow",
            bg = "NONE",
            style = "bold",
          },
          D = {
            fg = "cyan",
            bg = "NONE",
            style = "bold",
          },
        },
      },
      -- Keymap used in sidebar split
      keymap = {
        quit = "q",
        toggle_metadata = "m",
        delete_task = "dd",
        complete_task = "cc",
        edit_task = "ee",
      },
    }
  end,
}

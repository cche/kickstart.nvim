return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },

  config = function()
    require('lint').linters.snakelint = {
      name = 'snakelint',
      cmd = 'snakemake',
      stdin = false, -- false if it doesn't support content input via stdin. If so filename is automatically added to the arguments.
      append_fname = true, -- Automatically append the file name to `args` if `stdin = false` (default: true)
      args = { '--lint', 'text', '--snakefile' }, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
      stream = 'stderr', -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
      ignore_exitcode = true, -- set this to true if the linter exits with a code != 0 and that's considered normal.
      env = nil, -- custom environment table to use with the external process. This replaces the *entire* environment, it is not additive.
      parser = function(lint_output, buffnr)
        local diagnostics = {}
        local current_diagnostic = nil

        for line in lint_output:gmatch '(.-)\n\n\n?' do
          local linenum = 0
          local errmessage = nil
          local rest = nil
          line = string.gsub(line, '\n', '')
          if string.find(line, 'Lints for rule') then
            linenum, errmessage, rest = line:match 'line (%d+), .- %*% (.-): (.*)'
          else
            errmessage, linenum, rest = string.match(line, ' \\* (.*) in line (%d+): (.*)')
          end

          if errmessage then
            local user_data = rest:gsub(' +', ' ')
            current_diagnostic = {
              lnum = tonumber(linenum) - 1,
              col = 0,
              message = errmessage,
              source = 'snakelint',
              severity = vim.diagnostic.severity.WARNING,
              user_data = user_data:match '^%s*(.-)%s*$',
            }
            table.insert(diagnostics, current_diagnostic)
            current_diagnostic = nil
          end
        end

        return diagnostics
      end,
    }

    require('lint').linters_by_ft = {
      snakemake = { 'snakelint' },
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}

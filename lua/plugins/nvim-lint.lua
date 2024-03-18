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
      stream = 'both', -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
      ignore_exitcode = true, -- set this to true if the linter exits with a code != 0 and that's considered normal.
      env = nil, -- custom environment table to use with the external process. This replaces the *entire* environment, it is not additive.
      parser = function(lint_output, buffnr)
        local diagnostics = {}
        local current_diagnostic = nil
        local current_message = ''
        local message_type = nil
        local rule_line = 0

        print 'starting linting'

        for line in lint_output:gmatch '[^\r\n]+' do
          if string.find(line, 'Lints for snakefile') then
            message_type = 'snakefile'
          end
          if string.find(line, 'Lints for rule') then
            message_type = 'rule'
            rule_line = string.find(line, '\\(line (%d+),')
          end
          -- print(message_type)
          -- If the line starts with a `*` character, then this is the start of a new diagnostic message
          if line:sub(5, 5) == '*' then
            print 'found *'
            -- accumulate lines into one string until an empty line is encountered
            current_message = line
          elseif line ~= '' then
            print 'extending line'
            current_message = current_message .. ' ' .. line
          elseif string.gsub(line, '^%s*(.-)%s*$', '%1') == '' then
            print 'empty line'
            local message = ''
            local user_data = ''
            local linenum = 1
            -- If line starts with "Lints for snakefile"
            if message_type == 'snakefile' then
              _, _, message, linenum, user_data = string.find(current_message, '\\*%s+(.-) in line (%d+): (.+)')
              print('s ' .. message .. '\n')
              print(user_data .. '\n')
            elseif message_type == 'rule' then
              _, _, message, user_data = string.find(current_message, '\\*%s+(.-): (.+)')
              linenum = rule_line
              print('r ' .. message .. '\n')
              print(user_data .. '\n')
            end

            if user_data then
              current_diagnostic = {
                source = 'snakelint',
                severity = vim.diagnostic.severity.WARNING,
                -- severity = "WARNING",
                message = message,
                lnum = linenum,
                user_data = user_data:match '^%s*(.-)%s*$',
              }
              table.insert(diagnostics, current_diagnostic)
              current_diagnostic = nil
            end
          end
        end

        -- If there is a current diagnostic message that has not yet been added to the list of diagnostics, then add it now
        if current_diagnostic then
          table.insert(diagnostics, current_diagnostic)
        end

        print('Diagnostics: ' .. vim.inspect(diagnostics))
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

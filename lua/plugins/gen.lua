return {
  "David-Kunz/gen.nvim",
  config = function()
    vim.keymap.set({"v", "n"}, "<leader>oo", ":Gen<CR>")
    require("gen").model = "codellama"
  end,
}

return {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
	require("null-ls").setup({
	    sources = {
	    	-- formatting
	    	require("null-ls").builtins.formatting.ruff,
	    	require("null-ls").builtins.formatting.black,

	    	-- diagnostics
	    	require("null-ls").builtins.diagnostics.ruff,

	    },
	})
    end,

}

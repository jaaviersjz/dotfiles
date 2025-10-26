return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,   -- Lua
				null_ls.builtins.formatting.prettier, -- Markdown, less
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,    -- Python
			},
		})
		-- Keymaps
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}

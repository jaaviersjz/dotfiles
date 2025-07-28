-- CATPPUCCIN
return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			transparent_background = false,
			styles = {
				comments = { "italic" },
				functions = { "bold" },
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}

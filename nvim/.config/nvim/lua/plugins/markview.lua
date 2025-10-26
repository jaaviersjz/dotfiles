-- MARKVIEW (markdown and LaTeX previewer for Neovim)
return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	-- For `nvim-treesitter` users.
	priority = 49,
	-- Configuration
	config = function()
    -- Disable preview by default
    require("markview").setup({
      preview = {
        enable = false,
      }
    });
    -- Keymaps
    vim.keymap.set("n", "<leader>gm", "<cmd>Markview splitToggle<CR>", {})
	end,
}

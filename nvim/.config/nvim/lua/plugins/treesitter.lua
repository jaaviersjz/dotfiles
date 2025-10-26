-- TREESITTERtreesiter.lua
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = { "lua", "javascript", "c", "ruby", "bash", "python" },
			auto_install = true,
      sync_install = false,
      ignore_install = {},
			highlight = { enable = true, disable = { "zsh" } },
			indent = { enable = true },
      modules = {},
		})
	end,
}

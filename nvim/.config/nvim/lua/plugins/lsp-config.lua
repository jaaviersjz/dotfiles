-- MASON (LSP manager)
return {
	{
		"mason-org/mason.nvim",
		ops = {},
		config = function()
			require("mason").setup({})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		lazy = false,
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"clangd",
					"pyright",
					"ts_ls",
				},
				auto_install = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = vim.lsp.config
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- LUA config
			lspconfig.lua_ls.capabilities = capabilities
			vim.lsp.config.lua_ls.settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = { "vim" } },
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = { enable = false },
				},
			}
			-- C/C++ config
			vim.lsp.config.clangd.capabilities = capabilities
			vim.lsp.config.clangd.cmd = {
				"clangd",
			}
			-- Typescript and Javascript config
			vim.lsp.config.ts_ls.capabilites = capabilities
			vim.lsp.config.initon_options = {
				preferences = {
					disableSuggestions = true,
				},
			}
			-- Python config
			vim.lsp.config.pyright.capabilities = capabilities

			-- GENERAL configurations
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			-- Error messages in line
			vim.diagnostic.config({
				virtual_text = false,
				signs = true,
				update_in_insert = true,
				underline = true,
				severity_sort = false,
				float = {
					border = "rounded",
					source = true,
					header = "",
					prefix = "",
				},
			})
			vim.keymap.set("n", "J", vim.diagnostic.open_float, { desc = "" })
			vim.lsp.handlers["textDocument/hover"] =
				vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", syntax = "markdown" })
		end,
	},
}

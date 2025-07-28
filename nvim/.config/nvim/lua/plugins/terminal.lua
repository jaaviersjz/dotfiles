return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<C-ñ>]],
			autochdir = true,
			terminal_mappings = true,
		})
		vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { noremap = true, silent = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
			callback = function()
				if vim.bo.buftype == "terminal" then
					vim.defer_fn(function()
						vim.cmd("startinsert")
					end, 1) -- Trick: wait for the terminal to be ready
				end
			end,
		})
		-- DEBUGGING TOOL: detect events
		-- for _, event in ipairs({ "BufEnter", "WinEnter", "BufWinEnter", "FocusGained" }) do
		--   vim.api.nvim_create_autocmd(event, {
		--     callback = function()
		--       print("Triggered: " .. event, "buftype:", vim.bo.buftype)
		--     end,
		--   })
		--end
	end,
}

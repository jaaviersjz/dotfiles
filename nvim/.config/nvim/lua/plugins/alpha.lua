return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local if_nil = vim.F.if_nil

		local default_terminal = {
			type = "terminal",
			command = nil,
			width = 69,
			height = 8,
			opts = {
				redraw = true,
				window_config = {},
			},
		}

		local default_header = {
			type = "text",

      val = {
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      },

			-- val = {
			-- 	[[ ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
			-- 	[[ ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
			-- 	[[ ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
			-- 	[[ ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
			-- 	[[ ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
			-- 	[[ ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
			--},

			--val = {
			-- 	[[                                  __]],
			-- 	[[     ___     ___    ___   __  __ /\_\    ___ ___]],
			-- 	[[    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\]],
			-- 	[[   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \]],
			-- 	[[   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
			-- 	[[    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
			--},
			--
			opts = {
				position = "center",
				hl = "Type",
				-- wrap = "overflow";
			},
		}

		local footer = {
			type = "text",
			val = "",
			opts = {
				position = "center",
				hl = "Number",
			},
		}

		local leader = "SPC"

		--- @param sc string
		--- @param txt string
		--- @param keybind string? optional
		--- @param keybind_opts table? optional
		local function button(sc, txt, keybind, keybind_opts)
			local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

			local opts = {
				position = "center",
				shortcut = sc,
				cursor = 3,
				width = 50,
				align_shortcut = "right",
				hl_shortcut = "Keyword",
			}
			if keybind then
				keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
				opts.keymap = { "n", sc_, keybind, keybind_opts }
			end

			local function on_press()
				local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
				vim.api.nvim_feedkeys(key, "t", false)
			end

			local button_table = {
				type = "button",
				val = txt,
				on_press = on_press,
				opts = opts,
			}

			button_table.on_add = function(bufnr)
				vim.api.nvim_buf_set_keymap(bufnr, "n", sc_, "", {
					noremap = true,
					silent = true,
					nowait = true,
					callback = on_press,
				})
			end

			return button_table
		end

		local buttons = {
			type = "group",
			val = {
				button("e", "  New file", "<cmd>ene <CR>"),
				button("f", "󰈞  Find file", "<cmd>Telescope find_files hidden=true <CR>"),
				button("h", "󰊄  Recently opened files", "<cmd>Telescope oldfiles <CR>"),
				button("r", "  Frecency/MRU", "<cmd>Telescope frecency <CR>"),
				button("g", "󰈬  Find word", "<cmd>Telescope live_grep <CR>"),
				button("m", "  Jump to bookmarks", "<cmd>Telescope marks <CR>"),
				button("l", "  Open last session", "<cmd>lua require('persistence').load({ last = true })<CR>"),
			},
			opts = {
				spacing = 1,
			},
		}

		local section = {
			terminal = default_terminal,
			header = default_header,
			buttons = buttons,
			footer = footer,
		}

		local config = {
			layout = {
				{ type = "padding", val = 2 },
				section.header,
				{ type = "padding", val = 2 },
				section.buttons,
				section.footer,
			},
			opts = {
				margin = 5,
			},
		}

		require("alpha").setup(config)
	end,
}

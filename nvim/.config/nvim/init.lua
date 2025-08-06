-- CONFIG
require("vim")

-- LAZY NVIM
require("config.lazy")

-- Options
-- vim.opt.wrap = false -- Disable line wrapping
vim.opt.scrolloff = 8 -- Lines to keep above and below the cursor

-- Change the background for vim-everywhere
if vim.env.VIM_TRANSPARENT == "1" then
  -- Tabs
  vim.cmd("set expandtab")
  vim.cmd("set tabstop=4")
  vim.cmd("set softtabstop=4")
  vim.cmd("set shiftwidth=4")
  -- Transparent background
	vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none"})
  -- Copilot suggestions
  vim.api.nvim_set_hl(0, "CopilotSuggestion", {
    fg = "#C0C0C0",
    italic = true,
  })
  -- Disable diagnostics
  vim.diagnostic.config({
    virtual_text = false,
    underline = false,
    update_in_insert = false,
    signs = false,
    virtual_lines = false,
  })
end

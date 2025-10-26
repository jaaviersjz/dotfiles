-- Tabs
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
-- Leader
vim.g.mapleader = " "
-- Lines
vim.o.relativenumber = true
vim.o.number = true
-- Mappings
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "<M-Tab>", "<C-x><C-o>", {})
vim.keymap.set("n", "<C-s>", "<Cmd>w<CR>", {})
-- Zsh == Bash for highlighting
vim.filetype.add({
  extension = {
    zsh = "bash",
  }
})
-- Round border
vim.o.winborder = "rounded"

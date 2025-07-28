return {
  {
    "tpope/vim-fugitive",
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        preview_config = {
          border = "rounded",
        }
      })
      -- Key bindings
      vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", {})
      vim.keymap.set("n", "<leader>gt", function() require("gitsigns").toggle_current_line_blame() end)
    end
  }
}

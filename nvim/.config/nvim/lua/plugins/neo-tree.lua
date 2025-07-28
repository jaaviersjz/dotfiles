-- NEO-TREE
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    -- Optional image support for file preview: See `# Preview Mode` for more information.
    -- {"3rd/image.nvim", opts = {}},
    -- OR use snacks.nvim's image module:
    -- "folke/snacks.nvim",
  },
  lazy = false,
  opts = {
    filesystem = {
      use_libuv_file_watcher = true,
      follow_current_file = { enabled = false },
    },
  },
  config = function()
    -- Autocomand in order to refresh neo-tree each time i exit lazy-git
    vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "BufWritePost", "BufEnter" }, {
      callback = function()
        vim.defer_fn(function()
            local ok, git = pcall(require, "neo-tree.sources.git_status.commands")
            if ok then
              git.refresh()
            end
          --end
        end, 10)
      end,
    })
    -- Keymaps
    vim.keymap.set("n", "<C-b>", "<cmd>Neotree toggle<CR>", {})
    vim.keymap.set("n", "<C-n>", "<cmd>Neotree filesystem<CR>", {})
  end,
}

return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    cmd = "Telescope",
    keys = {
      { "<leader>n", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>f", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
      { "<leader>fg", "<cmd>Telescope git_status<cr>", desc = "Git status" },
      { "<leader>fc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
      { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Grep word under cursor" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-c>"] = actions.close,
              ["<Esc>"] = actions.close,
            },
          },
          file_ignore_patterns = {
            "node_modules",
            ".git/",
            "%.lock",
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
      })

      telescope.load_extension("fzf")
    end,
  },
}

return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
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
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Grep word under cursor" },
    },
    config = function()
      if vim.fn.executable("fd") == 0 then
        vim.notify("telescope: fd not found, please install fd-find", vim.log.levels.ERROR)
        return
      end

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
            "node_modules/",
            ".git/",
            ".composer/",
            "vendor/",
            "%.lock",
            "%.min%.js",
            "%.min%.css",
            "dist/",
            "build/",
            "coverage/",
            "%.jpg",
            "%.jpeg",
            "%.png",
            "%.gif",
            "%.svg",
            "%.ico",
            "%.pdf",
            "%.zip",
            "%.tar",
            "%.gz",
            "storage/framework/",
            "storage/logs/",
            "bootstrap/cache/",
            "public/storage/",
            "__pycache__/",
            "%.pyc",
            ".venv/",
            "venv/",
            ".env/",
            "%.egg-info/",
            "dist/",
            ".pytest_cache/",
            ".mypy_cache/",
          },
        },
        pickers = {
          find_files = {
            find_command = { "fd", "--type", "f", "--hidden", "--follow" },
          },
        },
      })

      telescope.load_extension("fzf")
    end,
  },
}

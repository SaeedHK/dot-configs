return {
  -- Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = ">" },
          delete = { text = "-" },
          topdelete = { text = "^" },
          changedelete = { text = "<" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local map = function(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, "Next hunk")

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, "Previous hunk")

          -- Actions
          map("n", "<leader>ga", gs.stage_hunk, "Stage hunk")
          map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")
          map("n", "<leader>gR", gs.reset_hunk, "Reset hunk")
          map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
          map("n", "<leader>gb", function()
            gs.blame_line({ full = true })
          end, "Blame line")
        end,
      })
    end,
  },

  -- Fugitive
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiff", "Gvdiff" },
    keys = {
      { "<leader>g", ":Git ", desc = "Git command" },
      { "<leader>gg", "<cmd>vertical Git<cr>", desc = "Git status" },
      { "<leader>gd", "<cmd>vertical Git diff<cr>", desc = "Git diff" },
      { "<leader>gP", "<cmd>Git push<cr>", desc = "Git push" },
      { "<leader>go", ":Git checkout ", desc = "Git checkout" },
      { "<leader>gcm", "<cmd>Git checkout main<cr>", desc = "Checkout main" },
      { "<leader>gcd", "<cmd>Git checkout dev<cr>", desc = "Checkout dev" },
    },
  },

  -- Lazygit integration
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    keys = {
      { "<leader>gs", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*lazygit*",
        callback = function()
          vim.keymap.set("t", "<Esc>", "<cmd>close<cr>", { buffer = true, silent = true })
        end,
      })
    end,
  },
}

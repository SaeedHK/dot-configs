return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal", mode = { "n", "t" } },
      { "<leader>tt", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Toggle vertical terminal", mode = { "n", "t" } },
    },
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "vertical" then return vim.o.columns * 0.5
          else return 15 end
        end,
        open_mapping = [[<C-\>]],
        direction = "horizontal",
        on_open = function()
          vim.cmd("startinsert")
        end,
      })

      -- Esc enters normal mode (for navigation/selection), C-\ closes
      vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Enter normal mode in terminal" })

      -- Window navigation from terminal mode
      vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Move to lower window" })
      vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Move to upper window" })

    end,
  },
}

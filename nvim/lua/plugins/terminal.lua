return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal", mode = { "n", "t" } },
    },
    config = function()
      require("toggleterm").setup({
        size = 15,
        open_mapping = [[<C-\>]],
        direction = "float",
        float_opts = {
          border = "curved",
        },
        on_open = function()
          vim.cmd("startinsert")
        end,
      })

      -- Esc enters normal mode (for navigation/selection), C-\ closes
      vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Enter normal mode in terminal" })
    end,
  },
}

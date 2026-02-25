return {
  {
    "vim-test/vim-test",
    keys = {
      { "<leader>tn", "<cmd>TestNearest<cr>", desc = "Run nearest test" },
      { "<leader>tf", "<cmd>TestFile<cr>",    desc = "Run file tests" },
      { "<leader>ts", "<cmd>TestSuite<cr>",   desc = "Run test suite" },
      { "<leader>tl", "<cmd>TestLast<cr>",    desc = "Run last test" },
      { "<leader>tv", "<cmd>TestVisit<cr>",   desc = "Visit test file" },
    },
    init = function()
      vim.g["test#strategy"] = "neovim"  -- run in a split terminal
    end,
  },
}

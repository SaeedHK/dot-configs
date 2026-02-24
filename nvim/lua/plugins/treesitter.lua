return {
  -- Show current scope context at top of screen
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("treesitter-context").setup({
        max_lines = 3,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "javascript",
          "typescript",
          "tsx",
          "html",
          "css",
          "json",
          "yaml",
          "toml",
          "python",
          "ruby",
          "bash",
          "markdown",
          "markdown_inline",
          "regex",
          "haskell",
        },
        auto_install = true,
      })
      vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", {})
    end,
  },
}

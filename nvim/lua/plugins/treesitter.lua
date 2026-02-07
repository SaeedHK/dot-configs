return {
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

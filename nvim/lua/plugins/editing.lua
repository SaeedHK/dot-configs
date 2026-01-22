return {
  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")
      autopairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
        },
      })

      -- Integration with cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- Comment
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("Comment").setup()
    end,
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- Better escape
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup({
        mappings = {
          i = {
            j = { k = "<Esc>", j = "<Esc>" },
            k = { k = "<Esc>" },
          },
        },
      })
    end,
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("todo-comments").setup()
    end,
  },

  -- Zen mode (replaces goyo)
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen mode" },
    },
    config = function()
      require("zen-mode").setup({
        window = {
          width = 100,
        },
      })
    end,
  },
}

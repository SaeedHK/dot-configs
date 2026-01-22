return {
  -- GitHub Copilot (Lua version)
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = "<M-w>",
            accept_line = "<M-e>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = {
          enabled = true,
        },
        filetypes = {
          yaml = true,
          markdown = true,
          help = false,
          gitcommit = true,
          gitrebase = false,
          ["."] = false,
        },
      })
    end,
  },
}

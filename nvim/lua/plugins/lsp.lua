return {
  -- Mason: LSP installer
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    event = { "BufReadPre", "BufNewFile" },
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- Mason-lspconfig bridge
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Diagnostic config
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = true,
        },
      })

      -- LSP keymaps via LspAttach autocmd
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local bufnr = ev.buf
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
          end

          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("gr", vim.lsp.buf.references, "Go to references")
          map("gi", vim.lsp.buf.implementation, "Go to implementation")
          map("gt", vim.lsp.buf.type_definition, "Go to type definition")
          vim.keymap.set("n", "<leader>rn", function()
            return ":IncRename " .. vim.fn.expand("<cword>")
          end, { buffer = bufnr, expr = true, desc = "Rename (incremental)" })
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("gK", vim.lsp.buf.hover, "Hover documentation")
          map("<leader>e", vim.diagnostic.open_float, "Show diagnostics")
          map("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Previous diagnostic")
          map("]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next diagnostic")
        end,
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "html",
          "cssls",
          "jsonls",
          "pyright",
          "eslint",
        },
        automatic_installation = true,
        handlers = {
          -- Default handler for all servers
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,
          -- Custom handler for pyright
          ["pyright"] = function()
            local function get_python_path(workspace)
              local util = require("lspconfig/util")
              local path = util.path

              -- Use activated virtualenv
              if vim.env.VIRTUAL_ENV then
                return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
              end

              -- Find project root
              local root = workspace
                or util.root_pattern("pyproject.toml", "setup.py", "setup.cfg", ".git")(
                  vim.api.nvim_buf_get_name(0)
                )
                or vim.fn.getcwd()

              -- Check for local .venv (Poetry with in-project or manual venv)
              local venv_path = path.join(root, ".venv", "bin", "python")
              if vim.fn.executable(venv_path) == 1 then
                return venv_path
              end

              -- Check for venv directory
              venv_path = path.join(root, "venv", "bin", "python")
              if vim.fn.executable(venv_path) == 1 then
                return venv_path
              end

              -- Try Poetry environment
              local poetry_lock = path.join(root, "poetry.lock")
              if vim.fn.filereadable(poetry_lock) == 1 then
                local handle = io.popen("cd " .. root .. " && poetry env info -p 2>/dev/null")
                if handle then
                  local poetry_venv = handle:read("*a"):gsub("%s+$", "")
                  handle:close()
                  if poetry_venv and poetry_venv ~= "" then
                    return path.join(poetry_venv, "bin", "python")
                  end
                end
              end

              -- Fallback to system Python
              return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
            end

            lspconfig.pyright.setup({
              capabilities = capabilities,
              on_init = function(client)
                client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
              end,
              settings = {
                python = {
                  analysis = {
                    typeCheckingMode = "basic",
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                  },
                },
              },
            })
          end,
        },
      })
    end,
  },

  -- LSP Config (loaded as dependency)
  {
    "neovim/nvim-lspconfig",
    lazy = true,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      })
      -- Cmdline completion for / search
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      -- Cmdline completion for : commands
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          { { name = "path" } },
          { { name = "cmdline" } }
        ),
      })
    end,
  },

  -- Incremental rename with live preview
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = function()
      require("inc_rename").setup()
    end,
  },

  -- Trouble: diagnostics, references, quickfix panel
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace diagnostics" },
      { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document diagnostics" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
      { "<leader>xs", "<cmd>Trouble lsp_document_symbols toggle<cr>", desc = "Document symbols" },
    },
    config = function()
      require("trouble").setup()
    end,
  },

  -- Formatter
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>lf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        desc = "Format buffer",
      },
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "ruff_format", "ruff_organize_imports" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          ruby = { "rubocop" },
          php = { "php_cs_fixer" },
        },
        formatters = {
          prettier = {
            prepend_args = { "--tab-width", "4" },
          },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },
}

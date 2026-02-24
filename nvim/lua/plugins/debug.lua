return {
  -- Core DAP
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "jay-babu/mason-nvim-dap.nvim",
      "mfussenegger/nvim-dap-python",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue / Start" },
      { "<leader>dn", function() require("dap").step_over() end, desc = "Step over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step out" },
      { "<leader>dq", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
      { "<leader>de", function() require("dapui").eval() end, mode = { "n", "v" }, desc = "Evaluate expression" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      -- Auto open/close UI with debug session
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      -- Python: resolve virtualenv python path
      local python_path = (vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV .. "/bin/python")
        or (vim.fn.executable(vim.fn.getcwd() .. "/.venv/bin/python") == 1 and vim.fn.getcwd() .. "/.venv/bin/python")
        or vim.fn.exepath("python3")
        or "python"
      require("dap-python").setup(python_path)

      -- JS/TS: via js-debug-adapter installed by mason
      local js_debug = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
      for _, adapter in ipairs({ "pwa-node", "pwa-chrome" }) do
        dap.adapters[adapter] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = { command = "node", args = { js_debug, "${port}" } },
        }
      end
      for _, lang in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
        dap.configurations[lang] = {
          { type = "pwa-node", request = "launch", name = "Launch file", program = "${file}", cwd = "${workspaceFolder}" },
          { type = "pwa-node", request = "attach", name = "Attach", processId = require("dap.utils").pick_process, cwd = "${workspaceFolder}" },
          { type = "pwa-chrome", request = "launch", name = "Launch Chrome", url = "http://localhost:3000", webRoot = "${workspaceFolder}" },
        }
      end
    end,
  },

  { "rcarriga/nvim-dap-ui", lazy = true, dependencies = { "nvim-neotest/nvim-nio" } },
  { "mfussenegger/nvim-dap-python", lazy = true },

  -- Auto-install debug adapters via Mason
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim" },
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      ensure_installed = { "python", "js-debug-adapter" },
      automatic_installation = true,
    },
  },
}

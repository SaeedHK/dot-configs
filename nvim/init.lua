-- init.lua
-- Rewritten modern Neovim config (Lua)
-- Opinionated, based on your original Vimscript. Uses lazy.nvim for plugin management.
-- Drop this file into ~/.config/nvim/init.lua

-- ==================== Bootstrap lazy.nvim ====================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Helper shortcuts
local map = vim.keymap.set
local cmd = vim.cmd

-- ==================== Basic options ====================
local o = vim.opt
o.termguicolors = true
o.encoding = 'utf-8'
o.clipboard = 'unnamedplus'
o.mouse = 'a'
o.number = true
o.relativenumber = false
o.signcolumn = 'yes'
o.colorcolumn = '99'
o.updatetime = 250
o.timeoutlen = 500

o.splitright = true
o.splitbelow = true

o.history = 500

o.backup = false
o.writebackup = false
o.swapfile = false

o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4

o.softtabstop = 4
o.smarttab = true

o.autoindent = true

o.smartindent = true

o.wrap = true

o.linebreak = true

o.shiftround = true

o.foldcolumn = '1'

o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.hlsearch = true

o.showmatch = false -- use treesitter for structural matching

o.ruler = true

o.cmdheight = 1

o.hidden = true

o.backspace = 'indent,eol,start'

o.fileformats = 'unix,dos,mac'

-- o.termencoding = 'utf-8'

-- Keep signcolumn visible
o.signcolumn = 'yes:1'

-- ============== Leader and mappings ==============
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Convenient mapping options
local opts = { noremap = true, silent = true }

-- Escape in insert with jj/kk (preserve your habit)
map('i', 'jj', '<Esc>', opts)
map('i', 'kk', '<Esc>', opts)

-- Terminal mappings: <Esc> to go to normal mode in terminal
map('t', '<Esc>', [[<C-\><C-n>]], { silent = true })
map('t', '<S-Tab>', [[<C-\><C-n>]], { silent = true })
map('t', 'jj', [[<C-\><C-n>]], { silent = true })
map('t', 'kk', [[<C-\><C-n>]], { silent = true })

-- Fast saving/exiting
map('n', '<leader>w', '<cmd>w!<CR>', opts)
map('n', '<leader>q', '<cmd>q<CR>', opts)
map('n', '<leader>qq', '<cmd>q!<CR>', opts)
map('n', '<leader>xx', '<cmd>x<CR>', opts)

-- sudo write
map('c', 'W', 'w !sudo tee % > /dev/null <bar> edit', { noremap = true })

-- Clear search highlight
map('n', '<leader><CR>', '<cmd>nohlsearch<CR>', opts)

-- Window navigation
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- Remap 0 to first non-blank (like your old mapping)
map('n', '0', '^', opts)

-- Buffer navigation
map('n', '<leader>h', '<cmd>bprevious<CR>', opts)
map('n', '<leader>l', '<cmd>bnext<CR>', opts)
map('n', '<leader>d', '<cmd>bd!<CR>', opts)
map('n', '<leader>b', '<cmd>ls<CR>:b ', { noremap = true })

-- Telescope style file/buffer/search shortcuts (set later when telescope is loaded)
map('n', '<leader>n', '<cmd>Telescope find_files<CR>', opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts)
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', opts)

-- Quick open commonly used files (keep your shortcuts)
map('n', '<leader>oz', '<cmd>e ~/.zshrc<CR>', opts)
map('n', '<leader>os', '<cmd>e ~/.ssh/config<CR>', opts)
map('n', '<leader>oe', '<cmd>e ./.env<CR>', opts)
map('n', '<leader>ov', '<cmd>e $MYVIMRC<CR>', opts)

-- Toggle sidebar (nvim-tree)
map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', opts)
map('n', '<C-t>', '<cmd>NvimTreeFindFile<CR>', opts)
map('n', '<leader>m', '<cmd>NvimTreeFindFile<CR>', opts)

-- Block selection like you had
map('n', 'vv', 'V', opts)
map('n', 'vb', '<C-v>', opts)
map('n', 'Q', '@q', opts) -- run macro q

-- Smart Tab for completion (set later with cmp), keep fallback
map('i', '<expr>', '', {}) -- placeholder - cmp will override

-- Search and replace quick mapping
map('n', '<Leader>fr', ':%s/find/replace/gc<CR>', opts)
map('n', '<Leader>rf', ':s/foo/bar/gc<CR>', opts)

-- Toggleterm mapping (created later)
map('n', '<leader>tt', '<cmd>ToggleTerm<CR>', opts)

-- Copy file path
map('n', '<Leader>ff', '<cmd>let @+ = expand("%")<CR><cmd>echo "Copied file path!"<CR>', opts)

-- Source config quickly
map('n', '<Leader>vr', '<cmd>source $MYVIMRC<CR>', opts)

-- ==================== Autocommands ====================
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd('BufEnter', { pattern = '*', command = 'if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif' })

-- Auto read when file changed outside
autocmd({'FocusGained','BufEnter'}, { pattern='*', command='checktime' })

-- Open terminal in insert mode
autocmd('TermOpen', { pattern='*', command='startinsert' })

-- ==================== Plugins (lazy.nvim) ====================
require('lazy').setup({
  -- utilities
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-tree/nvim-web-devicons' },

  -- UI
  { 'nvim-tree/nvim-tree.lua', config = function()
      require('nvim-tree').setup({
        update_focused_file = { enable = true },
        view = { width = 30 },
      })
    end
  },
  { 'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
  { 'akinsho/bufferline.nvim', tag = '*', dependencies = 'nvim-tree/nvim-web-devicons' },

  -- Git
  { 'lewis6991/gitsigns.nvim', config = function()
      require('gitsigns').setup()
    end
  },

  -- LSP + completion
  { 'williamboman/mason.nvim', config = function() require('mason').setup() end },
  { 'williamboman/mason-lspconfig.nvim', dependencies = { 'williamboman/mason.nvim' } },
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/nvim-cmp', dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path' } },
  { 'L3MON4D3/LuaSnip' },

  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'lua', 'python', 'javascript', 'typescript', 'html', 'css', 'json' },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },

  -- Terminal
  { 'akinsho/toggleterm.nvim', config = function()
      require('toggleterm').setup{ size = 20, open_mapping = [[<leader>tt]], direction = 'tab' }
    end
  },

  -- Misc
  { 'junegunn/goyo.vim' },
  { 'github/copilot.vim' },
  { 'kamykn/spelunker.vim' },
})

-- ==================== Plugin configurations ====================
-- lualine
require('lualine').setup({ options = { theme = 'auto' } })

-- bufferline
require('bufferline').setup{}

-- gitsigns already set in plugin list

-- telescope basic setup
require('telescope').setup{}

-- toggleterm (already configured)

-- nvim-cmp (basic)
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

-- ==================== LSP Setup ====================

local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

-- Setup Mason
mason.setup()

-- Ensure desired LSP servers are installed
local servers = { 'pyright', 'ts_ls', 'bashls', 'jsonls', 'html', 'cssls' }
mason_lspconfig.setup({ ensure_installed = servers })

-- Define on_attach function for keymaps after LSP attaches to buffer
local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local map = vim.keymap.set
    map('n', 'gd', vim.lsp.buf.definition, opts)
    map('n', 'gy', vim.lsp.buf.type_definition, opts)
    map('n', 'gi', vim.lsp.buf.implementation, opts)
    map('n', 'gr', vim.lsp.buf.references, opts)
    map('n', '<leader>rn', vim.lsp.buf.rename, opts)
    map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
end

-- Setup capabilities for nvim-cmp
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Setup each LSP server using the new vim.lsp.config API
for _, server in ipairs(servers) do
    -- Get the server configuration name (some servers may have different names)
    local config_name = server
    
    -- Configure the server using vim.lsp.config
    vim.lsp.config[config_name] = {
        cmd = vim.lsp.config[config_name] and vim.lsp.config[config_name].cmd or nil,
        root_markers = vim.lsp.config[config_name] and vim.lsp.config[config_name].root_markers or nil,
        capabilities = capabilities,
    }
    
    -- Enable the LSP server with on_attach
    vim.lsp.enable(config_name, {
        on_attach = on_attach,
    })
end

-- ==================== Quality-of-life helpers (equivalents of your Vimscript) ====================
-- Visual selection search helper equivalent
function _G.visual_selection_search(direction)
  local _, start_row, start_col, _ = unpack(vim.fn.getpos("'<"))
  local _, end_row, end_col, _ = unpack(vim.fn.getpos("'>"))
  local lines = vim.api.nvim_buf_get_lines(0, start_row -1, end_row, false)
  if #lines == 0 then return end
  lines[1] = string.sub(lines[1], start_col)
  lines[#lines] = string.sub(lines[#lines], 1, end_col - (start_row==end_row and start_col-1 or 0))
  local query = table.concat(lines, '\n')
  query = vim.pesc(query)
  if direction == 'forward' then
    cmd('/' .. query)
  else
    cmd('?' .. query)
  end
end
map('v', '*', ':lua visual_selection_search("forward")<CR>', opts)
map('v', '#', ':lua visual_selection_search("backward")<CR>', opts)

-- Auto-close nvim-tree if it's the last window
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local nvim_tree = vim.api.nvim_buf_get_name(0):match("NvimTree_")
        if nvim_tree and vim.fn.winnr("$") == 1 then
            vim.cmd("quit")
        end
    end
})

-- Spellchecker disabled by default (you can toggle)
map('n', '<leader>ts', '<cmd>setlocal spell! spelllang=en_us<CR>', opts)

-- Quick tests mappings approximations
map('n', '<Leader>tn', '<cmd>TestNearest<CR>', { silent = true })
map('n', '<Leader>tf', '<cmd>TestFile<CR>', { silent = true })
map('n', '<Leader>ts', '<cmd>TestSuite<CR>', { silent = true })
map('n', '<Leader>tl', '<cmd>TestLast<CR>', { silent = true })
map('n', '<Leader>tg', '<cmd>TestVisit<CR>', { silent = true })

-- Copy full path to clipboard
map('n', '<leader>cp', '<cmd>let @+ = expand("%:p")<CR><cmd>echo "Copied file path!"<CR>', opts)

-- ==================== Final user tips ====================
-- 1) Place this file at ~/.config/nvim/init.lua
-- 2) Start Neovim; lazy.nvim will bootstrap and install plugins
-- 3) To install/update LSP servers: :Mason
-- 4) Use :PackerSync equivalent is handled by lazy.nvim automatically via :Lazy

-- End of file

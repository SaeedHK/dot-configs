-- Core options
local opt = vim.opt

-- General
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.updatetime = 100
opt.timeoutlen = 300
opt.ttimeoutlen = 10

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.termguicolors = true
opt.showmode = false
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 7
opt.colorcolumn = "99"
opt.foldcolumn = "1"
opt.cmdheight = 1
-- opt.lazyredraw = true  -- conflicts with Noice, only set temporarily

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Tabs & Indentation
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true
opt.autoindent = true
opt.wrap = true
opt.linebreak = true
opt.textwidth = 500

-- Completion
opt.completeopt = "menu,menuone,noselect"
opt.wildmenu = true
opt.wildignore:append({ "*.o", "*~", "*.pyc", "*/.git/*", "*/.DS_Store" })

-- Misc
opt.hidden = true
opt.backspace = "eol,start,indent"
opt.encoding = "utf-8"
opt.fileformats = "unix,dos,mac"
opt.history = 500
opt.magic = true
opt.showmatch = true
opt.matchtime = 2
opt.errorbells = false
opt.visualbell = false

-- RTL support (termbidi)
opt.termbidi = true

-- Disable perl provider
vim.g.loaded_perl_provider = 0

-- Auto read file changes
opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  pattern = "*",
  command = "checktime",
})

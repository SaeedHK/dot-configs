-- Keymaps
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Escape mappings
map("i", "jj", "<Esc>", opts)
map("i", "kk", "<Esc>", opts)

-- Fast saving/exit
map("n", "<leader>w", ":w!<CR>", opts)
map("n", "<leader>qq", ":q!<CR>", opts)
map("n", "<leader>dd", ":q!<CR>", opts)
map("n", "<leader>ss", ":x<CR>", opts)

-- Sudo save
vim.api.nvim_create_user_command("W", "execute 'w !sudo tee % > /dev/null' <bar> edit!", {})

-- Clear search highlight
map("n", "<leader><CR>", ":noh<CR>", opts)

-- Better navigation (HJKL remaps)
map({ "n", "v" }, "K", "{", opts)
map({ "n", "v" }, "J", "}", opts)
map({ "n", "v" }, "H", "^", opts)
map({ "n", "v" }, "L", "$", opts)

-- Restore lost functionality from HJKL remaps
map("n", "gj", "J", opts) -- Join lines
map("n", "gh", "H", opts) -- Screen top
map("n", "gl", "L", opts) -- Screen bottom

-- Tab/Shift-Tab for indent
map("n", "<Tab>", ">>", opts)
map("n", "<S-Tab>", "<<", opts)
map("v", "<Tab>", ">gv", opts)
map("v", "<S-Tab>", "<gv", opts)

-- Run macros with Q
map("n", "Q", "@q", opts)

-- Better yank/delete
map("n", "X", "v$x", opts)
map("v", "p", '"_dP', opts) -- Paste without yanking replaced text

-- Block selection
map("n", "vb", "<C-v>", opts)
map("n", "vv", "V", opts)
map("v", "ii", "I", opts)

-- Copy file path
map("n", "<leader>ff", ':let @+ = expand("%")<CR>', opts)

-- Copy word under cursor to clipboard
map("n", "<leader>yw", '"+yiw', opts)

-- Window navigation
map("n", "<C-h>", "<C-W>h", opts)
map("n", "<C-l>", "<C-W>l", opts)
map("n", "<C-j>", "<C-W>j", opts)
map("n", "<C-k>", "<C-W>k", opts)

-- Remap 0 to first non-blank (use g0 for actual column 0)
map("n", "0", "^", opts)
map("n", "g0", "0", opts)

-- Buffer management
map("n", "<leader>h", ":bprevious<CR>", opts)
map("n", "<leader>l", ":bnext<CR>", opts)
map("n", "<leader>bd", ":bd!<CR>", opts)
-- Splits
map("n", "<leader>sn", ":vnew<CR>", opts)
map("n", "<leader>sh", ":new<CR>", opts)

-- Open common files
map("n", "<leader>oe", ":e ./.env<CR>", opts)
map("n", "<leader>oz", ":e ~/.zshrc<CR>", opts)
map("n", "<leader>os", ":e ~/.ssh/config<CR>", opts)
map("n", "<leader>ov", ":e $MYVIMRC<CR>", opts)
map("n", "<leader>oc", function()
  require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
end, opts)

-- Reload config
map("n", "<leader>vr", ":source $MYVIMRC<CR>", opts)


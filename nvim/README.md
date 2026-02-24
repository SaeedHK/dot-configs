# Neovim Configuration

Modern Lua-based Neovim configuration using lazy.nvim plugin manager and native LSP.

## Requirements

- **Neovim >= 0.11.0** (uses native `vim.lsp.config` API)
- Git
- A [Nerd Font](https://www.nerdfonts.com/) (for icons)
- ripgrep (for Telescope live grep)
- fd (for Telescope find files)
- Node.js (for TypeScript/JavaScript LSP servers and DAP adapters)

### Optional (for additional LSP servers)

- **Ruby** (`gem`) - for ruby_lsp (uncomment in `lsp.lua`)
- **Haskell** (`ghcup`) - for hls
- **Python** (`pip`) - pyright is installed via npm

## Structure

```
~/.config/nvim/
├── init.lua                 # Entry point, lazy.nvim bootstrap
├── lua/
│   ├── core/
│   │   ├── options.lua      # Neovim options
│   │   └── keymaps.lua      # Key bindings
│   └── plugins/
│       ├── colorscheme.lua  # Catppuccin theme
│       ├── copilot.lua      # GitHub Copilot
│       ├── debug.lua        # DAP debugger (Python, JS/TS)
│       ├── editing.lua      # Autopairs, comment, surround, flash, undotree, grug-far
│       ├── git.lua          # Gitsigns, fugitive, lazygit
│       ├── harpoon.lua      # Quick file pinning and navigation
│       ├── lsp.lua          # Mason, native LSP, nvim-cmp, conform, trouble, inc-rename
│       ├── nvim-tree.lua    # File explorer
│       ├── telescope.lua    # Fuzzy finder
│       ├── terminal.lua     # Toggleterm floating terminal
│       ├── testing.lua      # Neotest
│       ├── treesitter.lua   # Syntax highlighting + context
│       └── ui.lua           # Lualine, which-key, noice, colorizer
```

## LSP Servers (auto-installed via Mason)

- `lua_ls` - Lua
- `ts_ls` - TypeScript/JavaScript
- `html` - HTML
- `cssls` - CSS
- `jsonls` - JSON
- `pyright` - Python
- `eslint` - JavaScript/TypeScript linting

### Disabled by default (uncomment in `lsp.lua` when dependencies are installed)

- `ruby_lsp` - Ruby (requires `gem`)
- `hls` - Haskell (requires `ghcup`)

## Key Bindings

Leader key: `<Space>`

### General

| Key | Action |
|-----|--------|
| `jj` / `kk` | Escape (insert mode) |
| `<leader>w` | Save file |
| `<leader>qq` | Quit without saving |
| `<leader>ss` | Save and quit |
| `<leader><CR>` | Clear search highlight |

### Navigation

| Key | Action |
|-----|--------|
| `H` | Beginning of line |
| `L` | End of line |
| `J` | Next paragraph |
| `K` | Previous paragraph |
| `<C-h/j/k/l>` | Window navigation |

### Flash (Motion)

Jump anywhere on screen in 2-3 keystrokes. After pressing the key, type the
characters you see on screen to jump directly to that position.

| Key | Mode | Action |
|-----|------|--------|
| `s` | normal/visual/operator | Flash jump — type chars to jump anywhere |
| `S` | normal/operator | Flash treesitter — jump to a syntax node |
| `r` | operator | Remote flash — apply operator at a remote location |
| `R` | operator/visual | Treesitter search across file |
| `<C-s>` | command | Toggle flash in `/` search mode |

**Example**: `ys` + flash label + `"` to surround a remote word with quotes.

### Harpoon (Quick File Pins)

Pin up to 4 frequently used files and jump between them instantly.

| Key | Action |
|-----|--------|
| `<leader>pa` | Pin current file |
| `<leader>pm` | Open pin menu (edit/reorder/remove) |
| `<M-1>` | Jump to pin 1 |
| `<M-2>` | Jump to pin 2 |
| `<M-3>` | Jump to pin 3 |
| `<M-4>` | Jump to pin 4 |

**Workflow**: Open your main files, pin each with `<leader>pa`, then jump between them with `<M-1>` through `<M-4>`.

### Undotree

Visualize the full undo history as a tree, not just a linear list. Navigate to
any past state, including branches you've abandoned.

| Key | Action |
|-----|--------|
| `<leader>u` | Toggle undotree panel |

Inside undotree panel: `j/k` to move, `<CR>` to restore that state, `q` to close.

### Grug-Far (Project Find & Replace)

Full-featured search and replace across the entire project with preview.

| Key | Action |
|-----|--------|
| `<leader>sr` | Open search & replace |
| `<leader>sw` | Search word under cursor |

Inside grug-far: fill in search/replace fields, then `<C-Enter>` to apply.
Supports ripgrep flags (e.g. `--type py` to limit to Python files).

### Trouble (Diagnostics Panel)

Browse diagnostics, references, and quickfix lists in a clean panel.

| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle workspace diagnostics |
| `<leader>xd` | Toggle document diagnostics |
| `<leader>xq` | Toggle quickfix list |
| `<leader>xl` | Toggle location list |
| `<leader>xs` | Toggle document symbols |

Inside trouble panel: `j/k` to navigate, `<CR>` to jump to location, `q` to close.

### Debugger (DAP)

Full debugging support for Python and JavaScript/TypeScript. The UI opens
automatically when a debug session starts.

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue / Start debugging |
| `<leader>dn` | Step over |
| `<leader>di` | Step into |
| `<leader>do` | Step out |
| `<leader>dq` | Terminate session |
| `<leader>du` | Toggle DAP UI manually |
| `<leader>de` | Evaluate expression (normal/visual) |

**Python**: Automatically detects virtualenv (`.venv/`, `venv/`, `$VIRTUAL_ENV`).
**JS/TS**: Uses `js-debug-adapter` (auto-installed via Mason). Supports node launch, attach, and Chrome.

### File Explorer (nvim-tree)

| Key | Action |
|-----|--------|
| `<C-n>` / `<C-t>` | Toggle file explorer |
| `<leader>m` / `<C-f>` | Find current file in tree |

### Telescope (Fuzzy Finder)

| Key | Action |
|-----|--------|
| `<leader>n` | Find files |
| `<leader>f` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fo` | Recent files |
| `<leader>fg` | Git status |
| `<leader>fc` | Git commits |
| `<leader>fs` | Document symbols |
| `<leader>fw` | Grep word under cursor |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `gt` | Go to type definition |
| `gK` | Hover documentation |
| `<leader>rn` | Rename (with live preview) |
| `<leader>ca` | Code action |
| `<leader>e` | Show diagnostics float |
| `[d` / `]d` | Previous/next diagnostic |
| `<leader>lf` | Format buffer |

### Git

| Key | Action |
|-----|--------|
| `<leader>gg` | Git status (fugitive) |
| `<leader>gs` | LazyGit |
| `<leader>gd` | Git diff |
| `<leader>gP` | Git push |
| `<leader>ga` | Stage hunk |
| `<leader>gu` | Undo stage hunk |
| `<leader>gb` | Blame line |
| `]c` / `[c` | Next/previous hunk |

### GitHub Copilot

| Key | Action |
|-----|--------|
| `<M-l>` | Accept suggestion |
| `<M-w>` | Accept word |
| `<M-e>` | Accept line |
| `<M-]>` / `<M-[>` | Next/previous suggestion |
| `<C-]>` | Dismiss suggestion |

### Testing

| Key | Action |
|-----|--------|
| `<leader>tn` | Run nearest test |
| `<leader>tf` | Run file tests |
| `<leader>ts` | Run test suite |
| `<leader>tl` | Run last test |
| `<leader>to` | Show test output |
| `<leader>tp` | Toggle output panel |
| `<leader>tS` | Toggle summary |

### Terminal

| Key | Action |
|-----|--------|
| `<C-\>` | Toggle floating terminal |
| `Esc` | Enter normal mode (navigate/select/yank) |
| `i` / `a` | Return to insert mode |

### Other

| Key | Action |
|-----|--------|
| `<leader>L` | Lazy plugin manager |
| `<leader>z` | Zen mode |
| `<leader>ov` | Open vim config |
| `<leader>vr` | Reload config |
| `Q` | Run macro @q |
| `<Tab>` / `<S-Tab>` | Indent/dedent |

## First Launch

1. Open Neovim — lazy.nvim will automatically install plugins
2. Run `:Mason` to manage LSP servers and DAP adapters
3. Run `:Lazy` to manage plugins
4. Run `:checkhealth` to verify setup
5. Run `:Copilot auth` to authenticate GitHub Copilot

## Included Plugins

- **Plugin Manager**: lazy.nvim
- **LSP**: mason.nvim, nvim-lspconfig, nvim-cmp, inc-rename.nvim
- **Completion**: nvim-cmp (insert + cmdline), luasnip, friendly-snippets
- **Diagnostics**: trouble.nvim
- **Syntax**: nvim-treesitter, nvim-treesitter-context
- **Fuzzy Finder**: telescope.nvim + fzf-native
- **File Explorer**: nvim-tree.lua
- **Motion**: flash.nvim
- **File Pins**: harpoon2
- **Undo**: undotree
- **Find & Replace**: grug-far.nvim
- **Debugger**: nvim-dap, nvim-dap-ui, nvim-dap-python, mason-nvim-dap
- **Git**: gitsigns.nvim, vim-fugitive, lazygit.nvim
- **UI**: lualine.nvim, catppuccin, noice.nvim, which-key.nvim, nvim-colorizer
- **Editing**: nvim-autopairs, Comment.nvim, nvim-surround, better-escape
- **Testing**: neotest (Python, RSpec, Jest, PHPUnit)
- **AI**: copilot.lua
- **Formatting**: conform.nvim
- **Terminal**: toggleterm.nvim

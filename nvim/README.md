# Neovim Configuration

Modern Lua-based Neovim configuration using lazy.nvim plugin manager.

## Requirements

- Neovim >= 0.9.0
- Git
- A [Nerd Font](https://www.nerdfonts.com/) (for icons)
- ripgrep (for Telescope live grep)
- Node.js (for some LSP servers)

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
│       ├── editing.lua      # Autopairs, comment, surround, zen-mode
│       ├── git.lua          # Gitsigns, fugitive, lazygit
│       ├── lsp.lua          # Mason, LSP, nvim-cmp, conform
│       ├── nvim-tree.lua    # File explorer
│       ├── telescope.lua    # Fuzzy finder
│       ├── testing.lua      # Neotest
│       ├── treesitter.lua   # Syntax highlighting
│       └── ui.lua           # Lualine, which-key, noice
```

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
| `<leader>fs` | Document symbols |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `gK` | Hover documentation |
| `<leader>rn` | Rename |
| `<leader>ca` | Code action |
| `<leader>e` | Show diagnostics |
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

### Testing

| Key | Action |
|-----|--------|
| `<leader>tn` | Run nearest test |
| `<leader>tf` | Run file tests |
| `<leader>ts` | Run test suite |
| `<leader>tl` | Run last test |
| `<leader>to` | Show test output |

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

1. Open Neovim - lazy.nvim will automatically install plugins
2. Run `:Mason` to manage LSP servers
3. Run `:Lazy` to manage plugins
4. Run `:checkhealth` to verify setup

## Included Plugins

- **Plugin Manager**: lazy.nvim
- **LSP**: mason.nvim, nvim-lspconfig, nvim-cmp
- **Syntax**: nvim-treesitter
- **Fuzzy Finder**: telescope.nvim
- **File Explorer**: nvim-tree.lua
- **Git**: gitsigns.nvim, vim-fugitive, lazygit.nvim
- **UI**: lualine.nvim, catppuccin, noice.nvim, which-key.nvim
- **Editing**: nvim-autopairs, Comment.nvim, nvim-surround
- **Testing**: neotest
- **AI**: copilot.lua
- **Formatting**: conform.nvim

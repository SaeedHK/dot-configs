" Saeed neovim config

call plug#begin("~/.vim/plugged")
  " Theme
  " Plug 'dracula/vim'
  " Plug 'mhartington/oceanic-next'

  " Language Client
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']

  " TypeScript Highlighting
  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'maxmellon/vim-jsx-pretty'


  " File Explorer with Icons
  Plug 'scrooloose/nerdtree'
  Plug 'ryanoasis/vim-devicons'

  " File Search
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  " Ruby/Rails
  " If you do `==` on a single line or a visual block vim will automatically ident your Rails files. Cool, isn’t it? Veery useful 🙂
  Plug 'vim-ruby/vim-ruby'
  Plug 'tpope/vim-rails'
  " Rubocop
  Plug 'sodapopcan/vim-rubocop'

  " AutoComplete
  Plug 'Shougo/neocomplete.vim'

  " Nix syntax color
  Plug 'LnL7/vim-nix'
  
  " Vim devicons 
  Plug 'ryanoasis/vim-devicons'

  " Lorem Ipsum
  Plug 'vim-scripts/loremipsum'

  " Emmet web dev completion
  Plug 'mattn/emmet-vim'

  " Elm highlighting
  Plug 'andys8/vim-elm-syntax'

  " Tailwind
  Plug 'iamcco/coc-tailwindcss',  {'do': 'yarn install --frozen-lockfile && yarn run build'}

  " TOML
  Plug 'cespare/vim-toml'

call plug#end()

" Enable theming support
if (has("termguicolors"))
 set termguicolors
endif

" Theme
syntax enable
" colorscheme dracula
" colorscheme OceanicNext
set number
syntax on
" let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 1

filetype plugin indent on
filetype on
filetype indent on

autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

nnoremap <C-r> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
" requires silversearcher-ag
" used to ignore gitignore files
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" open new split panes to right and below
set splitright
set splitbelow

" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>

" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" open terminal on ctrl+;
" uses zsh instead of bash
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" Set SPELLCHeCK YYAH
" set spell spelllang=en_ca

set clipboard=unnamedplus
:set colorcolumn=100
autocmd FileType latex,tex,md,markdown setlocal spell

" Disable Arrow keys in Normal mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

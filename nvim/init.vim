" Saeed neovim config
""""""""""""""""""""""""""""""
" => Key bindings
""""""""""""""""""""""""""""""
set termbidi
let g:loaded_perl_provider = 0

" Map Esc to JJ and KK
imap jj <Esc>
imap kk <Esc>

" turn terminal to normal mode with escape
tnoremap <S-Tab> <C-\><C-n>
tnoremap <Esc> <C-\><C-n>
tnoremap jj <C-\><C-n>
tnoremap kk <C-\><C-n>

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
nnoremap <space> <Nop>
let mapleader = ' '

" Fast saving/exit
nmap <leader>w :w!<cr>

""" Discard exiting from vim
""nmap <leader>q :q<cr>
nmap <leader>qq :q!<cr>
nmap <leader>xx :x<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Navigational keys
""nmap <Up>    <Nop>
""nmap <Down>  <Nop>
""nmap <Left>  <Nop>
""nmap <Right> <Nop>
map $ <Nop>
map ^ <Nop>
map { <Nop>
map } <Nop>
noremap K     {
noremap J     }
noremap H     ^
noremap L     $

" Insert mode navigational keys
""imap <Up>    <Nop>
""imap <Down>  <Nop>
""imap <Left>  <Nop>
""imap <Right> <Nop>
imap <C-k> <C-p>
imap <C-j> <C-n>
imap <C-l> <C-n><C-p>

" Tab and Shift-Tab to indent and de-indent
nmap >> <Nop>
nmap << <Nop>
vmap >> <Nop>
vmap << <Nop>
nnoremap <Tab>   >>
nnoremap <S-Tab> <<
vnoremap <Tab>   >><Esc>gv
vnoremap <S-Tab> <<<Esc>gv

" braces auto comletetion
inoremap { {}<Esc>ha
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
""inoremap " ""<Esc>ha
""inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha

" Run macro’s with Q
nnoremap Q @q

" y,d: set clipboard
" more info: https://stackoverflow.com/questions/3638542/any-way-to-delete-in-vim-without-overwriting-your-last-yank
nnoremap d "*d
nnoremap dd "*dd
nnoremap D "*D
nnoremap x "_x
nnoremap Y y$
nnoremap yw bywe

" Block selection"
nnoremap vv V
nnoremap vb <C-v>
vnoremap ii I

" If PUM (complete menu) is visible, then execute <C-y> (which selects an item), otherwise, do a normal tab.
inoremap <expr> <TAB> pumvisible() ? "<C-y>" : "<TAB>"

" Search mode
nnoremap <Leader>a /
nnoremap <Leader>fr :%s/find/replace/gc

" Copy path to clipboard
nmap <Leader>ff :let @+ = expand("%")<CR>

" Smart way to move between windows
map <C-h> <C-W>h
map <C-l> <C-W>l
map <C-j> <C-W>j
map <C-k> <C-W>k

" Remap VIM 0 to first non-blank character
map 0 ^

" buffer management

" Get list of all buffers
nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <Leader>d :bd!<CR>

nnoremap <Leader>h :bprevious<CR>
nnoremap <Leader>l :bnext<CR>
nnoremap <Leader>l :bnext<CR>
"" nnoremap <Leader>k :bfirst<CR>
"" nnoremap <Leader>j :blast<CR>

" Complementing Buffer flow with fzf
nnoremap <Leader>n :Files<CR>
nnoremap <Leader>f :Rg<CR>
nnoremap <Leader>rf :s/foo/bar/gc 

" Git
" thanks to https://www.reddit.com/r/vim/comments/21f4gm/best_workflow_when_using_fugitive/
"  
nnoremap <Leader>g :Git<space>
""nnoremap <Leader>ga :Git add %:p<CR><CR>
nnoremap <Leader>gg :vertical :Git<CR>
nnoremap <leader>gs :Magit<CR>
nnoremap <Leader>gp :Git push<CR>
""nnoremap <Leader>gc :Git commit -v -q<CR>
""nnoremap <Leader>gt :Git commit -v -q %:p<CR>
nnoremap <Leader>gd :vertical :Git diff<CR>
""nnoremap <Leader>ge :Git edit<CR>
""nnoremap <Leader>gr :Git read<CR>
""nnoremap <Leader>gw :Git write<CR><CR>
""nnoremap <Leader>gl :silent! Git log<CR>
""nnoremap <Leader>gm :Gmove<Space>
""nnoremap <Leader>gb :Git branch<Space>
nnoremap <Leader>go :Git checkout<Space>
nnoremap <Leader>gcm :Git checkout master<CR>
nnoremap <Leader>gcd :Git checkout dev<CR>
""nnoremap <Leader>gps :Dispatch! git push<CR>
""nnoremap <Leader>gpl :Dispatch! git pull<CR>
 
" Jump between hunks
""nmap <Leader>gn :GitGutterNextHunk<CR>
""nmap <Leader>gp :GitGutterPrevHunk<CR>
""
""" Hunk-add and hunk-revert for chunk staging
""nmap <Leader>ga :GitGutterStageHunk<CR>
""nmap <Leader>gu :GitGutterUndoHunk<CR>

" these mappings work well when Caps Lock is mapped to Ctrl
nmap <silent> <Leader>tn :TestNearest<CR>
nmap <silent> <Leader>tf :TestFile<CR>
nmap <silent> <Leader>ts :TestSuite<CR>
nmap <silent> <Leader>tl :TestLast<CR>
nmap <silent> <Leader>tg :TestVisit<CR>

" vim config file"
nmap <Leader>vr :source $MYVIMRC<CR>

set splitright
set splitbelow
set colorcolumn=99
set clipboard=unnamedplus
set updatetime=250
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
" "set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
set foldcolumn=1

" Spell checker
" set spell spelllang=en_us
set nospell


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

set scl=yes  " force the signcolumn to appear

"=============================== NERDTree
" Here are the basics of how to use the plugin:
"    Use the natural vim navigation keys hjkl to navigate the files.
"    Press o to open the file in a new buffer or open/close directory.
"    Press t to open the file in a new tab.
"    Press i to open the file in a new horizontal split.
"    Press s to open the file in a new vertical split.
"    Press p to go to parent directory.
"    Press r to refresh the current directory.
" let g:NERDTreeShowHidden = 1
" let g:NERDTreeMinimalUI = 1
" let g:NERDTreeIgnore = []
" let g:NERDTreeStatusline = ''
"
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Toggle
nnoremap <leader>b :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <Leader>m :NERDTreeFind<CR>

""nnoremap <leader>r :FZF<CR>
""let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let g:vimrubocop_keymap = 0
nmap <Leader>rr :RuboCop -a<CR>
nmap <Leader>ra :RuboCop -A<CR>
nmap <Leader>rt :Rufo<CR>
nmap <Leader>is :Isort<CR>

""STREEM""
nmap <Leader>ss :cd $STREEM_APP_ROOT<CR>

""OPEN ZSH CONFIG""
nmap <Leader>oz :e ~/.zshrc<CR>

""OPEN ALACRITY CONFIG""
nmap <Leader>oa :e ~/.config/alacritty/alacritty.yml<CR>

""OPEN VIM CONFIG""
nmap <Leader>ov :e $MYVIMRC<CR>

""OPEN TMUX CONFIG""
nmap <Leader>ot :e ~/.tmux.conf<CR>

""SPLITS
nmap <Leader>sn :vnew<CR>
nmap <Leader>sh :new<CR>

" Terminal -------------------------
" uses zsh instead of bash
function! OpenTerminal()
  tabnew term://zsh
endfunction

nnoremap <leader>tt :call OpenTerminal()<CR>
" move to insert mode while opening terminal
" start terminal in insert mode
autocmd TermOpen * startinsert

" Gitgutter-------------------------"
" Use fontawesome icons as signs
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'

let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2

" Spelunker
let g:spelunker_white_list_for_user = ['siret'
      \, 'tanphi'
      \, 'tan'
      \, 'phi'
      \, 'consigne'
      \, 'numericality'
      \, 'upsert'
      \, 'consigne'
      \, 'reactif'
      \, 'uuid'
      \, 'compteur'
      \, 'compteurs'
      \, 'xpath'
      \, 'cegedim'
      \, 'streem'
      \, 'webdriver'
      \, 'webelement'
      \, 'invoicing'
      \, 'conso'
      \, 'winshuttle'
      \, 'engie'
      \, 'capa'
      \, 'salesfocus'
      \, 'datadog'
      \, 'iban'
      \, 'invoicing'
      \, 'invoicings'
      \, 'linspace'
      \, 'linewidth'
      \, 'upsert'
      \, 'axios'
      \, 'omniAuth'
      \, 'saml'
      \, 'byebug'
      \, 'eventable'
      \, 'eventables'
      \, 'loadcurve'
      \, 'loadcurves'
      \, 'productible'
      \, 'unavailability'
      \, 'unavailabilities'
      \, 'emsys'
      \, 'tokenizer'
      \, 'pretrained'
      \, 'opex'
      \, 'generix'
      \]

" Testing
let g:test#javascript#cypress#options = 'run --headed'
" let test#ruby#rspec#executable = 'zeus rspec'

call plug#begin("~/.vim/plugged")

  " Language Client
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-eslint', 'coc-tsserver', 'coc-prettier', 'coc-pyright', 'coc-spell-checker']
  " Plug 'yaegassy/coc-pylsp', {'do': 'yarn install --frozen-lockfile'}
  autocmd FileType python let b:coc_root_patterns = ['.venv']

  " Plug 'yaegassy/coc-ruff', {'do': 'yarn install --frozen-lockfile'}

  "ALE
  ""Plug 'dense-analysis/ale'
  ""let g:ale_fixers = {'javascript': ['prettier', 'eslint'], 'haskell': ['ormolu']}
  ""let g:ale_fix_on_save = 1

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
  " If you do `==` on a single line or a visual block vim will utomatically ident your Rails files. Cool, isn’t it? Veery useful 🙂
  Plug 'vim-ruby/vim-ruby'
  Plug 'tpope/vim-rails'
  Plug 'ngmy/vim-rubocop'
  Plug 'ruby-formatter/rufo-vim'

  " AutoComplete
  " Plug 'Shougo/neocomplete.vim'
  " Plug 'ycm-core/YouCompleteMe'

  " TOML
  Plug 'cespare/vim-toml'

  " airline
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " git
  Plug 'tpope/vim-fugitive'
  " Plug 'airblade/vim-gitgutter'
  Plug 'jreybert/vimagit'

  " test
  Plug 'vim-test/vim-test'

  " Goyo
  Plug 'junegunn/goyo.vim'

  "Pyhton
  ""Plug 'vim-syntastic/syntastic'
  Plug 'fisadev/vim-isort'
  ""Plug 'stsewd/isort.nvim', { 'do': ':UpdateRemotePlugins' }

  Plug 'ttibsi/pre-commit.nvim'

  "" js imports
  " Plug 'ludovicchabant/vim-gutentags'
  Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install'}

  "Github Copilot
  Plug 'github/copilot.vim'

  " spell check
  Plug 'kamykn/spelunker.vim'

call plug#end()

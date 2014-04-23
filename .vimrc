" Don't bother with vi compatibility
set nocompatible

" Configure Vundle
filetype on " without this vim emits a zero exit status, later, because of :ft off
filetype off
filetype plugin indent on
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Install Vundle bundles
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
  source ~/.vimrc.bundles.local
endif

" Plugin settings
let g:ctrlp_match_window = 'order:ttb,max:10'
let g:ctrlp_clear_cache_on_exit=1
let g:NERDSpaceDelims=1
let g:gitgutter_enabled=1
let g:gitgutter_line_highlights=1
let g:nerdtree_tabs_open_on_console_startup=1
let delimitMate_expand_cr=1

" Enable syntax highlighting
syntax enable

set autoindent
set autoread                                                 " reload files when changed on disk, i.e. via `git checkout`
set backspace=2                                              " Fix broken backspace in some setups
set backupcopy=yes                                           " see :help crontab
set clipboard=unnamed                                        " yank and paste with the system clipboard
set directory-=.                                             " don't store swapfiles in the current directory
set encoding=utf-8
set expandtab                                                " expand tabs to spaces
set ignorecase                                               " case-insensitive search
set incsearch                                                " search as you type
set laststatus=2                                             " always show statusline
set list                                                     " show trailing whitespace
set listchars=tab:▸\ ,trail:▫
set number                                                   " show line numbers
set ruler                                                    " show where you are
set scrolloff=3                                              " show context above/below cursorline
set shiftwidth=4                                             " normal mode indentation commands use 4 spaces
set showcmd
set smartcase                                                " case-sensitive search if any caps
set softtabstop=4                                            " insert mode tab and backspace use 4 spaces
set tabstop=8                                                " actual tabs occupy 8 characters
set wildignore=log/**,node_modules/**,tmp/**
set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=longest,list,full
set si
set ai
set hlsearch                                                 " highlight all matches

" Enable basic mouse behavior such as resizing buffers.
set mouse=a
if exists('$TMUX')  " Support resizing in tmux
  set ttymouse=xterm2
endif

" keyboard shortcuts
let mapleader = ','
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <leader>l :Align
map <leader><leader> <C-^>
nmap <leader>a :Ack<space>
nmap <leader>f :NERDTreeFind<CR>
nmap <leader>t :tab split<CR><c-p>
nmap <leader>] :TagbarToggle<CR>
nmap <leader>n <plug>NERDTreeTabsToggle<CR>
nmap <leader>mn :nohlsearch<cr>

" Git bindings
nmap <leader>gs :Gstatus<CR>
nmap <leader>gt :GitGutterToggle<CR>
nmap <leader>gl :GitGutterLineHighlightsToggle<CR>
nmap <leader>gc :Gcommit -a<CR>
nmap <leader>gb :Gblame<CR>
nmap <leader>gd :Gdiff<CR>

" Shift-nav to navigate paragraphs
nmap <s-j> <s-}>
nmap <s-k> <s-{>

" Allow wrap breaking navigation
map j gj
map k gk

" Map 0 to be the first non blank character
map 0 ^

" Map jk/kj in insert mode to go to normal mode
inoremap jk <ESC>
inoremap kj <ESC>

" Better tabpage navigation
nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  let g:ackprg = 'ag --nogroup --column'

  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" md is markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
" ejs is html and js combination
au BufNewFile,BufRead *.ejs setfiletype html.js

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Fix Cursor in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Strip trailing whitespace on save
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Colours
set t_Co=256
set bg=dark
colorscheme distinguished

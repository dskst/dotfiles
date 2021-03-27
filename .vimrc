" visual
syntax on
set nu
set ruler
set cursorline
set showmatch
set list
set listchars=tab:>-,extends:<
set showcmd
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}] " char code"

" tab/indent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set smarttab
set backspace=indent,eol,start

" backup file
set nobackup
set noswapfile

" copy past
set clipboard+=unnamed

" search
set incsearch
set ignorecase
set smartcase
set hlsearch

" Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"" Plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surround' " surround
Plugin 'cohama/lexima.vim' " quote and more, auto complete
Plugin 'jiangmiao/auto-pairs' " Insert or delete brackets and more
Plugin 'airblade/vim-gitgutter' " git diff
Plugin 'scrooloose/nerdtree' " tree view
Plugin 'w0rp/ale' " lint
Plugin 'tpope/vim-repeat' " dot repeat
Plugin 'junegunn/fzf' " fzf
Plugin 'junegunn/fzf.vim' " fzf
Plugin 'tpope/vim-commentary' " comment out
Plugin 'vim-airline/vim-airline' " status bar
Plugin 'pangloss/vim-javascript'
Plugin 'sheerun/vim-polyglot' " language packs
Plugin 'godlygeek/tabular' " markdown
Plugin 'plasticboy/vim-markdown' " markdown

" /Vundle
call vundle#end()
filetype plugin indent on

" Map
source ~/.vimrc.keymap
map <C-n> :NERDTreeToggle<CR>

" Options
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 2

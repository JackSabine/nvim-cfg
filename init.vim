set nocompatible

" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

  Plug 'tomasiser/vim-code-dark'

  Plug 'adelarsq/vim-matchit'

  if has('nvim')

  endif

call plug#end()

colorscheme codedark
set relativenumber
set number
set ruler

set hlsearch
set incsearch
set ignorecase
set smartcase
set magic
set showmatch

set noerrorbells
set novisualbell
set t_vb=

set timeoutlen=300

set textwidth=100
set wrap

set scrolloff=2

set autoread

set history=200

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Tab expand
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set wildmenu
set path+=**

set syntax
filetype plugin indent on
set autoindent
set smartindent


" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

let mapleader=","
imap <Leader>, <Esc>
vmap <Leader>, <Esc>
nmap <Leader>RR :so ~/.config/nvim/init.vim<CR>
nmap <Leader>v "+p
nmap <Leader>V "+P
nmap <Leader>p "0p
nmap <Leader>P "0P
nmap <Leader>h :noh<CR>

nmap <Leader>y :set relativenumber<CR>
nmap <Leader>t :set norelativenumber<CR>

" Add line above or below the cursor
nmap oo o<Esc>
nmap OO O<Esc>

" Faster scrolling in normal and visual mode
nnoremap <C-e> 4<C-e>
nnoremap <C-y> 4<C-y>
vnoremap <C-e> 4<C-e>
vnoremap <C-y> 4<C-y>

" Use regex characters whenever searching
nnoremap / /\v

noh

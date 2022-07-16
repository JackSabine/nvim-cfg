set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Vim Plug                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

  Plug 'preservim/nerdtree'

  Plug 'gyim/vim-boxdraw'

  Plug 'rpdelaney/vim-sourcecfg'

  if has('nvim')
    Plug 'neovim/nvim-lspconfig'
  endif

call plug#end()

if has('nvim')
  lua require('jsabine.init')
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Buffer sets                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Should be installed with the Vin Plug snippet above
colorscheme codedark

" Line numbers and columns
set relativenumber
set number
set ruler

" Better searching settings
set hlsearch
set incsearch
set ignorecase
set smartcase
set magic
set showmatch

" Nobody likes bells...
set noerrorbells
set novisualbell
set t_vb=

set timeoutlen=300

" Auto-newline at x chars
set textwidth=100

" Prefer to wrap lines instead of trail to the right
set wrap

set scrolloff=2

set autoread

set history=200

set encoding=UTF-8

set shell=sh

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set t_BE=

" <TAB> -> 2 spaces
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Make :find recursive in :pwd
set wildmenu
set path+=**

" Let syntax scripts format/highlight code
syntax on
filetype plugin on
filetype indent on
set autoindent
set smartindent

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Leader remaps                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" O, Holy Comma!
let g:mapleader=","

" Two commas -> <Esc>
imap <Leader>, <Esc>
vmap <Leader>, <Esc>

" Reloading vim config is easy!
if has('nvim')
  nmap <Leader>RR :so ~/.config/nvim/init.vim<CR>
else
  nmap <Leader>RR :so ~/.vimrc<CR> 
endif

" Copy/Paste to system register (X11 clipboard)
nmap <Leader>c "+y
nmap <Leader>v "+p
nmap <Leader>V "+P

" Paste from yank instead of volatile register
nmap <Leader>p "0p
nmap <Leader>P "0P

nmap <Leader>xx :clo<CR>

" Quick nohighlight mapping
nmap <Leader>h :noh<CR>

" Replace words with content of yank register
nmap <Leader>rw diw"0P
nmap <Leader>rW diW"0P

" NERDTree binds
nmap <Leader>t :NERDTreeToggle<CR>
nmap <Leader>f :NERDTreeFind<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               General remaps                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Toggle between relative and absolute number lines
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunction

nnoremap <C-n> :call NumberToggle()<CR>

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

" Center the pattern search in the buffer
nnoremap n nzz
nnoremap N Nzz

noh

let mapleader = " " " map leader to Space
set background=dark
"set t_Co=256
set number relativenumber
set nocompatible 
set expandtab
set shiftwidth=4
set autoindent
set mouse=a

syntax on

call plug#begin()
"Plug 'sheerun/vim-polyglot'
Plug 'ghifarit53/tokyonight-vim'
"Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
call plug#end()

"Tokyo Night Theme 
set termguicolors

let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1

"colorscheme tokyonight

"Nerdtree Keybinds
"nnoremap <leader>f :NERDTreeFocus<CR>
"nnoremap <C-t> :NERDTree<CR>
"nnoremap <C-n> :NERDTreeToggle<CR>
"nnoremap <C-f> :NERDTreeFind<CR>

" Automatically close NERDTree when you open a file
"let NERDTreeQuitOnOpen=1

"set timeoutlen 500 " Set timeout length to 500 ms
map <C-s>     :w<CR>
map <leader>s :w<CR>
map <leader>k :q<CR>
map <leader>x :x<CR>
map <leader>b :buffers<CR>
map <leader>n :bnext<CR>
map <leader>p :bprev<CR>

:set number
inoremap ( ()<Left>
inoremap " ""<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap ' ''<Left>

:set autoindent
:set smarttab
:set tabstop=4
:set shiftwidth=4
:set expandtab
:set softtabstop=4

:set mouse=
:set mouse=v
:set mouse=n

call plug#begin()

Plug 'http://github.com/tpope/vim-surround'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/preservim/nerdtree'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/ap/vim-css-color'
Plug 'https://github.com/rafi/awesome-vim-colorschemes'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/tc50cal/vim-terminal'
Plug 'https://github.com/terryma/vim-multiple-cursors'
Plug 'https://github.com/preservim/tagbar'
Plug 'nordtheme/vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

:colorscheme nord

inoremap <expr> <TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"

nnoremap <C-f> :NERDTreeToggle<CR>
nnoremap <C-t> :TagbarToggle<CR>

nnoremap <C-S-h> :colorscheme nord<CR>
nnoremap <C-S-p> :colorscheme molokai<CR>
nnoremap <C-S-m> :colorscheme minimalist<CR>
nnoremap <C-S-g> :colorscheme gotham<CR>


nnoremap <C-z> :undo

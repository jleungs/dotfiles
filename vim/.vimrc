let mapleader = " "
syntax off
set background=dark
set ignorecase
" get line number on cursor, rest relative
set relativenumber
set number
" scroll when lines above/below and wrap text
set scrolloff=5
set textwidth=100
" indenting options
set autoindent
filetype plugin indent on
" configure tabwidth and insert spaces instead of tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" preserve visual selection after indent
vnoremap > >gv
vnoremap < <gv
" yank to system clipboard, requires vim compiled with +clipboard
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y
" restore cursor to last position on file open
augroup restore_cursor
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   execute "normal! g`\"" |
        \ endif
augroup END
" toggle spellcheck
set spelllang=en_gb
nnoremap <leader>s :set spell!<CR>
" tag jumping with ctags
command! MakeTags !ctags -R .
" recursive file search
set path+=**
set wildmenu
set wildoptions=pum,fuzzy
set wildmode=longest:full,full
set wildignorecase
nnoremap <leader>f :find 

let mapleader = " "
" get line number on cursor, rest relative
set relativenumber
set number
" scroll when 15 lines above/below and wrap text at 80
set scrolloff=15
set textwidth=80
" syntax on default, off certain files
syntax enable
filetype plugin on
" disable vi compatibility (emulation of old bugs)
set nocompatible
" indenting options
set autoindent
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" toggle colorcolumn at 80 on/off
nnoremap <leader>c :execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>
" set UTF-8 encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
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
" Set the colorscheme
set termguicolors
colorscheme lunaperche
set background=dark
" turn off syntax and autocompile latex docs
autocmd BufWritePost *.tex silent! execute "!pdflatex % >/dev/null 2>&1" | redraw!
autocmd! bufreadpost *.tex set syntax=off
" toggle spellcheck
set spelllang=en_gb
nnoremap <leader>s :set spell!<CR>
" finding files, fuzzy finding
set path+=**
set wildmenu
nnoremap <leader>f :find 
" tag jumping with ctags
command! MakeTags !ctags -R .

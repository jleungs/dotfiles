" basic settings
let mapleader = " "
set scrolloff=15
set relativenumber
set number
" syntax on default, off certain files
syntax on
" disable vi compatibility (emulation of old bugs)
set nocompatible
" use indentation of previous line
set autoindent
" use intelligent indentation 
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=4
set shiftwidth=4
set expandtab
" shift-tab for undo tab (4 spaces)
inoremap <S-Tab> <C-d>
" wrap lines at 80 chars
set textwidth=80
" toggle colorcolumn at 80 on/off
nnoremap <leader>c :execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>
" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
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
colorscheme quiet
set background=dark
" Apply syntax highlighting customizations
highlight Keyword gui=bold
highlight Constant guifg=#999999
highlight Normal guibg=#000000
highlight Visual guifg=#aaaaaa
highlight MatchParen guifg=#ffffff
" turn off syntax and autocompile latex docs
autocmd BufWritePost *.tex silent! execute "!pdflatex % >/dev/null 2>&1" | redraw!
autocmd! bufreadpost *.tex set syntax=off
" toggle spellcheck
set spelllang=en_gb
nnoremap <leader>s :set spell!<CR>

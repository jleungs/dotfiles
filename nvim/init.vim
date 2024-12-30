" Download latest neovim as an appimage:
"   curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
" LEADER
" --------------------------------------------------------------------------------
let g:mapleader = "\<Space>"
""" PLUGINS
" --------------------------------------------------------------------------------
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin()
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Install node: curl -sL install-node.vercel.app/lts | bash
    Plug 'lervag/vimtex'
    Plug 'nvim-orgmode/orgmode'
call plug#end()
""" PLUGINS CONFIG
" --------------------------------------------------------------------------------
" CoC
" --------------------------------------------------------------------------------
let g:coc_global_extensions = [
    \ 'coc-jedi', 'coc-pairs', 'coc-snippets', 'coc-clangd'
    \ ]
" tab completion for coc
" To make completion works like VSCode
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" :CocCommand snippets.editSnippets
imap <C-l> <Plug>(coc-snippets-expand)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)
" VimTeX
" --------------------------------------------------------------------------------
let g:vimtex_view_method = 'zathura'
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
let maplocalleader = ","
" nvim-orgmode
" --------------------------------------------------------------------------------
lua << EOF

require('orgmode').setup({
  org_agenda_files = {'~/sync/org/*'},
  org_default_notes_file = '~/sync/org/refile.org',
})
EOF
""" GENERAL CONFIG
" --------------------------------------------------------------------------------
filetype plugin indent on
syntax on
set encoding=utf-8
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set mouse=a
set number relativenumber
set ignorecase " ignore case when searching
" keep selected after changing indent
vnoremap > >gv
vnoremap < <gv
" Return to the same line you left off at
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   execute 'normal! g`"zvzz' |
        \ endif
augroup END
" cursor line
set cursorline

set spelllang=en_gb
colorscheme vim


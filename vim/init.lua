-- Options
vim.g.mapleader = ' '
vim.cmd.filetype("plugin indent on")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.termguicolors = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 10
vim.opt.spelllang = { 'en_gb' }
vim.opt.ignorecase = true
vim.opt.clipboard = "unnamedplus"
-- Remaps
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')
-- Toggle 'colorcolumn' at column 80
vim.keymap.set('n', '<leader>c', function()
    if vim.wo.colorcolumn == '' then
        vim.opt.colorcolumn = '80'
    else
        vim.opt.colorcolumn = ''
    end
end, { silent = true })
-- Colorscheme
vim.cmd.colorscheme('quiet')
vim.cmd.highlight({ 'Keyword', 'gui=bold' })
vim.cmd.highlight({ 'Comment', 'gui=italic' })
vim.cmd.highlight({ 'Constant', 'guifg=#999999' })
vim.cmd.highlight({ 'Normal', 'guibg=#000000' })
vim.cmd.highlight({ 'Visual', 'guifg=#aaaaaa' })
vim.cmd.highlight({ 'MatchParen', 'guifg=#ffffff' })
-- Remember last cursor position
vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
    pattern = { '*' },
    callback = function()
	vim.api.nvim_exec2('silent! normal! g`"zv', { output = false })
    end,
})
-- Buffers mappings
vim.keymap.set('n','<leader>%',':vsplit<CR>',{silent=true})
vim.keymap.set('n','<C-h>','<C-w>h',{silent=true})
vim.keymap.set('n','<C-j>','<C-w>j',{silent=true})
vim.keymap.set('n','<C-k>','<C-w>k',{silent=true})
vim.keymap.set('n','<C-l>','<C-w>l',{silent=true})

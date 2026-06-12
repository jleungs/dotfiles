local opt = vim.opt
local map = vim.keymap.set
vim.g.mapleader = ' '
-- Interface
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.cursorline = true
opt.scrolloff = 10
opt.termguicolors = true
-- Indentation
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 0       -- Use tabstop
opt.softtabstop = -1     -- Use effective shiftwidth
-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
-- Files and sessions
opt.undofile = true
opt.confirm = true
-- Splits
opt.splitright = true
opt.splitbelow = true
-- Spelling dictionary; spell checking remains disabled until toggled
opt.spelllang = { 'en_gb' }
-- Preserve selection after indentation
map('x', '>', '>gv')
map('x', '<', '<gv')
-- Explicit system-clipboard yanks
map({ 'n', 'x' }, '<leader>y', '"+y')
map('n', '<leader>Y', '"+Y')
-- Toggle column marker in the current window
map('n', '<leader>c', function()
    vim.wo.colorcolumn =
        vim.wo.colorcolumn == '' and '80' or ''
end, { silent = true })
-- Optional spelling toggle
map('n', '<leader>s', '<cmd>setlocal spell!<cr>', {silent = true})
-- Colorscheme
vim.cmd.colorscheme('quiet')
vim.cmd.highlight({ 'Keyword', 'gui=bold' })
vim.cmd.highlight({ 'Comment', 'gui=italic' })
vim.cmd.highlight({ 'Constant', 'guifg=#999999' })
vim.cmd.highlight({ 'Normal', 'guibg=#000000' })
vim.cmd.highlight({ 'Visual', 'guifg=#aaaaaa' })
vim.cmd.highlight({ 'MatchParen', 'guifg=#ffffff' })
-- Restore the last valid cursor position
vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.api.nvim_win_set_cursor(0, mark)
            vim.cmd('normal! zv')
        end
    end,
})
-- Window management
map('n', '<leader>%', '<cmd>vsplit<cr>', {silent = true})
map('n', '<C-h>', '<C-w>h', { desc = 'Window left' })
map('n', '<C-j>', '<C-w>j', { desc = 'Window below' })
map('n', '<C-k>', '<C-w>k', { desc = 'Window above' })
map('n', '<C-l>', '<C-w>l', { desc = 'Window right' })

-- options
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 10
vim.opt.spelllang = { "en_gb" }
vim.opt.ignorecase = true
vim.opt.colorcolumn = "80"
-- remaps
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- colorscheme
vim.cmd.colorscheme("quiet")
vim.cmd.highlight({ "Keyword", "gui=bold" })
vim.cmd.highlight({ "Comment", "gui=italic" })
vim.cmd.highlight({ "Constant", "guifg=#999999" })
vim.cmd.highlight({ "Normal", "guibg=#000000" })
vim.cmd.highlight({ "Visual", "guifg=#aaaaaa" })
vim.cmd.highlight({ "MatchParen", "guifg=#ffffff" })

-- lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup()

            -- set keymaps
            local keymap = vim.keymap

            keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
            keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy find recent files" })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "saghen/blink.cmp" },
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            -- Import the LSP config module
            local lspconfig = require("lspconfig")
            -- required for blink.cmp
            lspconfig['lua_ls'].setup({ capabilities = capabilities })
            -- Function to set up keymaps after LSP attaches to a buffer
            local on_attach = function(_, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }
                -- LSP key mappings
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)           -- Go to definition
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)          -- Go to declaration
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)           -- List references
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)       -- Go to implementation
                vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)       -- Rename symbol
                vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)         -- Go to previous diagnostic
                vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)         -- Go to next diagnostic
            end
            -- language servers
            lspconfig.pyright.setup({
                on_attach = on_attach,
            })
            lspconfig.texlab.setup({
                on_attach = on_attach,
            })
            end,
        },
        {
            "williamboman/mason.nvim",
            config = function()
                require("mason").setup({
                    ui = {
                        border = "rounded", -- Set the border style for the Mason UI
                        icons = {
                            package_installed = "✓",
                            package_pending = "➜",
                            package_uninstalled = "✗"
                        },
                    },
                    log_level = vim.log.levels.INFO,
                    max_concurrent_installers = 4, -- Limit concurrent installations
                })
            end,
        },
        {
            "williamboman/mason-lspconfig.nvim",
            config = function()
                require("mason-lspconfig").setup({
                    ensure_installed = { "pyright", "texlab", "clangd" }, -- Automatically install these servers
                    automatic_installation = true,
                })
            end,
        },
        {
            'saghen/blink.cmp',
            dependencies = { 'rafamadriz/friendly-snippets' },
            version = '1.*',

            opts = {
                keymap = { preset = 'default' },
                -- (Default) Only show the documentation popup when manually triggered
                completion = { documentation = { auto_show = false } },

                -- Default list of enabled providers defined so that you can extend it
                -- elsewhere in your config, without redefining it, due to `opts_extend`
                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer' },
                },

                fuzzy = { implementation = "prefer_rust_with_warning" }
            },
            opts_extend = { "sources.default" }
        },
        {
            "lervag/vimtex",
            lazy = false,     -- we don't want to lazy load VimTeX
            init = function()
                -- VimTeX configuration goes here, e.g.
                vim.g.vimtex_view_method = "zathura"
            end
        }
})


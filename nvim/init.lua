vim.o.number = true
vim.o.wrap = true
vim.o.termguicolors = true

vim.o.autoindent = true
vim.o.smarttab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.softtabstop = 4

vim.o.swapfile = false
vim.g.mapleader = " "

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>u', ':undo<CR>')

vim.keymap.set({'n', 'v'}, '<leader>y', '"+y<CR>')
vim.keymap.set({'n', 'v'}, '<leader>p', '"+p<CR>')

-- vim.pack.add({
--     {src = "https://github.com/catppuccin/nvim"},
--     -- {src = "https://github.com/echasnovski/mini.map"},
--     {src = 'https://github.com/neovim/nvim-lspconfig'},
-- })

-- require("mini.map").toggle()
vim.lsp.enable('pyright')
vim.lsp.enable('clangd')

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {},
  },
})

vim.lsp.config('asm-lsp', {
  filetypes = { 'asm', 's', 'S' },
})

vim.cmd [[
    call plug#begin()

    " Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'catppuccin/nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'mcchrish/nnn.vim'
    Plug 'aidyak/tokusa'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'nvim-tree/nvim-web-devicons'

    call plug#end()
]]

vim.g.hexmode = false

vim.keymap.set("n", "<leader>x", function()
  if not vim.g.hexmode then
    vim.cmd("%!xxd")
    vim.bo.filetype = "xxd"
    vim.g.hexmode = true
  else
    vim.cmd("%!xxd -r")
    vim.bo.filetype = ""
    vim.g.hexmode = false
  end
end, { desc = "Toggle hex view" })


-- vim.api.nvim_create_autocmd('LspAttach', {
--     callback = function(ev)
--         local client = vim.lsp.get_client_by_id(ev.data.client_id)
--         if client:supports_method('textDocument/completion') then
--             vim.lsp.enable(true, client.id, ev.buf, { autotrigger = true })
--         end
--     end,
-- })


-- vim.cmd("set completeopt+=noselect")


require('lualine').setup({
  options = {
    theme = 'auto',
    icons_enabled = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff' },
    lualine_c = { 'filename' },
    lualine_x = { 'diagnostics' },
    lualine_y = { 'encoding', 'fileformat', 'filetype' },
    lualine_z = { 'location' },
  },
})

vim.g['nnn#layout'] = {
    window = {
        width = 0.8,
        height = 0.8,
        highlight = "Debug"
    }
}

vim.keymap.set("n", "<leader>e", ":NnnPicker<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>E", ":NnnExplorer<CR>", { noremap = true, silent = true })

require("catppuccin").setup({
    flavour = "mocha",
    integrations = {
        -- coc_nvim = true,
        mini = true,
    }
})

vim.cmd("colorscheme catppuccin")

vim.keymap.set('i', '(', '()<Left>', { noremap = true, silent = true })
vim.keymap.set('i', '"', '""<Left>', { noremap = true, silent = true })
vim.keymap.set('i', '[', '[]<Left>', { noremap = true, silent = true })
vim.keymap.set('i', '{', '{}<Left>', { noremap = true, silent = true })
vim.keymap.set('i', "'", "''<Left>", { noremap = true, silent = true })

vim.keymap.set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true, noremap = true })
vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<C-h>"]], { expr = true, noremap = true })
vim.keymap.set("i", "<CR>", [[pumvisible() ? coc#_select_confirm() : "\<CR>"]], { expr = true, noremap = true, silent = true })

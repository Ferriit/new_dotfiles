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
    let g:loaded_netrw = 1
    let g:loaded_netrwPlugin = 1

    call plug#begin()

    " Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'catppuccin/nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'mcchrish/nnn.vim'
    Plug 'aidyak/tokusa'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'

    call plug#end()

    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
    \   'bg':      ['bg', 'Normal'],
    \   'hl':      ['fg', 'Comment'],
    \   'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \   'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \   'hl+':     ['fg', 'Statement'],
    \   'info':    ['fg', 'PreProc'],
    \   'border':  ['fg', 'Ignore'],
    \   'prompt':  ['fg', 'Conditional'],
    \   'pointer': ['fg', 'Exception'],
    \   'marker':  ['fg', 'Keyword'],
    \   'spinner': ['fg', 'Label'],
    \   'header':  ['fg', 'Comment'] }
    
    hi! link FzfNormal Normal
    hi! link FzfBorder Comment

    autocmd VimEnter * if isdirectory(argv(0)) | execute 'cd' argv(0) | call timer_start(50, {-> execute('Files')}) | endif
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
end)


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

vim.keymap.set("n", "<leader>f", ":NnnPicker<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>e", ":Files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>g", ":GFiles<CR>", { noremap = true, silent = true })

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

local cmp = require'cmp'
local luasnip = require'luasnip'

cmp.setup({
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
      else fallback() end
    end, { "i", "s" }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then luasnip.jump(-1)
      else fallback() end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  })
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local simple_servers = { 'pyright', 'clangd', 'asm_lsp' }
for _, server in ipairs(simple_servers) do
  vim.lsp.config(server, { capabilities = capabilities })
  vim.lsp.enable(server)
end

vim.lsp.config('rust_analyzer', {
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
      check = {
        command = "clippy",
      },
      -- If you just want it on/off, use: checkOnSave = true
    }
  }
})
vim.lsp.enable('rust_analyzer')

-- Show diagnostics in a floating window when cursor rests on them
vim.diagnostic.config({
  virtual_text = true,        -- inline error text
  signs = true,
  underline = true,
  update_in_insert = false,
  float = {
    border = "rounded",
    source = true,            -- shows which LSP reported the error
  },
})

-- Open diagnostic float on cursor hold
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { noremap = true, silent = true })

-- Or auto-show on CursorHold (cursor idle)
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

-- Hover docs / type info (press twice to enter the float and scroll)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true })

-- Code actions (suggestions/fixes)
vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { noremap = true, silent = true })

-- Optional but useful: go to definition, references
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { noremap = true, silent = true })

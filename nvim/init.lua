local vim = vim

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/completion-nvim'
  use 'anott03/nvim-lspinstall'

  use 'nvim-treesitter/nvim-treesitter'
  use 'sheerun/vim-polyglot'

  use {'prettier/vim-prettier', run= 'yarn install'}

  use {'npxbr/gruvbox.nvim', requires = {'rktjmp/lush.nvim'}}

  -- use 'lifepillar/vim-gruvbox8'
  -- use 'tjdevries/colorbuddy.nvim'
  -- use 'bkegley/gloombuddy'
  -- use 'mhartington/oceanic-next'

  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/telescope.nvim'
  use 'jremmen/vim-ripgrep'
  
  end
)

-- options

vim.g.colors_name = 'gruvbox'
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.gruvbox_contrast_dark = 'hard'
vim.o.syntax = 'on'
vim.o.errorbells = false
vim.o.smartcase = true
vim.o.showmode = false
vim.bo.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fn.stdpath('config') .. '/undodir'
vim.o.hidden = true
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.bo.autoindent = true
vim.bo.smartindent = true

vim.wo.number = true
vim.o.expandtab = true
vim.wo.relativenumber = true
vim.wo.wrap = false

vim.g.mapleader = ' '

-- treesitter settings --

local configs = require 'nvim-treesitter.configs'

configs.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  }
}

-- lsp settings --

local lspconfig = require'lspconfig'
local completion = require'completion'

local function custom_on_attach(client)
  print('Attaching to ' .. client.name)
  completion.om_attach(client)
end

local default_config = {
  on_attach = custom_on_attach,
}

-- setup language servers here
lspconfig.tsserver.setup(default_config)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)

-- Bindings

local key_mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
end

key_mapper('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
key_mapper('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>')
key_mapper('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
key_mapper('n', 'gw', ':lua vim.lsp.buf.document_symbol()<CR>')
key_mapper('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>')
key_mapper('n', 'gr', ':lua vim.lsp.buf.references()<CR>')
key_mapper('n', 'gt', ':lua vim.lsp.buf.type_definition()<CR>')
key_mapper('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
key_mapper('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>')
key_mapper('n', '<leader>af', ':lua vim.lsp.buf.code_action()<CR>')
key_mapper('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')

key_mapper('n', '<C-p>', ':lua require"telescope.builtin".find_files()<CR>')
key_mapper('n', '<leader>fs', ':lua require"telescope.builtin".live_grep()<CR>')
key_mapper('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
key_mapper('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')

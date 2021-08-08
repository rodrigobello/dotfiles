local vim = vim
local utils = require'chuan.utils'

local setup_mappings = function ()
   -- Completion
   vim.cmd[[inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"]]
   vim.cmd[[inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"]]
   vim.cmd[[inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"]]

   -- Diagnostics
   utils.key_mapper('n', '<leader>dn', ':lua vim.lsp.diagnostic.goto_next()<CR>')
   utils.key_mapper('n', '<leader>dp', ':lua vim.lsp.diagnostic.goto_prev()<CR>')
   utils.key_mapper('n', '<leader>ds', ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')

   -- LSP
   utils.key_mapper('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
   utils.key_mapper('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>')
   utils.key_mapper('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
   utils.key_mapper('n', 'gw', ':lua vim.lsp.buf.document_symbol()<CR>')
   utils.key_mapper('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>')
   utils.key_mapper('n', 'gr', ':lua vim.lsp.buf.references()<CR>')
   utils.key_mapper('n', 'gt', ':lua vim.lsp.buf.type_definition()<CR>')
   utils.key_mapper('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
   utils.key_mapper('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>')
   utils.key_mapper('n', '<leader>af', ':lua vim.lsp.buf.code_action()<CR>')
   utils.key_mapper('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')

   -- telescope
   utils.key_mapper('n', '<leader>ff', ':lua require"telescope.builtin".find_files()<CR>')
   utils.key_mapper('n', '<leader>fs', ':lua require"telescope.builtin".live_grep()<CR>')
   utils.key_mapper('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')

   utils.key_mapper('n', '<leader>gb', ':lua require"telescope.builtin".git_branches()<CR>')
   utils.key_mapper('n', '<leader>gc', ':lua require"telescope.builtin".git_commits()<CR>')
   utils.key_mapper('n', '<leader>gbc', ':lua require"telescope.builtin".git_buffer_commits()<CR>')
   utils.key_mapper('n', '<leader>gs', ':lua require"telescope.builtin".git_status()<CR>')

   utils.key_mapper('n', '<leader>fd', ':lua require"telescope.builtin".dotfiles()<CR>')


   utils.key_mapper('n', '<leader>ne', ':NERDTreeToggle<CR>')

   -- Misc
   utils.key_mapper('', '<up>', '<nop>')
   utils.key_mapper('', '<down>', '<nop>')
   utils.key_mapper('', '<left>', '<nop>')
   utils.key_mapper('', '<right>', '<nop>')
   utils.key_mapper('n', '<leader>bd', ':%bd|e#<CR>')
   utils.key_mapper('n', '<leader><leader>', ':b#<CR>')
end

setup_mappings()

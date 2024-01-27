vim.keymap.set('n', '<leader>ff', function() require("telescope.builtin").find_files() end, {noremap = true, silent = false, desc = "Telescope find files" });
vim.keymap.set('n', '<leader>fw', function() require("telescope.builtin").live_grep() end, {noremap = true, silent = false, desc = "Telescope live grep" });
vim.keymap.set('i', '<C-b>', '<C-w>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-Del>', '<C-o>dw', { noremap = true, silent = true })
vim.keymap.set('i', '<c-z>', '<c-o>u', { desc = "undo" });
vim.keymap.set('i', '<c-a>', '<c-o>:%y+<cr><cr>', {noremap = true, silent = false, desc = "select all in insert mode" });
vim.keymap.set('n', '<c-a>', ':%y+<cr><cr>', {noremap = true, silent = false, desc = "select all in normal mode" });
vim.keymap.set('i', '<c-]>', '<c-o>yiw' , {noremap = true, silent = false, desc = "select word in normal mode" });
vim.keymap.set('n', '<c-]>', 'yiw', { noremap = true, silent = false, desc = "select word in insert mode" });
vim.keymap.set('i', '<c-s>', '<c-o>:w<cr>', { noremap = true, silent = false, desc = "save buffer" });
vim.keymap.set('n', '|', '<cmd>vsplit<cr>', { noremap = true, silent = false, desc = "Vertical split" });
vim.keymap.set('n', '\\', '<cmd>split<cr>', { noremap = true, silent = false, desc = "Horizontal split" });
--
-- tresitter configuration
vim.treesitter.language.register('html', 'jsp'); -- use html parser for jsp 



local lspconfig = require('lspconfig')
lspconfig.tsserver.setup {}

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- mason installer configuration
--
require("mason-tool-installer").setup{
  ensure_installed = {
    "ast-grep",
    "js-debug-adapter",
    "lua-language-server",
    "rust-analyzer",
    "typescript-language-server"
  },
  run_on_start = true,
}


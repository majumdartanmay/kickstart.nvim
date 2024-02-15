vim.keymap.set('n', '<C-q>', '<cmd>qa!<cr>', {noremap = true, silent = false, desc = "Force quit" });
vim.keymap.set('n', '<leader>ff', function() require("telescope.builtin").find_files() end, {noremap = true, silent = false, desc = "Telescope find files" });
vim.keymap.set('n', '<leader>Ff', function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end, {noremap = true, silent = false, desc = "Telescope find files" });
vim.keymap.set('n', '<leader>fw', function() require("telescope.builtin").live_grep() end, {noremap = true, silent = false, desc = "Telescope live grep" });
vim.keymap.set('i', '<C-b>', '<C-w>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-Del>', '<C-o>dw', { noremap = true, silent = true })
vim.keymap.set('i', '<c-z>', '<c-o>u', { desc = "undo" });
vim.keymap.set('i', '<c-a>', '<c-o>:%y+<cr><cr>', {noremap = true, silent = false, desc = "select all in insert mode" });
vim.keymap.set('n', '<c-a>', ':%y+<cr><cr>', {noremap = true, silent = false, desc = "select all in normal mode" });
vim.keymap.set('n', '<c-]>', function() require("telescope.builtin").buffers() end, { noremap = true, silent = false, desc = "Open list of buffers" });
vim.keymap.set('i', '<c-s>', '<c-o>:w<cr>', { noremap = true, silent = false, desc = "save buffer" });
vim.keymap.set('n', '<c-s>', '<cmd>w<cr>', { noremap = true, silent = false, desc = "save buffer" });
vim.keymap.set('n', '|', '<cmd>vsplit<cr>', { noremap = true, silent = false, desc = "Vertical split" });
vim.keymap.set('n', '\\', '<cmd>split<cr>', { noremap = true, silent = false, desc = "Horizontal split" });
vim.keymap.set('n', '<C-h>', '<C-w><', { noremap = true, silent = false, desc = "Decrease window width" });
vim.keymap.set('n', '<C-l>', '<C-w>>', { noremap = true, silent = false, desc = "Increase window width" });
vim.keymap.set('n', '<leader>pa', function() vim.cmd([[:Lexplore]]) end, { noremap = true, silent = false, desc = "Will open Netrw in the current working directory." });
vim.keymap.set('n', '<leader>pd', function() vim.cmd([[:Lexplore %:p:h]]) end, { noremap = true, silent = false, desc = "Open Netrw in the directory of the current file." });
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
-- netw configurations
--
vim.cmd([[
let g:netrw_keepdir = 0
]])


vim.cmd([[
let g:netrw_winsize = 30
    ]])

vim.cmd([[
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
]])


vim.cmd([[
let g:netrw_localcopydircmd = 'cp -r'
]])

require("custom.plugins.config.harpoon");



vim.keymap.set('n', '<M-c>', function()
  local filePath = vim.api.nvim_buf_get_name(0);
  if filePath == "" then
    print("No buffer is open. Aborting copy-paste.");
    return;
  end
  print(("Copied: `%s`"):format(filePath))
  vim.fn.setreg("+", filePath)
end, { noremap = true, silent = true, desc = "Copy buffer path to clipboard" })

-- Primagen keymapping
-- https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

local function copy_buffer_path()
  local modify = vim.fn.fnamemodify
  local filePath = vim.api.nvim_buf_get_name(0);
  if filePath == "" then
    print("No buffer is open. Aborting copy-paste.");
    return;
  end
  local fileDir = modify(filePath, ":~");
  vim.fn.setreg("+", fileDir)
  print(("Copied: `%s`"):format(fileDir))
end

vim.keymap.set('n', '<M-C>', copy_buffer_path, { noremap = true, silent = true, desc = "Copy buffer directory path to clipboard" })

-- Configure tab space
vim.cmd([[:set tabstop=4]])
vim.cmd([[:set shiftwidth=4]])
vim.cmd([[:set expandtab]])

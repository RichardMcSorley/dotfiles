local homedir = os.getenv("HOME") or "~/"
vim.opt.undofile = true
vim.opt.undodir = homedir .. '/.vim/undo'
-- search as you type
vim.opt.incsearch = true
-- ingore case as you search
vim.opt.ignorecase = true
-- enable smartcase, allow for case sensitivity during search if you type capital letters.
vim.opt.smartcase = true

vim.g.javascript_conceal_function                  = "ƒ"
vim.g.javascript_conceal_null                      = "ø"
vim.g.javascript_conceal_this                      = "@"
vim.g.javascript_conceal_return                    = "⇚"
vim.g.javascript_conceal_undefined                 = "¿"
vim.g.javascript_conceal_NaN                       = "ℕ"
vim.g.javascript_conceal_prototype                 = "¶"
vim.g.javascript_conceal_static                    = "•"
vim.g.javascript_conceal_super                     = "Ω"
vim.g.javascript_conceal_arrow_function            = "⇒"
vim.g.javascript_conceal_noarg_arrow_function      = "🞅"
vim.g.javascript_conceal_underscore_arrow_function = "🞅"
vim.g.typescript_conceal_function                  = "ƒ"
vim.g.typescript_conceal_null                      = "ø"
vim.g.typescript_conceal_undefined                 = "¿"
vim.g.typescript_conceal_this                      = "@"
vim.g.typescript_conceal_return                    = "⇚"
vim.g.typescript_conceal_prototype                 = "¶"
vim.g.typescript_conceal_super                     = "Ω"

vim.o.concealcursor = ''
vim.o.conceallevel  = 2

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<F10>", function()
  if vim.o.conceallevel > 0 then
    vim.o.conceallevel = 0
  else
    vim.o.conceallevel = 2
  end
end, opts)

vim.keymap.set("n", "<F11>", function()
  if vim.o.concealcursor == "n" then
    vim.o.concealcursor = ""
  else
    vim.o.concealcursor = "n"
  end
end, opts)

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"
-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- inoremap jk <ESC>
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', { noremap = true, silent = true })
-- " comment out code
vim.api.nvim_set_keymap('v', '++', "<plug>NERDCommenterToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '++', "<plug>NERDCommenterToggle<CR>", { noremap = true, silent = true })
lvim.keys.normal_mode = {
  -- Page down/up
  ["[d"] = "<PageUp>",
  ["]d"] = "<PageDown>",

  -- Navigate buffers
  ["<Tab>"] = ":bnext<CR>",
  ["<S-Tab>"] = ":bprevious<CR>",
  ["te"] = ":tabedit",
  ["tc"] = ":BufferKill<CR>",
}

lvim.builtin.which_key.mappings["tP"] = {
  "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Projects"
}

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.terminal.shell = '/usr/local/bin/bash'
vim.o.shell = '/usr/local/bin/bash'
lvim.builtin.nvimtree.setup.actions.open_file.resize_window = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.view.width = 40
lvim.builtin.nvimtree.setup.view.relativenumber = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- Additional Plugins
lvim.plugins = {
  { "prettier/vim-prettier" },
  { "scrooloose/nerdcommenter" },
  { "chaoren/vim-wordmotion" },
  { "lukas-reineke/indent-blankline.nvim" },
  { "kazhala/close-buffers.nvim" },
  { "fedepujol/move.nvim" },
  { "windwp/nvim-ts-autotag" },
  { "sheerun/vim-polyglot" },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "olimorris/persisted.nvim",
    --module = "persisted", -- For lazy loading
    config = function()
      require("persisted").setup({
        use_git_branch = true,
        autoload = true,
      })
      require("telescope").load_extension("persisted") -- To load the telescope extension
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
}

require 'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  }
}
require('nvim-ts-autotag').setup()

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    virtual_text = {
      spacing = 5,
      severity_limit = 'Warning',
    },
    update_in_insert = true,
  }
)
-- setup indent-blankline
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")
require("indent_blankline").setup {
  show_end_of_line = true,
  show_current_context = true,
  space_char_blankline = " ",
}

-- setup move.nvim
vim.api.nvim_set_keymap('n', '<A-j>', ":MoveLine(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-k>', ":MoveLine(-1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-j>', ":MoveBlock(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-k>', ":MoveBlock(-1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-l>', ":MoveHChar(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-h>', ":MoveHChar(-1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-l>', ":MoveHBlock(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-h>', ":MoveHBlock(-1)<CR>", { noremap = true, silent = true })

-- setup buffer close-buffers
require('close_buffers').setup({
  preserve_window_layout = { 'this' },
  next_buffer_cmd = function(windows)
    require('bufferline').cycle(1)
    local bufnr = vim.api.nvim_get_current_buf()

    for _, window in ipairs(windows) do
      vim.api.nvim_win_set_buf(window, bufnr)
    end
  end,
})

lvim.builtin.which_key.mappings["T"] = {
  name = "Close Tabs",
  h = { "<cmd>lua require('close_buffers').delete({type = 'hidden', force= true })<CR>", "Close non-visible buffers" },
}

lvim.builtin.terminal.direction = 'float'

-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "tokyonight"
lvim.builtin.terminal.direction = 'horizontal'
lvim.builtin.rooter.active = false
lvim.builtin.terminal.direction= 'float'

vim.cmd('set clipboard="')
vim.cmd('set autochdir')
vim.cmd('set list lcs=tab:\\|\\ ')
pcall(vim.cmd,'command R RnvimrToggle')

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"]   = "<CMD>w<cr>"
lvim.keys.normal_mode["<"]       = "<<_"
lvim.keys.normal_mode[">"]       = ">>_"
lvim.keys.normal_mode['<Up>']    = '<C-y>'
lvim.keys.normal_mode['<Down>']  = '<C-e>'
lvim.keys.normal_mode['<S-h>']   = 'H'
lvim.keys.normal_mode['<S-l>']   = 'L'
lvim.keys.normal_mode['<M-l>']   = '<CMD>BufferNext<CR>'
lvim.keys.normal_mode['<M-h>']   = '<CMD>BufferPrevious<CR>'
lvim.keys.normal_mode['<M-C-H>'] = '<CMD>BufferMovePrevious<CR>'
lvim.keys.normal_mode['<M-C-L>'] = '<CMD>BufferMoveNext<CR>'
lvim.keys.normal_mode['<Tab>']   = '<CMD>BufferNext<CR>'
lvim.keys.normal_mode['<S-Tab>'] = '<CMD>BufferPrevious<CR>'

-- debug
lvim.keys.normal_mode['<F12>']  = '<Cmd>lua require"dap".step_out()<CR>'
lvim.keys.normal_mode['<F10>']  = '<Cmd>lua require"dap".step_over()<CR>'
lvim.keys.normal_mode['<F5>']   = '<Cmd>lua require"dap".continue()<CR>'
lvim.keys.normal_mode['<F6>']   = '<Cmd>lua require"dap".repl.toggle()<CR>'
lvim.keys.normal_mode['<F9>']   = '<Cmd>lua require"dap".toggle_breakpoint()<CR>'
lvim.keys.normal_mode['<S-F9>'] = '<Cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>'
lvim.keys.normal_mode['<F3>']   = '<Cmd>lua require"dap".close(); require"dapui".close()<CR>'
lvim.keys.normal_mode['<F11>']  = '<Cmd>lua require"dap".step_into()<CR>'


-- lvim.keys.normal_mode['gi'] = 'gi'

lvim.keys.term_mode['<C-r>'] = '<CMD>RnvimrToggle<CR>'
lvim.keys.term_mode['<Esc>'] = '<C-\\><C-n>'

lvim.keys.visual_block_mode['J'] = 'J'
lvim.keys.normal_mode['J'] = 'J'

-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Projects" }
local aling_map = {
  name = "+Align Text",
  [':'] = { "<cmd>Tab /:<cr>", "Align using :" },
  [','] = { "<cmd>Tab /,<cr>", "Align using ," },
  ['='] = { "<cmd>Tab /=<cr>", "Align using =" },
  ['|'] = { "<cmd>Tab /|<cr>", "Align using |" },
  [' '] = { "<cmd>Tab / <cr>", "Align using <Space>" },
  [';'] = { "<cmd>Tab /;<cr>", "Align using ;" },
}

lvim.builtin.which_key.vmappings['a'] = aling_map
lvim.builtin.which_key.mappings["a"] = aling_map

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.dap.active = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- set a formatter if you want to override the default lsp one (if it exists)
-- lvim.lang.python.formatters = {
--   {
--     exe = "black",
--     args = {}
--   }
-- }
-- set an additional linter
-- lvim.lang.python.linters = {
--   {
--     exe = "flake8",
--     args = {}
--   }
-- }

-- Additional Plugins
lvim.plugins = {
  {"ghifarit53/tokyonight-vim"},
  {"kevinhwang91/rnvimr"},
  {"godlygeek/tabular"},
  {"Vimjas/vim-python-pep8-indent"},
  {"tpope/vim-obsession"},
  {
    "rcarriga/nvim-dap-ui",
    config = function ()
      require('dapui').setup()
    end
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function ()
      require'lsp_signature'.on_attach()
    end,
    event = 'InsertEnter'
  },
  {
    "CRAG666/code_runner.nvim",
    config = function ()
      require('code_runner').setup {
        term = {
          position = "bel",
          size = 15
        },
        map = "<leader>r",
        json_path = "/home/henrique/.config/lunarvim/code_runner.json"
      }
    end
  }
}

-- dap configurations
local status, dap = pcall(require,'dap')

if status == true
  then
  dap.adapters.python = {
    type = 'executable';
    command = 'python3';
    args = { '-m', 'debugpy.adapter' };
  }

  dap.configurations.python = {
    {
      -- The first three options are required by nvim-dap
      type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
      request = 'launch';
      name = "Launch file";

      -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

      program = "${file}";
      pythonPath = 'python3'
    },
  }
end

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  -- { "BufEnter", "*", "lua require'completion'.on_attach()" },
  { "BufEnter", "*.py", "setlocal noexpandtab tabstop=4" },
  { "FileType", "python", "setlocal noexpandtab" },
  { "FileType", "rnvimr", "tnoremap <buffer>  " },
  { "FileType", "toggleterm", "tnoremap <buffer>  " },
  { "FileType", "python", "setlocal tabstop=4" },
}

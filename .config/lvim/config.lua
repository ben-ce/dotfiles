--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "tokyonight"
lvim.format_on_save = false
vim.opt.fillchars = vim.opt.fillchars + 'diff:╱'

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = "horizontal"
lvim.builtin.terminal.shading_factor = nil
lvim.builtin.nvimtree.setup.view.side = "left"
-- lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.treesitter.matchup = { enable = true }
lvim.builtin.gitsigns.opts.signs = {
  add = { text = "▌" },
  change = { text = "▌" },
}

-- lualine statusline theme setup
lvim.builtin.lualine.options = {
  theme = "auto",
}

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

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
-- lvim.plugins = {
--     {"folke/tokyonight.nvim"},
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }
-- local cb = require 'diffview.config'.diffview_callback

lvim.plugins = {
  { "rmehri01/onenord.nvim" },
  { "folke/tokyonight.nvim" },
  { "andersevenrud/nordic.nvim" },
  { "EdenEast/nightfox.nvim" },
  { "RRethy/vim-illuminate" },
  { "sindrets/diffview.nvim",
    event = "BufRead",
  },
  --   config = function()
  --     require("diffview").setup {
  --       diff_binaries = false, -- Show diffs for binaries
  --       enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
  --       use_icons = true, -- Requires nvim-web-devicons
  --       icons = { -- Only applies when use_icons is true.
  --         folder_closed = "",
  --         folder_open = "",
  --       },
  --       signs = {
  --         fold_closed = "",
  --         fold_open = "",
  --       },
  --       file_panel = {
  --         position = "left", -- One of 'left', 'right', 'top', 'bottom'
  --         width = 35, -- Only applies when position is 'left' or 'right'
  --         height = 10, -- Only applies when position is 'top' or 'bottom'
  --         listing_style = "tree", -- One of 'list' or 'tree'
  --         tree_options = { -- Only applies when listing_style is 'tree'
  --           flatten_dirs = true, -- Flatten dirs that only contain one single dir
  --           folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
  --         },
  --       },
  --       file_history_panel = {
  --         position = "bottom",
  --         width = 35,
  --         height = 16,
  --         log_options = {
  --           max_count = 256, -- Limit the number of commits
  --           follow = false, -- Follow renames (only for single file)
  --           all = false, -- Include all refs under 'refs/' including HEAD
  --           merges = false, -- List only merge commits
  --           no_merges = false, -- List no merge commits
  --           reverse = false, -- List commits in reverse order
  --         },
  --       },
  --       default_args = { -- Default args prepended to the arg-list for the listed commands
  --         DiffviewOpen = {},
  --         DiffviewFileHistory = {},
  --       },
  --       hooks = {}, -- See ':h diffview-config-hooks'
  --       key_bindings = {
  --         disable_defaults = false, -- Disable the default key bindings
  --         -- The `view` bindings are active in the diff buffers, only when the current
  --         -- tabpage is a Diffview.
  --         view = {
  --           ["<tab>"]      = cb("select_next_entry"), -- Open the diff for the next file
  --           ["<s-tab>"]    = cb("select_prev_entry"), -- Open the diff for the previous file
  --           ["gf"]         = cb("goto_file"), -- Open the file in a new split in previous tabpage
  --           ["<C-w><C-f>"] = cb("goto_file_split"), -- Open the file in a new split
  --           ["<C-w>gf"]    = cb("goto_file_tab"), -- Open the file in a new tabpage
  --           ["<leader>e"]  = cb("focus_files"), -- Bring focus to the files panel
  --           ["<leader>b"]  = cb("toggle_files"), -- Toggle the files panel.
  --         },
  --         file_panel = {
  --           ["j"]             = cb("next_entry"), -- Bring the cursor to the next file entry
  --           ["<down>"]        = cb("next_entry"),
  --           ["k"]             = cb("prev_entry"), -- Bring the cursor to the previous file entry.
  --           ["<up>"]          = cb("prev_entry"),
  --           ["<cr>"]          = cb("select_entry"), -- Open the diff for the selected entry.
  --           ["o"]             = cb("select_entry"),
  --           ["<2-LeftMouse>"] = cb("select_entry"),
  --           ["-"]             = cb("toggle_stage_entry"), -- Stage / unstage the selected entry.
  --           ["S"]             = cb("stage_all"), -- Stage all entries.
  --           ["U"]             = cb("unstage_all"), -- Unstage all entries.
  --           ["X"]             = cb("restore_entry"), -- Restore entry to the state on the left side.
  --           ["R"]             = cb("refresh_files"), -- Update stats and entries in the file list.
  --           ["<tab>"]         = cb("select_next_entry"),
  --           ["<s-tab>"]       = cb("select_prev_entry"),
  --           ["gf"]            = cb("goto_file"),
  --           ["<C-w><C-f>"]    = cb("goto_file_split"),
  --           ["<C-w>gf"]       = cb("goto_file_tab"),
  --           ["i"]             = cb("listing_style"), -- Toggle between 'list' and 'tree' views
  --           ["f"]             = cb("toggle_flatten_dirs"), -- Flatten empty subdirectories in tree listing style.
  --           ["<leader>e"]     = cb("focus_files"),
  --           ["<leader>b"]     = cb("toggle_files"),
  --         },
  --         file_history_panel = {
  --           ["g!"]            = cb("options"), -- Open the option panel
  --           ["<C-A-d>"]       = cb("open_in_diffview"), -- Open the entry under the cursor in a diffview
  --           ["y"]             = cb("copy_hash"), -- Copy the commit hash of the entry under the cursor
  --           ["zR"]            = cb("open_all_folds"),
  --           ["zM"]            = cb("close_all_folds"),
  --           ["j"]             = cb("next_entry"),
  --           ["<down>"]        = cb("next_entry"),
  --           ["k"]             = cb("prev_entry"),
  --           ["<up>"]          = cb("prev_entry"),
  --           ["<cr>"]          = cb("select_entry"),
  --           ["o"]             = cb("select_entry"),
  --           ["<2-LeftMouse>"] = cb("select_entry"),
  --           ["<tab>"]         = cb("select_next_entry"),
  --           ["<s-tab>"]       = cb("select_prev_entry"),
  --           ["gf"]            = cb("goto_file"),
  --           ["<C-w><C-f>"]    = cb("goto_file_split"),
  --           ["<C-w>gf"]       = cb("goto_file_tab"),
  --           ["<leader>e"]     = cb("focus_files"),
  --           ["<leader>b"]     = cb("toggle_files"),
  --         },
  --         option_panel = {
  --           ["<tab>"] = cb("select"),
  --           ["q"]     = cb("close"),
  --         },
  --       },
  --     }
  --   end
  -- },

  { "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require("neoscroll").setup {
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
      }
    end,
  },

  { "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("indent_blankline").setup {
        -- for example, context is off by default, use this to turn it on
        char = "▏",
        filetype_exclude = { "help", "terminal", "dashboard" },
        buftype_exclude = { "terminal" },
        blankline_indent = false,
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = false,
        show_first_indent_level = false,
      }
    end,
  },
  -- {"andymass/vim-matchup",
  --   event = "CursorMoved",
  --   config = function()
  --     vim.g.matchup_matchparen_offscreen = { method = "popup" }
  --   end,
  -- },
  { "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require "lsp_signature".setup()
    end,
  },
  { "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
  },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

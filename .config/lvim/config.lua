-- general Neovim level options
vim.opt.fillchars = vim.opt.fillchars
	+ {
		fold = " ",
		eob = " ", -- suppress ~ at EndOfBuffer
		diff = "╱", -- alternatives = ⣿ ░ ─
		foldsep = " ",
		foldopen = "",
		foldclose = "",
	}

vim.opt.diffopt:append("vertical")
vim.opt.wrap = true -- set line wrap
vim.opt.relativenumber = true -- enable rnu
vim.opt.clipboard = "" -- unset neovim clipboard so it doesn't have access to system clipboard

-- fold options
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldlevel = 2
vim.wo.foldcolumn = "2"
vim.wo.foldtext =
	[[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.wo.foldnestmax = 3
vim.wo.foldminlines = 1

-- LunarVim log level option
lvim.log.level = "info"
-- LunarVim format on save option
lvim.format_on_save.enabled = true

-- Colorscheme config
lvim.colorscheme = "tokyonight-storm"
-- lvim.colorscheme = "onedark"
-- lvim.colorscheme = "catppuccin-frappe"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- Map H, L to buffer cycle
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- Map n, N, *, #, g*, g# to center cursor with zz and start hlslens search count virtualtext
vim.api.nvim_set_keymap(
	"n",
	"n",
	"<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zz",
	{ silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"N",
	"<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zz",
	{ silent = true }
)
vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>zz]], { silent = true })
vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>zz]], { silent = true })
vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>zz]], { silent = true })
vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>zz]], { silent = true })

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
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
	name = " 飯Trouble",
	r = { "<cmd>Trouble lsp_references<cr>", "References" },
	f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
	q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	l = { "<cmd>Trouble loclist<cr>", "LocationList" },
	w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
}

lvim.builtin.which_key.mappings["D"] = {
	name = "  DiffView",
	o = { "<cmd>DiffviewOpen<cr>", "Open" },
	c = { "<cmd>DiffviewClose<cr>", "Close" },
	f = { "<cmd>DiffviewToggleFiles<cr>", "Toggle Files" },
}

lvim.builtin.which_key.mappings["S"] = { "<cmd>SymbolsOutline<cr>", "SymbolsOutline" }
-- Harpoon keymappings
lvim.builtin.which_key.mappings["<leader>"] = {
	name = "  Harpoon",
	["<leader>"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", " Toggle Quick Menu" },
	a = { "<cmd>lua require('harpoon.mark').add_file()<CR>", " Add Mark" },
}
lvim.keys.normal_mode["<C-Space>"] = "<cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>"
lvim.builtin.which_key.mappings["sm"] = {
	"<cmd>lua require'telescope'.extensions.harpoon.marks{}<CR>",
	"Harpoon Marks",
}

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = "horizontal"
lvim.builtin.terminal.shading_factor = nil
lvim.builtin.bufferline.options.always_show_bufferline = true

-- Telescope plugin callback to load extra plugins. Enable if dressing is not used
-- lvim.builtin.telescope.on_config_done = function(telescope)
-- 	pcall(telescope.load_extension, "ui-select")
-- 	-- any other extensions loading
-- end

-- NvimTree settings
lvim.builtin.nvimtree.setup.view.number = true
lvim.builtin.nvimtree.setup.view.relativenumber = true
lvim.builtin.nvimtree.setup.open_on_setup_file = true
lvim.builtin.nvimtree.setup.open_on_setup = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.actions.open_file.resize_window = true
lvim.builtin.nvimtree.setup.hijack_directories = {
	enable = true,
	auto_open = true,
}

lvim.builtin.treesitter.matchup = { enable = true }
lvim.builtin.gitsigns.opts.signs = {
	add = { text = "▌" },
	change = { text = "▌" },
}

-- lualine statusline theme setup
lvim.builtin.lualine.options = {
	theme = "auto",
	component_separators = { left = "", right = "" },
	section_separators = { left = "", right = "" },
}

local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.sections = {
	lualine_a = {
		"mode",
	},
	lualine_b = {
		components.filename,
		components.branch,
	},
	lualine_x = {
		"searchcount",
		components.diagnostics,
		components.treesitter,
		components.lsp,
		components.filetype,
		components.encoding,
		components.spaces,
		"filesize",
	},
	lualine_y = {
		components.location,
	},
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
	"toml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
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

-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-width", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- LSP settings
-- Rust
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
local codelldb_adapter = {
	type = "server",
	port = "${port}",
	executable = {
		command = mason_path .. "bin/codelldb",
		args = { "--port", "${port}" },
		-- On windows you may have to uncomment this:
		-- detached = false,
	},
}

pcall(function()
	require("rust-tools").setup({
		tools = {
			executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
			reload_workspace_from_cargo_toml = true,
			runnables = {
				use_telescope = true,
			},
			inlay_hints = {
				auto = true,
				only_current_line = false,
				show_parameter_hints = false,
				parameter_hints_prefix = "<-",
				other_hints_prefix = "=>",
				max_len_align = false,
				max_len_align_padding = 1,
				right_align = false,
				right_align_padding = 7,
				highlight = "Comment",
			},
			hover_actions = {
				border = "rounded",
			},
			on_initialized = function()
				vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
					pattern = { "*.rs" },
					callback = function()
						local _, _ = pcall(vim.lsp.codelens.refresh)
					end,
				})
			end,
		},
		dap = {
			adapter = codelldb_adapter,
		},
		server = {
			on_attach = function(client, bufnr)
				require("lvim.lsp").common_on_attach(client, bufnr)
				local rt = require("rust-tools")
				vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
			end,

			capabilities = require("lvim.lsp").common_capabilities(),
			settings = {
				["rust-analyzer"] = {
					lens = {
						enable = true,
					},
					checkOnSave = {
						enable = true,
						command = "clippy",
					},
				},
			},
		},
	})
end)

-- Markdown
require("lvim.lsp.manager").setup("marksman")

-- Linters / Formatters
-- <https://www.lunarvim.org/docs/languages#lintingformatting>
-- Set a linter/formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "stylua", filetypes = { "lua" } },
	{ command = "prettier", filetypes = { "markdown" } },
	{
		command = "prettier",
		args = { "--print-width", "100" },
		filetypes = { "typescript", "typescriptreact" },
	},

	-- we can use separate standaline rustfmt to format on save with null-ls but if we use rust-analyzer that has builtin rustfmt formatter
	-- { command = "rustfmt", filetypes = { "rust" } },
})

-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }

-- DAP settings
lvim.builtin.dap.on_config_done = function(dap)
	dap.adapters.codelldb = codelldb_adapter
	dap.configurations.rust = {
		{
			name = "Launch file",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
		},
	}
end

-- Additional Plugins
lvim.plugins = {
	-- These plugins moved to lvim builtin plugins, so it's not necessary to use them here
	-- { "folke/tokyonight.nvim" },
	-- { "RRethy/vim-illuminate" },
	-- { "lukas-reineke/indent-blankline.nvim",
	--   event = "BufRead",
	--   config = function()
	--     require("indent_blankline").setup {
	--       -- for example, context is off by default, use this to turn it on
	--       char = "▏",
	--       filetype_exclude = { "help", "terminal", "dashboard" },
	--       buftype_exclude = { "terminal" },
	--       blankline_indent = false,
	--       space_char_blankline = " ",
	--       show_current_context = true,
	--       show_current_context_start = false,
	--       show_first_indent_level = false,
	--     }
	--   end,
	-- },
	{ "sindrets/diffview.nvim", event = "BufRead" },

	-- Scroll animation plugins: mini.animate, neoscroll.nvim, cinnamon.nvim
	-- {
	-- 	"echasnovski/mini.animate",
	-- 	config = function()
	-- 		require("mini.animate").setup({
	-- 			cursor = {
	-- 				enable = false,
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
		config = function()
			require("cinnamon").setup({
				extra_keymaps = true,
				extende_keymaps = true,
			})
		end,
	},
	-- {
	-- 	"karb94/neoscroll.nvim",
	-- 	event = "WinScrolled",
	-- 	config = function()
	-- 		require("neoscroll").setup({
	-- 			-- All these keys will be mapped to their corresponding default scrolling animation
	-- 			mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
	-- 			hide_cursor = true, -- Hide cursor while scrolling
	-- 			stop_eof = true, -- Stop at <EOF> when scrolling downwards
	-- 			use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
	-- 			respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
	-- 			cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
	-- 			easing_function = nil, -- Default easing function
	-- 			pre_hook = nil, -- Function to run before the scrolling animation starts
	-- 			post_hook = nil, -- Function to run after the scrolling animation ends
	-- 		})
	-- 	end,
	-- },

	-- LSP Symbols plugin
	{
		"simrat39/symbols-outline.nvim",
		event = "BufReadPost",
		config = function()
			require("symbols-outline").setup()
		end,
	},

	-- Color highlighter plugin
	{
		"norcalli/nvim-colorizer.lua",
		event = "BufReadPre",
		config = function()
			require("colorizer").setup({ "*" }, {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			})
		end,
	},

	-- Highlight, list, search TODO comments
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	},

	-- Show code context
	{
		"romgrk/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				throttle = true, -- Throttles plugin updates (may improve performance)
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
					-- For all filetypes
					-- Note that setting an entry here replaces all other patterns for this entry.
					-- By setting the 'default' entry below, you can control which nodes you want to
					-- appear in the context window.
					default = {
						"class",
						"function",
						"for",
						"while",
						"if",
						"switch",
						"case",
						"interface",
						"struct",
						"enum",
						"method",
					},
				},
			})
		end,
	},

	-- Cursor eye candy
	{
		"gen740/SmoothCursor.nvim",
		config = function()
			require("smoothcursor").setup({
				speed = 100,
				disabled_filetypes = { "TelescopePrompt", "NvimTree", "harpoon" },
			})
		end,
	},

	-- escape sequence
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
	},

	-- Markdown rendering plugin with glow CLI
	{ "npxbr/glow.nvim", ft = { "markdown" } },

	-- Colorschemes
	{ "catppuccin/nvim" },

	-- Diagnostic, LSP References, Implementations, Definitions, QuickFix list
	{
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({
				auto_open = true,
				auto_close = true,
				padding = false,
				height = 10,
				use_diagnostic_signs = true,
			})
		end,
		cmd = "Trouble",
	},

	-- Scrollbar with decorations
	{
		"petertriho/nvim-scrollbar",
		event = "BufReadPost",
		config = function()
			require("scrollbar").setup({
				excluded_filetypes = {
					"prompt",
					"TelescopePrompt",
					"noice",
					"notify",
				},
				marks = {
					GitAdd = {
						text = "│",
					},
					GitChange = {
						text = "│",
					},
				},
				handlers = {
					cursor = false,
					diagnostic = true,
					gitsigns = false, -- Requires gitsigns
					handle = true,
					search = false, -- Requires hlslens
				},
			})
		end,
	},

	-- Fold text eye candy plugin
	{
		"anuvyklack/pretty-fold.nvim",
		config = function()
			require("pretty-fold").setup()
		end,
	},

	-- f/F t/T indication for navigation
	{
		"jinh0/eyeliner.nvim",
		config = function()
			require("eyeliner").setup({
				highlight_on_key = true,
			})
		end,
	},

	{
		"ThePrimeagen/harpoon",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-lua/popup.nvim" },
		},
	},
	-- signature: lsp_signature
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({
				hint_prefix = " ",
			})
		end,
	},

	--these plugins can provide what noice can also
	-- - lsp progress status: fidget.nvim
	-- - vim.notify: notifier.nvim
	-- - input, select ui for rename etc: dressing.nvim
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	},
	{
		"vigoux/notifier.nvim",
		config = function()
			require("notifier").setup({
				-- You configuration here
			})
		end,
	},
	{
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({
				-- input = {
				-- 	enabled = false,
				-- },
				select = {
					format_item_override = {
						codeaction = function(action_tuple)
							local title = action_tuple[2].title:gsub("\r\n", "\\r\\n")
							local client = vim.lsp.get_client_by_id(action_tuple[1])
							return string.format("%s\t[%s]", title:gsub("\n", "\\n"), client.name)
						end,
					},
				},
			})
		end,
	},
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			require("hlslens").setup()
		end,
	},
	-- {
	-- 	"folke/noice.nvim",
	-- 	config = function()
	-- 		require("noice").setup({
	-- 			-- cmdline = {
	-- 			-- 	format = {
	-- 			-- 		cmdline = {
	-- 			-- 			view = "cmdline",
	-- 			-- 		},
	-- 			-- 	},
	-- 			-- },
	-- 			presets = {
	-- 				bottom_search = false, -- use a classic bottom cmdline for search
	-- 				command_palette = false, -- position the cmdline and popupmenu together
	-- 				long_message_to_split = true, -- long messages will be sent to a split
	-- 				inc_rename = false, -- enables an input dialog for inc-rename.nvim
	-- 				lsp_doc_border = true, -- add a border to hover docs and signature help
	-- 			},
	-- 			lsp = {
	-- 				progress = {
	-- 					enabled = false,
	-- 				},
	-- 				hover = { enabled = true },
	-- 				signature = { enabled = false, auto_open = { enabled = false } },
	-- 				override = {
	-- 					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	-- 					["vim.lsp.util.stylize_markdown"] = true,
	-- 					["cmp.entry.get_documentation"] = true,
	-- 				},
	-- 			},
	-- 			messages = {
	-- 				enabled = false,
	-- 			},
	-- 		})
	-- 	end,
	-- 	requires = {
	-- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	-- 		"MunifTanjim/nui.nvim",
	-- 		-- OPTIONAL:
	-- 		--   `nvim-notify` is only needed, if you want to use the notification view.
	-- 		--   If not available, we use `mini` as the fallback
	-- 		-- "rcarriga/nvim-notify",
	-- 	},
	-- },

	-- rust plugins
	{ "simrat39/rust-tools.nvim" },
	{
		"saecki/crates.nvim",
		tag = "v0.3.0",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup({
				null_ls = {
					enabled = true,
					name = "crates.nvim",
				},
				popup = {
					border = "rounded",
				},
			})
		end,
	},

	-- telescope plugins
	-- { "nvim-telescope/telescope-ui-select.nvim" }, -- if dressing.nvim is not used then enabling this gets us nice telescope select ui
	-- { "nvim-telescope/telescope-project.nvim" }, -- if https://github.com/ahmedkhalf/project.nvim gets out of the builtins then we can use this
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

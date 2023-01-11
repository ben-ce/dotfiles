lvim.plugins = {
	-- These plugins moved to lvim builtin plugins, so it's not necessary to use them here
	-- { "folke/tokyonight.nvim" },
	-- { "RRethy/vim-illuminate" },
	-- { "lukas-reineke/indent-blankline.nvim" },
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
		"declancm/cinnamon.nvim",
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
	-- {
	-- 	"gen740/SmoothCursor.nvim",
	-- 	config = function()
	-- 		require("smoothcursor").setup({
	-- 			speed = 100,
	-- 			disabled_filetypes = { "TelescopePrompt", "NvimTree", "harpoon" },
	-- 		})
	-- 	end,
	-- },

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
		dependencies = {
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
	-- 	dependencies = {
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
		version = "v0.3.0",
		dependencies = { "nvim-lua/plenary.nvim" },
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

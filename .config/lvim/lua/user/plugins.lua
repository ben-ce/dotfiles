lvim.plugins.treesitter_context = true
lvim.plugins.smoothcursor = false
lvim.plugins.noice = false
lvim.plugins.animation_provider = "cinnamon"

lvim.plugins = {
	-- These plugins moved to lvim builtin plugins, so it's not necessary to use them here
	-- { "folke/tokyonight.nvim" },
	-- { "RRethy/vim-illuminate" },
	-- { "lukas-reineke/indent-blankline.nvim" },

	-- --- Simple config plugins, no need for separate config modules
	-- Tabpage interface for git diffs
	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		event = "BufRead",
	},

	-- LSP Symbols window plugin
	{
		"simrat39/symbols-outline.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		event = "BufReadPost",
		config = function()
			require("symbols-outline").setup()
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

	-- escape sequence for jj and jk
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
	},

	-- Markdown rendering plugin with glow CLI
	{
		"npxbr/glow.nvim",
		ft = { "markdown" },
	},

	-- Colorschemes
	{ "catppuccin/nvim" },

	-- Fold text eye candy plugin
	{
		"anuvyklack/pretty-fold.nvim",
		config = function()
			require("pretty-fold").setup()
		end,
	},

	-- File marks
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-lua/popup.nvim",
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

	-- Syntax aware text-objects, move, swap and peek support
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter",
		event = "BufReadPre",
		lazy = true,
	},

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

	-- --- Custom config for these plugins loaded from their separate modules
	-- Scroll animation plugins: neoscroll.nvim, cinnamon.nvim
	{
		"declancm/cinnamon.nvim",
		config = function()
			require("user.cinnamon")
		end,
		enabled = lvim.plugins.animation_provider == "cinnamon",
	},
	{
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
		config = function()
			require("user.neoscroll")
		end,
		enabled = lvim.plugins.animation_provider == "neoscroll",
	},

	-- Color highlighter plugin
	{
		"norcalli/nvim-colorizer.lua",
		event = "BufReadPre",
		config = function()
			require("user.colorizer")
		end,
	},

	-- Show code context
	{
		"romgrk/nvim-treesitter-context",
		config = function()
			require("user.treesitter-context")
		end,
		enabled = lvim.plugins.treesitter_context,
	},

	-- Cursor eye candy
	{
		"gen740/SmoothCursor.nvim",
		config = function()
			require("user.smoothcursor")
		end,
		enabled = lvim.plugins.smoothcursor,
	},

	-- Scrollbar with decorations
	{
		"petertriho/nvim-scrollbar",
		event = "BufReadPost",
		config = function()
			require("user.scrollbar")
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

	-- --- UI plugins
	--these plugins can provide what noice can also
	-- - lsp progress status: fidget.nvim
	-- - vim.notify: notifier.nvim
	-- - input, select ui for rename etc: dressing.nvim
	-- - search Highlight and virtualtext: nvim-hlslens
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	},
	{
		"vigoux/notifier.nvim",
		config = function()
			require("notifier").setup()
		end,
		enabled = not lvim.plugins.noice,
	},
	{
		"stevearc/dressing.nvim",
		config = function()
			require("user.dressing")
		end,
	},
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			require("hlslens").setup()
		end,
		enabled = not lvim.plugins.noice,
	},
	{
		"folke/noice.nvim",
		config = function()
			require("user.noice")
		end,
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			-- "rcarriga/nvim-notify",
		},
		enabled = lvim.plugins.noice,
	},

	-- rust plugins
	{ "simrat39/rust-tools.nvim" },
	{
		"saecki/crates.nvim",
		version = "v0.3.0",
		dependencies = "nvim-lua/plenary.nvim",
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

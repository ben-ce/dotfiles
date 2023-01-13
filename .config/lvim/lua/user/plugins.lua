lvim.plugins.treesitter_context = true
lvim.plugins.smoothcursor = false
lvim.plugins.noice = false
lvim.plugins.animation_provider = "cinnamon"
lvim.plugins.motion_provider = "leap"
lvim.plugins.inlay_hints = true

lvim.plugins = {
	-- These plugins moved to lvim builtin plugins, so it's not necessary to use them here
	-- { "folke/tokyonight.nvim" },
	-- { "RRethy/vim-illuminate" },
	-- { "lukas-reineke/indent-blankline.nvim" },

	-- --- Simple config plugins, no need for separate config modules
	-- Tabpage interface for git diffs
	{
		"sindrets/diffview.nvim",
		lazy = true,
		dependencies = "nvim-lua/plenary.nvim",
		event = "BufRead",
	},

	-- LSP Symbols window plugin
	{
		"simrat39/symbols-outline.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("symbols-outline").setup()
		end,
		event = "BufReadPost",
	},

	-- Highlight, list, search TODO comments
	{
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup()
		end,
		event = "BufRead",
	},

	-- escape sequence for jj and jk
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
		event = "InsertEnter",
	},

	-- Markdown rendering plugin with glow CLI
	{
		"npxbr/glow.nvim",
		ft = { "markdown" },
	},

	-- Colorschemes
	{
		"catppuccin/nvim",
		build = ":CatppuccinCompile",
	},

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
				floating_window = false,
			})
		end,
		event = {
			"BufRead",
			"BufNew,",
		},
	},

	-- inlay hints for some supported languages (lua, go)
	{
		"lvimuser/lsp-inlayhints.nvim",
		config = function()
			require("user.lsp-inlayhints")
		end,
		enabled = lvim.plugins.inlay_hints,
		-- event = "LspAttach",
		ft = {
			"lua",
			"go",
		},
	},

	-- Syntax aware text-objects, move, swap and peek support
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = true,
		dependencies = "nvim-treesitter",
		event = "BufReadPre",
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
		event = "VeryLazy",
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		config = function()
			require("nvim-surround").setup()
		end,
		event = "BufRead",
	},
	{
		"ggandor/leap.nvim",
		enabled = lvim.plugins.motion_provider == "leap",
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	{
		"phaazon/hop.nvim",
		enabled = lvim.plugins.motion_provider == "hop",
		config = function()
			require("user.hop")
		end,
		event = "VeryLazy",
		cmd = { "HopChar1CurrentLineAC", "HopChar1CurrentLineBC", "HopChar2MW", "HopWordMW" },
	},

	-- --- Custom config for these plugins loaded from their separate modules
	-- Scroll animation plugins: neoscroll.nvim, cinnamon.nvim
	{
		"declancm/cinnamon.nvim",
		enabled = lvim.plugins.animation_provider == "cinnamon",
		config = function()
			require("user.cinnamon")
		end,
		event = "WinScrolled",
	},
	{
		"karb94/neoscroll.nvim",
		enabled = lvim.plugins.animation_provider == "neoscroll",
		config = function()
			require("user.neoscroll")
		end,
		event = "WinScrolled",
	},

	-- Color highlighter plugin
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("user.colorizer")
		end,
		event = "BufReadPre",
	},

	-- Show code context
	{
		"romgrk/nvim-treesitter-context",
		enabled = lvim.plugins.treesitter_context,
		config = function()
			require("user.treesitter-context")
		end,
		event = "BufReadPre",
	},

	-- Cursor eye candy
	{
		"gen740/SmoothCursor.nvim",
		enabled = lvim.plugins.smoothcursor,
		config = function()
			require("user.smoothcursor")
		end,
	},

	-- Scrollbar with decorations
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("user.scrollbar")
		end,
		event = "BufReadPost",
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
		enabled = not lvim.plugins.noice,
		config = function()
			require("notifier").setup()
		end,
	},
	{
		"stevearc/dressing.nvim",
		lazy = true,
		config = function()
			require("user.dressing")
		end,
		event = "BufWinEnter",
	},
	{
		"kevinhwang91/nvim-hlslens",
		enabled = not lvim.plugins.noice,
		config = function()
			require("hlslens").setup()
		end,
	},
	{
		"folke/noice.nvim",
		enabled = lvim.plugins.noice,
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			-- "rcarriga/nvim-notify",
		},
		config = function()
			require("user.noice")
		end,
	},

	-- rust plugins
	{ "simrat39/rust-tools.nvim" },
	{
		"saecki/crates.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		version = "v0.3.0",
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

	-- Go plugins
	{
		"olexsmir/gopher.nvim",
		config = function()
			require("gopher").setup({
				commands = {
					go = "go",
					gomodifytags = "gomodifytags",
					gotests = "gotests",
					impl = "impl",
					iferr = "iferr",
				},
			})
		end,
		ft = { "go", "gomod" },
		event = {
			"BufRead",
			"BufNew",
		},
	},
	{
		"leoluz/nvim-dap-go",
		config = function()
			require("dap-go").setup()
		end,
		ft = { "go", "gomod" },
		event = {
			"BufRead",
			"BufNew",
		},
	},

	-- telescope plugins
	-- { "nvim-telescope/telescope-ui-select.nvim" }, -- if dressing.nvim is not used then enabling this gets us nice telescope select ui
	-- { "nvim-telescope/telescope-project.nvim" }, -- if https://github.com/ahmedkhalf/project.nvim gets out of the builtins then we can use this
}

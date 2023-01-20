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
vim.opt.iskeyword:append("-")

-- fold options
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldlevel = 2
vim.wo.foldcolumn = "2"
vim.wo.foldtext =
	[[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.wo.foldnestmax = 3
vim.wo.foldminlines = 5

-- LunarVim log level option
lvim.log.level = "info"
-- LunarVim format on save option
lvim.format_on_save = {
	enabled = true,
	pattern = {
		"*.go",
		"*.lua",
		"*.rs",
	},
}

-- Colorscheme config
lvim.colorscheme = "tokyonight-storm"
-- lvim.colorscheme = "catppuccin"
-- lvim.colorscheme = "rose-pine"

--- LunarVim builtin options override
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = "horizontal"
lvim.builtin.terminal.shading_factor = nil
lvim.builtin.bufferline.options.always_show_bufferline = true

-- Telescope plugin callback to load extra plugins.
lvim.builtin.telescope.on_config_done = function(telescope)
	pcall(telescope.load_extension, "harpoon")
	-- pcall(telescope.load_extension, "ui-select") -- Enable if dressing is not used
end

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
lvim.builtin.nvimtree.setup.renderer.indent_markers = {
	enable = true,
	inline_arrows = false,
}
-- lvim.builtin.nvimtree.setup.renderer.icons.show.folder_arrow = false

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

-- --- Treesitter options
lvim.builtin.treesitter.matchup = { enable = true }
lvim.builtin.treesitter.autotag = { enable = true }
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"go",
	"gomod",
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
lvim.builtin.treesitter.textobjects = {
	select = {
		enable = true,
		lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
		keymaps = {
			-- You can use the capture groups defined in textobjects.scm
			["aA"] = "@attribute.outer",
			["iA"] = "@attribute.inner",
			["ab"] = "@block.outer",
			["ib"] = "@block.inner",
			["ac"] = "@call.outer",
			["ic"] = "@call.inner",
			["at"] = "@class.outer",
			["it"] = "@class.inner",
			["a/"] = "@comment.outer",
			["i/"] = "@comment.inner",
			["ai"] = "@conditional.outer",
			["ii"] = "@conditional.inner",
			["aF"] = "@frame.outer",
			["iF"] = "@frame.inner",
			["af"] = "@function.outer",
			["if"] = "@function.inner",
			["al"] = "@loop.outer",
			["il"] = "@loop.inner",
			["aa"] = "@parameter.outer",
			["ia"] = "@parameter.inner",
			["is"] = "@scopename.inner",
			["as"] = "@statement.outer",
			["av"] = "@variable.outer",
			["iv"] = "@variable.inner",
		},
	},
	move = {
		enable = true,
		set_jumps = true, -- whether to set jumps in the jumplist
		goto_next_start = {
			["]p"] = "@parameter.inner",
			["]m"] = "@function.outer",
			["]]"] = "@class.outer",
		},
		goto_next_end = {
			["]M"] = "@function.outer",
			["]["] = "@class.outer",
		},
		goto_previous_start = {
			["[p"] = "@parameter.inner",
			["[m"] = "@function.outer",
			["[["] = "@class.outer",
		},
		goto_previous_end = {
			["[M"] = "@function.outer",
			["[]"] = "@class.outer",
		},
	},
}

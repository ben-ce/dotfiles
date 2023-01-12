local status_ok, treesitter_context = pcall(require, "treesitter-context")
if not status_ok then
	return
end

treesitter_context.setup({
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

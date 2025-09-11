return {
	{ "nvim-mini/mini.statusline", version = "*", config = true },
	{ "nvim-mini/mini.splitjoin", version = "*", config = true },
	{ "nvim-mini/mini.move", version = "*", config = true },
	{ "nvim-mini/mini.starter", version = "*", config = true },
	{
		"nvim-mini/mini.cursorword",
		version = "*",
		opts = { delay = 10 },
	},
	{
		"nvim-mini/mini.diff",
		version = "*",
		opts = {
			view = {
				-- Visualization style. Possible values are 'sign' and 'number'.
				-- Default: 'number' if line numbers are enabled, 'sign' otherwise.
				style = "sign",
				signs = { add = "+", change = "~", delete = "-" },
				priority = 1,
			},

			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				-- Apply hunks inside a visual/operator region
				apply = "",
				-- Reset hunks inside a visual/operator region
				reset = "",
				-- Hunk range textobject to be used inside operator
				-- Works also in Visual mode if mapping differs from apply and reset
				textobject = "",
				-- Go to hunk range in corresponding direction
				goto_first = "",
				goto_prev = "",
				goto_next = "",
				goto_last = "",
			},
		},
	},
}

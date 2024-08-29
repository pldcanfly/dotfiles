return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			icons_enabled = true,
			theme = "tokyonight-night",
			component_separators = "|",
			section_separators = "",
			ignore_focus = {
				"dapui_watches",
				"dapui_breakpoints",
				"dapui_scopes",
				"dapui_console",
				"dapui_stacks",
				"dap-repl",
			},
		},
	},
}

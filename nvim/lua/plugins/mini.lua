return {
	{ "nvim-mini/mini.statusline", version = "*", config = true },
	{ "nvim-mini/mini.splitjoin", version = "*", config = true },
	{ "nvim-mini/mini.move", version = "*", config = true },
	{
		"nvim-mini/mini.cursorword",
		version = "*",
		opts = { delay = 10 },
	},
	{
		"nvim-mini/mini-git",
		version = "*",
		main = "mini.git",
		config = true,
		cmd = "Git",
		keys = {
			{
				"<leader>gb",
				function()
					require("mini.git").show_at_cursor()
				end,
				mode = { "n", "x" },
				desc = "Git: Show at cursor (line history / commit)",
			},
			{ "<leader>gB", "<cmd>vertical Git blame -- %<cr>", desc = "Git: Blame buffer" },
		},
		init = function()
			-- Align `:vertical Git blame -- %` output with the source window and
			-- scroll both together. Recipe from :h MiniGit-examples.
			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniGitCommandSplit",
				callback = function(au_data)
					if au_data.data.git_subcommand ~= "blame" then
						return
					end
					local win_src = au_data.data.win_source
					vim.wo.wrap = false
					vim.fn.winrestview({ topline = vim.fn.line("w0", win_src) })
					vim.api.nvim_win_set_cursor(0, { vim.fn.line(".", win_src), 0 })
					vim.wo[win_src].scrollbind, vim.wo.scrollbind = true, true
				end,
			})
		end,
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

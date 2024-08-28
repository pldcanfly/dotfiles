return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>?",       require("telescope.builtin").oldfiles, desc = "[?] Find recently opened files" },
		{ "<leader><space>", require("telescope.builtin").buffers,  desc = "[ ] Find existing buffers" },
		{
			"<leader>ff",
			"<cmd>lua require('telescope.builtin').find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>",
			desc = "[S]earch [F]iles",
		},
		{ "<leader>fw", require("telescope.builtin").grep_string, desc = "[S]earch current [W]ord" },
		{ "<leader>fg", require("telescope.builtin").live_grep,   desc = "[S]earch by [G]rep" },
		{ "<leader>fd", require("telescope.builtin").diagnostics, desc = "[S]earch [D]iagnostics" },
		{ "<leader>fr", require("telescope.builtin").resume,      desc = "[S]earch [R]esume" },
	},
}

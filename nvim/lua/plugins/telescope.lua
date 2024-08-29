return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup()

		vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles)

		vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers)

		vim.keymap.set(
			"n",
			"<leader>ff",
			"<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>"
		)
		vim.keymap.set("n", "<leader>fw", require("telescope.builtin").grep_string)
		vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep)
		vim.keymap.set("n", "<leader>fd", require("telescope.builtin").diagnostics)
		vim.keymap.set("n", "<leader>fr", require("telescope.builtin").resume)
	end,
	keys = {
		{ "<leader>?", desc = "Tele: Recent Files" },
		{ "<leader><space>", desc = "Tele: Buffers" },
		{
			"<leader>ff",
			desc = "[S]earch [F]iles",
		},
		{ "<leader>fw", desc = "Tele: Grep Word -> Buffer" },
		{ "<leader>fg", desc = "Tele: Grep Word -> Files" },
		{ "<leader>fd", desc = "Tele: Diagnostics" },
		{ "<leader>fr", desc = "Tele: Resume" },
	},
}

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
		"mxsdev/nvim-dap-vscode-js",
		"jay-babu/mason-nvim-dap.nvim",
		"theHamsta/nvim-dap-virtual-text",
		-- lazy spec to build "microsoft/vscode-js-debug" from source
		{
			"microsoft/vscode-js-debug",
			version = "1.x",
			build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
		},
	},
	keys = {
		{
			"<leader>b",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "DAP: Breakpoint",
		},
		{ "<leader>d", nil, desc = "DAP" },
		{
			"<leader>dd",
			function()
				require("dap").clear_breakpoints()
			end,
			desc = "DAP: Delete Breakpoints",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "DAP: Continue",
		},

		{
			"<leader>dl",
			function()
				require("dap").step_into()
			end,
			desc = "DAP: Step Into",
		},
		{
			"<leader>dL",
			function()
				require("dap").step_over()
			end,
			desc = "DAP: Step Over ",
		},
		{
			"<leader>dH",
			function()
				require("dap").step_out()
			end,
			desc = "DAP: Step Out",
		},

		{
			"<leader>ds",
			function()
				require("dapui").float_element("scopes", { enter = true })
			end,
			desc = "DAP: Scopes",
		},
		{
			"<leader>du",
			function()
				require("dapui").toggle()
			end,
			desc = "DAP: UI",
		},
	},
	config = function()
		require("config.langs").dap.setup()
		require("dapui").setup()
	end,
}

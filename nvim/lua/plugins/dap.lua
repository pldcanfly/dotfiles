return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		"mxsdev/nvim-dap-vscode-js",
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
			desc = "Toggle Breakpoint",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "DAP: Continue",
		},
	},
	config = function()
		require("config.langs").dap.setup()
		require("dapui").setup()
	end,
}

return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {},
  ft = "typescript",
  keys = {
    { "<leader>jso", "<cmd>TSToolsOrganizeImports<cr>",      desc = "sorts and removes unused imports", },
    { "<leader>jss", "<cmd>TSToolsSortImports<cr>",          desc = "sorts imports", },
    { "<leader>jsu", "<cmd>TSToolsRemoveUnusedImports<cr>",  desc = "removes unused imports", },
    { "<leader>jsd", "<cmd>TSToolsRemoveUnused<cr>",         desc = "removes all unused statements", },
    { "<leader>jsi", "<cmd>TSToolsAddMissingImports<cr>",    desc = "adds imports for all statements that lack one and can be imported", },
    { "<leader>jsa", "<cmd>TSToolsFixAll<cr>",               desc = "fixes all fixable errors", },
    { "<leader>jsg", "<cmd>TSToolsGoToSourceDefinition<cr>", desc = "goes to source definition (available since TS v4.7)", },
    { "<leader>jsr", "<cmd>TSToolsRenameFile<cr>",           desc = "allow to rename current file and apply changes to connected files", },
    { "<leader>jsf", "<cmd>TSToolsFileReferences<cr>",       desc = "find files that reference the current file (available since TS v4.2)", },
  }
}

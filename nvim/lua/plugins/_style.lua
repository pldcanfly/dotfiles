return {
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	-- opts = {
	-- 	dim_inactive = true,
	-- },
	init = function()
		vim.g.gruvbox_material_ui_contrast = "high"
		vim.g.gruvbox_material_float_style = "dim"
		vim.g.gruvbox_material_transparent_background = 2
		vim.g.gruvbox_material_foreground = "original"
		vim.g.gruvbox_material_background = "hard"
		vim.cmd.colorscheme("gruvbox-material")
	end,
}

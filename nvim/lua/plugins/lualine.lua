return {
	   'nvim-lualine/lualine.nvim',
	   dependencies = { 'nvim-tree/nvim-web-devicons' },
	options = {
	--        -- theme options : wombat, palenight, onedark, nord, material, iceberg_{dark, light}, dracula, ayu_{dark, light, mirage}
	       theme = "nord",
		icons_enabled = true,
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
	   },
	config = true,
}

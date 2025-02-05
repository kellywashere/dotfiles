return {
	"rebelot/kanagawa.nvim",
	enabled = true,
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("kanagawa").setup({
			-- transparent = true,
			overrides = function(colors)
				return {
					Whitespace = { fg = "#2b2b33" },
				}
			end,
			background = { -- map the value of 'background' option to a theme
				dark = "wave", -- try "dragon" !
				-- dark = "dragon",
				light = "lotus",
			},
		})
		vim.cmd.colorscheme("kanagawa")
		-- vim.cmd.highlight "Whitespace guifg=#2b2b33" -- leading tabs are too bright by default
	end,
}

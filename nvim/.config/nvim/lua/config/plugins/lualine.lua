return {
	"nvim-lualine/lualine.nvim",
	enable = true,
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		local lualine = require("lualine")

		-- see: https://www.josean.com/posts/how-to-setup-neovim-2024
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		lualine.setup({
			options = {
				icons_enabled = true,
				-- theme = 'onedark',
				-- theme = 'dracula',
				theme = "kanagawa",
			},
			sections = {
				lualine_a = {
					{
						"buffers",
					},
				},
				-- lualine_a = {
				-- 	{
				-- 		"mode",
				-- 		fmt = function(str)
				-- 			return str:sub(1, 3)
				-- 		end,
				-- 	},
				-- },
				lualine_c = {
					{
						"filename",
						path = 1, -- 0: Just the filename
						-- 1: Relative path
						-- 2: Absolute path
						-- 3: Absolute path, with tilde as the home directory
						-- 4: Filename and parent dir, with tilde as the home directory
					},
				},
				lualine_x = {
					{ -- lazy pending updates count
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}

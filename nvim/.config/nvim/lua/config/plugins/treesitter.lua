return {
	"nvim-treesitter/nvim-treesitter",
	enabled = true,
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c",
				"lua",
				"rust",
				"vim",
				"bash",
				"glsl",
				"make",
				"python",
				"html",
				"css",
				"javascript",
			},
			sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
			auto_install = false, -- Automatically install missing parsers when entering buffer
			ignore_install = {}, -- List of parsers to ignore installing (or "all")
			highlight = {
				enable = true,
				-- use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
		})
	end,
}

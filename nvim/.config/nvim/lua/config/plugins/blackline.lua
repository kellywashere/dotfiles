return {
	"kellywashere/nvim-blackline",
	enabled = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("blackline").setup({
			icolor = "Black",
		})
	end,
}

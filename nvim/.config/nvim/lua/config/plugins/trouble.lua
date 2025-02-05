return {
	"folke/trouble.nvim",
	enable = true,
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
	opts = {
		focus = true,
	},
	cmd = "Trouble",
	keys = {
		{ "<leader>tw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open Trouble workspace diagnostics" },
		{
			"<leader>td",
			"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
			desc = "Open Trouble document diagnostics",
		},
		{ "<leader>tq", "<cmd>Trouble quickfix toggle<CR>", desc = "Open Trouble quickfix list" },
		{ "<leader>tl", "<cmd>Trouble loclist toggle<CR>", desc = "Open Trouble location list" },
		{ "<leader>tt", "<cmd>Trouble todo toggle<CR>", desc = "Open todos in Trouble" },
		{ "<leader>ts", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Open symbols (Trouble)" },
		{
			"<leader>tL",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{ "<leader>tQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
	},
}

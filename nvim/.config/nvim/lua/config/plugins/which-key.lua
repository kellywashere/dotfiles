return {
	"folke/which-key.nvim",
	enabled = true,
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	opts = {
		-- delay between pressing a key and opening which-key (milliseconds)
		-- this setting is independent of vim.opt.timeoutlen
		delay = 500,
		-- Document existing key chains
		-- spec = {
		--   { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
		--   { '<leader>d', group = '[D]ocument' },
		--   { '<leader>r', group = '[R]ename' },
		--   { '<leader>s', group = '[S]earch' },
		--   { '<leader>w', group = '[W]orkspace' },
		--   { '<leader>t', group = '[T]oggle' },
		--   { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
		-- },
	},
}

-- Highlight when yanging text
-- See :help vim.highlight.on_yank()
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking text',
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- show cursor line only in active window https://alpha2phi.medium.com/neovim-for-beginners-lua-autocmd-and-keymap-functions-3bdfe0bebe42
local cursorGrp = vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd(
  { "VimEnter", "WinEnter", "BufWinEnter" },
  { pattern = "*", command = "setlocal cursorline", group = cursorGrp }
)
vim.api.nvim_create_autocmd(
  { "WinLeave" },
  { pattern = "*", command = "setlocal nocursorline", group = cursorGrp }
)



vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true }) -- space does nothing (leader)
vim.keymap.set("i", "jk", "<Esc>", { desc = "jk -> ESC insert mode" }) -- keep hands on homerow to esc insert
vim.keymap.set("i", "kj", "<Esc>", { desc = "kj -> ESC insert mode" }) -- keep hands on homerow to esc insert

vim.keymap.set("i", "<C-k>", "<C-y>") -- ctrl-y and ctrl-e taken over by nvim-cmp
vim.keymap.set("i", "<C-j>", "<C-e>")

-- yank options
--vim.keymap.set("n", "x", '"_x', { silent = true }) -- do no put deleted chars in register
vim.keymap.set("v", "p", '"_dP', { silent = true }) -- keep last yanked when pasting over selected

-- Clear highlights on search when pressing <Esc> in normal mode, see :h hlsearch
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- some buffer navigation keymaps
vim.keymap.set("n", "<leader><Space>", ":bn<CR>", { desc = "Buffer Next" })
vim.keymap.set("n", "<leader>bn", ":bn<CR>", { desc = "[B]uffer: [N]ext" })
vim.keymap.set("n", "<leader>bp", ":bp<CR>", { desc = "[B]uffer: [P]revious" })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "[B]uffer: [D]elete" })

-- center view
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Auto-replace in insert mode
vim.keymap.set("i", ",.", "->", { desc = "Auto-replace: ,. becomes ->" })

-- Execute lua code in editor
vim.keymap.set("n", "<space>X", "<cmd>source %<CR>", { desc = "e[X]ecute buffer" })
vim.keymap.set("n", "<space>x", ":.lua<CR>", { desc = "e[x]ecute current line" })
vim.keymap.set("v", "<space>x", ":lua<CR>", { desc = "e[x]exute selected" })

-- insert mode: C-y copies text from line above (not if nvim-cmp is running :( )
-- nvim builtin: gc[c]: comment lines

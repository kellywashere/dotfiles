-- Settings
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 2
vim.opt.sidescrolloff = 5
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.autowrite = true

vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default registerj

-- Don't show the mode, since it's already in the status line
--vim.opt.showmode = false

vim.opt.list = true -- show tabs
vim.opt.listchars = "tab:|·,nbsp:␣,trail:•,extends:⟩,precedes:⟨"
vim.opt.showbreak = "↪"

-- Settings tab  https://vim.fandom.com/wiki/Indent_with_tabs,_align_with_spaces
vim.opt.expandtab = false
vim.opt.copyindent = true
vim.opt.preserveindent = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

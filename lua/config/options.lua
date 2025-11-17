-- Enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.textwidth = 80

-- highlight current line
vim.opt.cursorline = true

-- Tabs and spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 2

-- Enable line wrapping by default
vim.opt.wrap = true

-- Make cursor centred in the window
vim.opt.scrolloff = 999

-- Search settings
vim.opt.incsearch = true -- Incremental search
vim.opt.hlsearch = true -- Highlight search results
vim.opt.ignorecase = true -- Case-insensitive search
vim.opt.smartcase = true -- Case-sensitive search if there are uppercase characters

-- Other useful settings
vim.opt.backspace = "indent,eol,start" -- Allow backspacing over indent, EOL, and start of line
vim.opt.showcmd = true -- Show typed commands
vim.opt.wildmenu = true -- Enable command-line completion
vim.opt.winborder = "rounded" -- rounded borders for popus
vim.opt.clipboard = "unnamedplus" -- connect to system clipboard

-- show invisible characters
vim.opt.list = true
vim.opt.listchars = { tab = "»·", trail = "•", lead = "˙" }

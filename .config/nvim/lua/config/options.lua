-- visual
vim.cmd("syntax on")

vim.opt.number = true
vim.opt.ruler = true
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.list = true
vim.opt.listchars = {
  tab = ">-",
  extends = "<",
}
vim.opt.showcmd = true

-- tab/indent
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.backspace = { "indent", "eol", "start" }

-- backup file
vim.opt.backup = false
vim.opt.swapfile = false

-- clipboard
vim.opt.clipboard:append("unnamedplus")

-- search
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- encoding display in statusline
vim.opt.statusline:append("[%{has('multi_byte')&&&fileencoding!=''?&fileencoding:&encoding}]")

-- markdown options
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_new_list_item_indent = 2

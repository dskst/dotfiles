vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local keymap = vim.keymap.set

-- neo-tree
keymap("n", "<C-n>", "<cmd>Neotree toggle left<CR>", { desc = "Toggle file tree" })

-- telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })

-- clear search highlight
keymap("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- comment
keymap("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment line" })
keymap("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment selection" })

-- diagnostics
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics to location list" })
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", { desc = "Find diagnostics" })

-- optional: load old keymap file if it exists
local old_keymap = vim.fn.expand("~/.vimrc.keymap")
if vim.fn.filereadable(old_keymap) == 1 then
  vim.cmd("source " .. old_keymap)
end

-- file path copy
vim.keymap.set("n", "<leader>yrp", function()
  local path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
  vim.fn.setreg("+", path)
  print("Copied relative path: " .. path)
end, { desc = "Yank relative file path" })

vim.keymap.set("n", "<leader>yap", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("Copied absolute path: " .. path)
end, { desc = "Yank absolute file path" })

vim.keymap.set("n", "<leader>yfn", function()
  local name = vim.fn.expand("%:t")
  vim.fn.setreg("+", name)
  print("Copied file name: " .. name)
end, { desc = "Yank file name" })

-- Swagger preview
vim.keymap.set("n", "<leader>sp", "<cmd>SwaggerPreviewToggle<CR>", {
  desc = "Swagger preview toggle",
})


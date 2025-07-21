-- leader is mapped to space, keymap in normal mode "n" leader pv executes vim.cmd.Ex (explore)
vim.g.mapleader = " "

-- Jupyter notebook setup 
vim.g.python_host_prog = 'jupyter'
vim.g.python3_host_prog = '/usr/local/bin/python3'


-- leader pv for file tree
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- exiting insert mode 
vim.keymap.set("i", "jk", "<esc>:w<cr>")
vim.keymap.set("i", "kj", "<esc>:w<cr>")

-- allow the highlighted lines to be moved using move command 
-- use capital J or K to move highlighted lines in visual mode 
--

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- J appends line below to line above, this mapping keeps cursor at beginning of line
vim.keymap.set("n", "J", "mzJ`z")
-- allo ctrl-d and u to keep cursor in middle of page while doing half page jumping 
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- allow search terms to stay in the middle 
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever 
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("x", "<leader>P", "\"_d\"0P")


-- leader y for system clipboard yank or just y for in vim 
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
-- leader p for put from system clipboard
vim.keymap.set("v", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- ???
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")


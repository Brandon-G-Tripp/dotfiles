require("config.lazy")

vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

-- for the quick fix list - remember from grep popup - ctrl + q adds to quickfix list
vim.keymap.set("n", "<c-n>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<c-p>", "<cmd>cprev<CR>")
vim.keymap.set("n", "<space>Q", ":copen<CR>")
vim.keymap.set("n", "<space>q", ":cclose<CR>")

-- exiting insert mode
vim.keymap.set("i", "jk", "<esc>:w<cr>")
vim.keymap.set("i", "kj", "<esc>:w<cr>")

-- leader y for system clipboard yank or just y for in vim
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
-- leader p for put from system clipboard
vim.keymap.set("v", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

local job_id = 0
vim.keymap.set("n", "<space>to", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 5)

  job_id = vim.bo.channel
end)

local current_command = ""
vim.keymap.set("n", "<space>te", function()
  current_command = vim.fn.input("Command: ")
end)

vim.keymap.set("n", "<space>tr", function()
  if current_command == "" then
    current_command = vim.fn.input("Command: ")
  end

  vim.fn.chansend(job_id, { current_command .. "\r\n" })
end)

vim.keymap.set("n", "-", "<cmd>Oil<CR>")


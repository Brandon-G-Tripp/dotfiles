local builtin = require('telescope.builtin')
-- below pf for project find 
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
-- below to just find files in git, skipping node modules for example 
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
-- mapping for ps project search
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
-- New mapping for searching all files including hidden
vim.keymap.set('n', '<C-p>s', function()
    builtin.grep_string({
        search = vim.fn.input("Grep All > "),
        additional_args = {"--hidden", "--no-ignore"},
        file_ignore_patterns = {
            "node_modules",
            ".git"
        },
        hidden = true,
        no_ignore = true,
    });
end)

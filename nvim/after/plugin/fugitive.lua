vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

vim.keymap.set("n", "<leader>gr", function ()
    -- Check not main branch
    local current_branch = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("\n","")
    if current_branch == "main" then
        vim.cmd("echohl WarningMsg | echo 'Cannot rebase on main branch' | echohl None")
        return 
    end

    local current_buf = vim.fn.bufnr("%")

    function Get_commit_hash()
       local line = vim.fn.getline(".")
       return vim.fn.matchstr(line, "\\v\\zs[0-9a-f]+")
    end
    -- Function to start the interactive rebase
    function Start_interactive_rebase()
        local commit_hash = Get_commit_hash()
        vim.cmd("bd!")
        vim.cmd("Git rebase -i " .. commit_hash) -- Execute the rebase command with the commit hash
        vim.cmd("resize 100")

        -- Onbly close the tab if more than one is open 
        local close_tab = vim.fn.tabpagenr("$") > 1
        Close_tab_str = close_tab and ":tabclose<CR>" or ""


        -- Mapping to abort rebase
        -- vim.cmd("nnoremap <buffer> <leader>a :bd!<CR>" .. Close_tab_str .. "<CR>:Git rebase --abort<CR>:tabn " .. current_tab .. "<CR>:call winrestview(" .. saved_view .. ")<CR>")
        vim.cmd("nnoremap <buffer> <leader>a :bd!<CR>" ..
            Close_tab_str ..
            ":buffer " .. current_buf .. "<CR>")
    end


    vim.cmd("tabnew")
    vim.cmd("G log --oneline --decorate")
    vim.cmd("normal! gg")
    vim.cmd("resize 100")
    -- vim.cmd("0read !git log --oneline --decorate")
    -- vim.cmd("1") -- alternative way to take cursor to first line

     -- Mapping to start interactive rebase
     vim.cmd("nnoremap <buffer> <CR> :lua Start_interactive_rebase()<CR>")

end, { desc = "interactive rebase" })


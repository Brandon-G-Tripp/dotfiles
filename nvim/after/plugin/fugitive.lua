-- Set vim fugitive templ
vim.g.fugitive_git_executable = 'git -c commit.template=~/code/dotfiles/nvim/.gitmessage.txt'

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


vim.keymap.set("n", "<leader>gh", function ()
    local file_path = vim.fn.expand("%")
    local line_number = vim.fn.line(".")
    local pr_commit_hash = vim.fn.system("git rev-parse HEAD")

    local side
    local current_window_num = vim.fn.winnr()
    if current_window_num == 1 then
        side = "LEFT"
    else
        side = "RIGHT"
    end

    -- Open new split window to enter the comment body
    vim.cmd("botright new")
    vim.cmd("vertical resize 100")

    -- Set the buffer name to something meaningful
    local current_buf = vim.api.nvim_get_current_buf()
    local buff_name = "GithubComment"
    print(buff_name)
    vim.api.nvim_buf_set_name(current_buf, buff_name)

    -- Prompt user to enter the comment body
    vim.api.nvim_buf_set_lines(0, 0, 0, false, {"Enter your comment below:"})
    vim.api.nvim_command("startinsert")

    -- Retriev the comment body function
    local function get_comment_body(buf)
        _G.comment_body = vim.trim(table.concat(vim.api.nvim_buf_get_lines(buf, 1, -1, false), "\n"))
        print("Comment body:" .. comment_body)
    end

    local function makeRequest(params)
        -- Get repo name and owner
        -- local repo_owner, repo_name = vim.fn.systemlist('git config remote.origin.url')[1]:match("github.com/([^/]+)/([^/]+)%.git")
        local output = vim.fn.system('gh repo view --json owner,name --jq ".owner.login,.name"')
        local repo_owner, repo_name = output:match("(%w+)%s+(%w+)")

        -- get pr number
        local pr_number = vim.fn.system("gh pr view --json number --jq '.number'")
        pr_number = string.gsub(pr_number, "%s+$", "")

        local commit_id = string.gsub(params.commit_id, "%s+$", "")

        local command = {
            "gh",
            "api",
            "--method",
            "POST",
            "/repos/" .. repo_owner .. "/" .. repo_name .. "/pulls/" .. pr_number .. "/comments",
            "-f",
            "body='" .. params.body .. "'",
            "-f",
            "commit_id=" .. commit_id,
            "-f",
            "path=" .. params.path,
            "-F",
            "line=" .. params.line,
            "-f",
            "side=" .. params.side,
            "-F",
            "start_line=" .. params.start_line,
            "-f",
            "start_side=" .. params.start_side
        }

        local cmd_string = table.concat(command, " ")

        local output_cmd = vim.fn.system(cmd_string)

        --local command = string.format([[
        --    gh api \
        --        --method POST \
        --        /repos/%s/%s/pulls/%s/comments \
        --        -f body='%s' \
        --        -f commit_id='%s' \
        --        -f path='%s' \
        --        -F line='%s' \
        --        -f side='%s' \
        --        -F start_line='%s' \
        --        -f start_side='%s'
        --]], repo_owner, repo_name, pr_number, params.body, params.commit_id, params.path, params.line, params.side, params.start_line, params.start_side)

       local log_file_cli = io.open("log_command.txt", "a")
       log_file_cli:write(vim.inspect(cmd_string))
       log_file_cli:write("\n" .. repo_name)
       log_file_cli:write("\n" .. repo_owner)
       log_file_cli:close()

        if vim.v.shell_error == 0 then
            print("Comment posted successfully")
        else
            print("Error posting comment: " .. output_cmd)
        end
    end

    local function handle_comment()
        get_comment_body(current_buf)

        vim.api.nvim_buf_delete(current_buf, { force = true })

        local params = {
           body = _G.comment_body,
           path = file_path,
           line = line_number,
           commit_id = pr_commit_hash,
           side = side,
           start_line = line_number - 1,
           start_side = side
        }

       local log_file = io.open("log.txt", "a")
       log_file:write(vim.inspect(params))
       log_file:close()

        -- make requests
        makeRequest(params)
    end


    vim.api.nvim_create_autocmd("BufWritePost", {
        callback = handle_comment
    })

    vim.fn.system("rm" .. buff_name)

end, { desc = "Adding Github Comments to PR" })

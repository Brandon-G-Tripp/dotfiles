#!/bin/bash
#

# Function to add a comment using gh CLI
add_comment() {
    local file="$1"
    local line="$2"

    # opten a new tmux pane for the comment editor 
    tmux split-window -h -c "#{pane_current_path}"

    # run the gh pr review --comment cmd in the new pane
    tmux send-keys -t "{right}" "gh pr review --comment --path \"$file\" --line \"$line\""


    #Wait for the commment editor to close 
    while tmux list-panes | grep -q "#{pane_pid}"; do 
        sleep 1
    done

    # Close the comment editor pane 
    tmux kill-pane -t "{bottom-right}"

} 

extract_file_and_line() {
    local line="$1"
    if [[ "$line" =~ ^(.+)+\/\s+([0-9]+) ]]; then
        file="${BASH_REMATCH[1]}"
        line_number="${BASH_REMATCH[2]}"
        add_comment "$file" "$line_number"
    fi
} 

# gh config set pager "bat --paging=always --line-range='enter:extract_file_and_line {}'"
# gh pr diff --color=always | bat --paging=always --line-range='enter:extract_file_and_line {}'
#
# Run gh pr diff with delta and capture the output
# gh config set pager "cat"
# gh pr diff --color=always | delta --side-by-side --line-numbers --navigate 
gh config set pager "delta --side-by-side --line-numbers --navigate"
gh pr diff --color=always



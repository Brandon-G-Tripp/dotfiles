#!/usr/bin/env bash

languages=$(echo "golang c cpp typescript rust" | tr " " "\n")
core_utils=$(echo "find xargs sed awk" | tr " " "\n")
selected=$(echo -e "$languages\n$core_utils" | fzf)

read -p "GIMMIE YOUR QUERY: " query 

if echo "$languages" | grep -qs $selected; then
    tmux split-window -p 40 -h bash -c "cht.sh --shell $selected && $query<CR> | less"
else
    tmux split-window -p 40 -h bash -c "cht.sh $selected $query | less"
fi

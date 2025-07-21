# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export PATH=/Users/brandontripp/Library/Python/3.9/bin:$PATH
export PATH=/Library/Frameworks/Python.framework/Versions/3.11/bin:$PATH
export DISABLE_AUTO_TITLE='true'

# set locale to fix issue with tab completion causing extra characters
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"

export DISABLE_AUTO_TITLE='true'

# Path to your oh-my-zsh installation.
export ZSH="/Users/brandontripp/.oh-my-zsh"
export ERL_AFLAGS="-kernel shell_history enabled"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes



if [ -n "${NVIM_LISTEN_ADDRESS+x}" ]; then
  export MANPAGER="/usr/local/bin/nvr -c 'Man!' -o -"
fi

export MANPAGER="nvim +Man!"
ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-vi-mode fzf git zsh-syntax-highlighting)

source $HOME/code/dotfiles/most/most.sh
source $ZSH/oh-my-zsh.sh


fpath+=$HOME/.zsh/pure



#Auto Loading Pure Prompt 
autoload -U promptinit; promptinit

# optionally define some options
PURE_CMD_MAX_EXEC_TIME=10

# turn on git stash status
zstyle :prompt:pure:git:stash show yes

prompt pure

function g() {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status
  fi
}

# Set FZF to use ripgrep by default if available
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files'
    export FZF_DEFAULT_OPTS='-m'
fi

# Complete g like git
compdef g=git

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"dd this to your zshrc or bzshrc file

# Check if tmux is running always stay in tmux
_not_inside_tmux() { [[ -z "$TMUX" ]] }

ensure_tmux_is_running() {
  if _not_inside_tmux; then
    tat
  fi
}

ensure_tmux_is_running

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"




# Keybinding for tmux sessionizer
bindkey -s "^f" "tmux-sessionizer\n"



# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias dx='~/code/dotfiles/bin/docker_exec_it_to_container'
alias tnv='touch !:1 & nvim !:1'
alias vw='vim -c ":VimwikiIndex"'
alias python=/usr/local/bin/python3
alias dir="source dir"
alias tkill='tmux display-message -p "#S" | xargs -I{} tmux kill-session -a -t="{}" '
alias glg='git --no-pager log --all --graph'
alias glr=' git --no-pager log --reverse --oneline --all'
ctags=/usr/local/bin/ctags
# config for asdf programming language version manager
# . /usr/ljkcal/opt/asdf/libexec/asdf.sh

export PATH=$PATH:/Users/brandontripp/.rvm/gems/ruby-2.7.0-preview1/bin:/Users/brandontripp/.rvm/gems/ruby-2.7.0-preview1@global/bin:/Users/brandontripp/.rvm/rubies/ruby-2.7.0-preview1/bin:/Users/brandontripp/.asdf/shims:/usr/local/opt/asdf/libexec/bin:/Users/brandontripp/Library/Python/3.9/bin:/Library/Frameworks/Python.framework/Versions/3.9/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/brandontripp/bin:/Users/brandontripp/Library/Python/3.9/bin:/Library/Frameworks/Python.framework/Versions/3.9/bin:/Users/brandontripp/.cargo/bin:/Users/brandontripp/.rvm/

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

PATH="$PATH:/Users/brandontripp/Library/Application Support/multipass/bin"


# Added by Amplify CLI binary installer
export PATH="$HOME/.amplify/bin:$PATH"

echo 'Good morning. Time to get to work'
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="~/.local/bin:$PATH"
export REVIEW_BASE="main"

# Go path exports 

export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH=/Users/brandontripp/.nimble/bin:$PATH
export PATH=$HOME/development/flutter/bin:$PATH
export PATH=/usr/local/mysql/bin:$PATH

alias getopt='/usr/local/Cellar/gnu-getopt/2.39.3/bin/getopt'
alias spy='if [ -d ".venv" ]; then source .venv/bin/activate; elif [ -d "venv" ]; then source venv/bin/activate; else echo "No venv or .venv directory found."; fi'
alias lazyv='NVIM_APPNAME=nvim-lazy nvim'
alias nv='NVIM_APPNAME=nvim-base-custom-config nvim'
alias knv='NVIM_APPNAME=nvim-kickstart nvim'
alias nvad='NVIM_APPNAME=nvim-advent nvim'



alias air='~/go/bin/air'
HELIX_RUNTIME=~/src/helix/runtime

# opam configuration
[[ ! -r /Users/brandontripp/.opam/opam-init/init.zsh ]] || source /Users/brandontripp/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/brandontripp/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/brandontripp/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/brandontripp/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/brandontripp/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# source ~/anaconda3/bin/activate
#
#

# bun completions
[ -s "/Users/brandontripp/.bun/_bun" ] && source "/Users/brandontripp/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/brandontripp/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/brandontripp/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/brandontripp/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/brandontripp/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="/Users/brandontripp/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/Users/brandontripp/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
export PATH="/usr/local/opt/php@8.3/bin:$PATH"
export PATH="/usr/local/opt/php@8.3/sbin:$PATH"

export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@14/bin:$PATH"

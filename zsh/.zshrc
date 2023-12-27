
export PATH=$HOME/.bin:$PATH

# Path to your oh-my-zsh installation.
ZSH_DISABLE_COMPFIX=true
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions 
    history-substring-search 
    zsh-syntax-highlighting
    nix-shell)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white'

if [ -e /home/josh/.nix-profile/etc/profile.d/nix.sh ]; then . /home/josh/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# ============== alias ============== 

# vim and tmux
alias t="tmux"
alias v="nvim"
alias vi="nvim ."

# nix
alias ns="nix-shell"
alias n="nix"

# youtube
alias yt="yt-dlp --add-metadata -i"
alias yta="yt -x -f bestaudio/best"

# git 
alias gs="git status"
alias gp="git push"
alias cl="clear"

# docker
alias docker="sudo docker"
alias d="sudo docker"
alias docker-nix="docker run -ti docker.io/nixos/nix:master"


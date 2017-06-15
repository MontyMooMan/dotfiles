# Oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

# Oh-my-zsh theme
ZSH_THEME="awesomepanda"

# Aliases
alias la="ls -aF"
alias ld="ls -ld"
alias ll="ls -la"
alias l.="ls -d .*"
alias cd..="cd .."
alias bc="bc -l"
alias sha1="openssl sha1"
alias mkdir="mkdir -pv"
alias mount="mount |column -t"
alias ping="ping -c 5"
alias fastping="ping -c 100 -s.2"
alias ports="netstat -tulanp"
alias wget="wget -c"

# Specific aliases and configurations
if [[ `uname` == "Linux" ]]; then
  # Configurations
  TERM=xterm-256color

  # Aliases
  alias f5="sudo apt-get -y update && \
            sudo apt-get -y upgrade && \
            sudo apt-get -y dist-upgrade && \
            sudo apt-get -y autoremove && \
            cd ~/.dotfiles && \
            git pull-sub && \
            source ~/.zshrc"
  alias docker-ip="sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
else
  # Aliases
  alias f5="brew update && \
            brew upgrade && \
            brew cleanup && \
            brew prune && \
            brew cask cleanup && \
            cd ~/.dotfiles && \
            git pull-sub && \
            source ~/.zshrc"
  alias cpu="top -o cpu"
  alias mem="top -o rsize"

  export PATH="/usr/local/opt/curl/bin:$PATH"
fi

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Oh-my-zsh plugins
plugins=(git node yarn npm debian osx ssh-agent nyan)

source $ZSH/oh-my-zsh.sh

# Language environment
export LANG=pt_BR.UTF-8

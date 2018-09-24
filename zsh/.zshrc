################################################################################
# Tmux
################################################################################
if [ -z "$TMUX" ]; then
  tmux new-session -s $$;
else
  export TERM="screen-256color"
fi

################################################################################
# Aliases
################################################################################
alias bc="bc -l"
alias cd..="cd .."
alias la="ls -aF"
alias ld="ls -ld"
alias less="less -R"
alias ll="ls -la"
alias mkdir="mkdir -pv"
alias more="more -R"
alias mount="mount | column -t"
alias mutt="neomutt"
alias ping="ping -c 5"
alias sendKeys="gpg --send-keys 0x61D32924C3587EA4"
alias wget="wget -c -N"
if [[ "$(uname)" == "Linux" ]]; then
  alias docker-compose='docker run --rm \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v "$PWD:/rootfs/$PWD" \
      -w="/rootfs/$PWD" \
      docker/compose:1.22.0'
fi

################################################################################
# Settings
################################################################################
export EDITOR='vim'
export HISTCONTROL=ignoredups
export HISTIGNORE="cd:ls:[bf]g:clear:exit"
export LANG=pt_BR.UTF-8
set -o vi

################################################################################
# Scripts
################################################################################
for script in ~/.dotfiles/zsh/scripts/*; do
  source $script
done

################################################################################
# Oh-my-zsh
################################################################################
export ZSH=~/.dotfiles/zsh/.oh-my-zsh
ZSH_THEME="dracula"
DISABLE_AUTO_UPDATE="true"
HIST_STAMPS="dd/mm/yyyy"
plugins=(
  gpg-agent
  ssh-agent
  tmux
  vi-mode
)
source $ZSH/oh-my-zsh.sh

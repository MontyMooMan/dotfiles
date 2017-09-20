#!/bin/bash
# The MIT License (MIT)
#
# Copyright (c) 2014 Gustavo Franco
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Updates, upgrades, basic packages, etc...
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get -y update
  sudo apt-get -y upgrade
  sudo apt-get -y dist-upgrade

  sudo apt-get -y install curl git wget
else
  xcode-select -p || exit 1
  sudo xcodebuild -license accept
  sudo xcode-select --install

  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew doctor
  brew tap caskroom/cask
  brew tap buo/cask-upgrade

  brew install curl git wget
fi

# Installing dotfiles
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get -y install git
else
  brew install git
fi
if [ -f ~/.dotfiles ] || [ -h ~/.dotfiles ]; then
  mv ~/.dotfiles /tmp/dotfiles-old
fi
git clone --recursive https://github.com/gufranco/dotfiles.git ~/.dotfiles
cd ~/.dotfiles || exit
git remote set-url origin git@github.com:gufranco/dotfiles.git
git config user.email "gufranco@users.noreply.github.com"

# Install Git
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get -y install git
else
  brew install git
fi
if [ -f ~/.gitconfig ] || [ -h ~/.gitconfig ]; then
  mv ~/.gitconfig /tmp/gitconfig-old
fi
ln -s ~/.dotfiles/gitconfig ~/.gitconfig
if [ -f ~/.gitglobalignore ] || [ -h ~/.gitglobalignore ]; then
  mv ~/.gitglobalignore /tmp/gitglobalignore-old
fi
ln -s ~/.dotfiles/gitglobalignore ~/.gitglobalignore

# Install Vim
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get -y install vim
else
  brew install vim
fi
if [ -f ~/.vim ] || [ -h ~/.vim ]; then
  mv ~/.vim /tmp/vim-old
fi
ln -s ~/.dotfiles/vim ~/.vim
if [ -f ~/.vimrc ] || [ -h ~/.vimrc ]; then
  mv ~/.vimrc /tmp/vimrc-old
fi
ln -s ~/.dotfiles/vimrc ~/.vimrc

# Install Zsh
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get -y install zsh
else
  brew install zsh
fi
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
  mv ~/.zshrc /tmp/zshrc-old
fi
ln -s ~/.dotfiles/zshrc ~/.zshrc
if [ -f ~/.oh-my-zsh ] || [ -h ~/.oh-my-zsh ]; then
  mv ~/.oh-my-zsh /tmp/oh-my-zsh-old
fi
ln -s ~/.dotfiles/oh-my-zsh ~/.oh-my-zsh
sudo chsh -s "$(which zsh)"

# Intall GPG
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get -y install gnupg-agent
else
  brew cask install gpg
fi
if [ -f ~/.gnupg ] || [ -h ~/.gnupg ]; then
  mv ~/.gnupg /tmp/gnupg-old
fi
ln -s ~/.dotfiles/gnupg ~/.gnupg
gpg --import ~/.gnupg/keys/com.gmail.gustavocfranco.public
gpg --import ~/.gnupg/keys/com.gmail.gustavocfranco.private

# Install NVM / Node.js LTS / Yarn
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get -y install curl
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
  nvm install --lts
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
else
  brew install curl
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
  nvm install --lts
  brew install yarn
fi

# Install Atom (and dependencies)
if [[ "$(uname)" == "Linux" ]]; then
  sudo add-apt-repository ppa:webupd8team/atom
  sudo apt-get -y update
  sudo apt-get -y install atom

  sudo yarn global add eslint
  sudo apt-get -y install shellcheck
else
  brew cask install atom

  sudo yarn global add eslint
  brew install shellcheck
fi
apm install afterglow-syntax
apm install afterglow-ui
apm install atom-alignment
apm install atom-beautify
apm install atom-ide-ui
apm install auto-detect-indentation
apm install autoclose-html
apm install autocomplete-paths
apm install busy-signal
apm install color-picker
apm install duplicate-removal
apm install editorconfig
apm install emmet
apm install expose
apm install file-icons
apm install git-blame
apm install git-time-machine
apm install hey-pane
apm install highlight-selected
apm install ide-json
apm install ide-rust
apm install ide-vue
apm install intentions
apm install linter
apm install linter-eslint
apm install linter-shellcheck
apm install linter-ui-default
apm install minimap
apm install minimap-highlight-selected
apm install open-recent
apm install pane-layout-plus
apm install pigments
apm install project-manager
apm install sort-lines
apm install todo-show
apm install zentabs
if [ -f ~/.atom/config.cson ] || [ -h ~/.atom/config.cson ]; then
  mv ~/.atom/config.cson /tmp/config.cson-old
fi
ln -s ~/.dotfiles/atom/config.cson ~/.atom/config.cson
if [ -f ~/.atom/init.coffee ] || [ -h ~/.atom/init.coffee ]; then
  mv ~/.atom/init.coffee /tmp/init.coffee-old
fi
ln -s ~/.dotfiles/atom/init.coffee ~/.atom/init.coffee
if [ -f ~/.atom/keymap.cson ] || [ -h ~/.atom/keymap.cson ]; then
  mv ~/.atom/keymap.cson /tmp/keymap.cson-old
fi
ln -s ~/.dotfiles/atom/keymap.cson ~/.atom/keymap.cson
if [ -f ~/.atom/snippets.cson ] || [ -h ~/.atom/snippets.cson ]; then
  mv ~/.atom/snippets.cson /tmp/snippets.cson-old
fi
ln -s ~/.dotfiles/atom/snippets.cson ~/.atom/snippets.cson
if [ -f ~/.atom/styles.less ] || [ -h ~/.atom/styles.less ]; then
  mv ~/.atom/styles.less /tmp/styles.less-old
fi
ln -s ~/.dotfiles/atom/styles.less ~/.atom/styles.less

# Install Sublime Text 3
if [[ "$(uname)" == "Linux" ]]; then
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
  sudo apt-get -y update
  sudo apt-get -y install sublime-text
else
  brew cask install sublime-text
fi
if [ -f ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings ] || [ -h ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings ]; then
  mv ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings /tmp/Preferences.sublime-settings-old
fi
ln -s ~/.dotfiles/Preferences.sublime-settings ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings

# Install Google Chrome
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get -y remove chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg-extra
  sudo apt-get -y install wget
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
  sudo apt-get -y update
  sudo apt-get -y install google-chrome-stable
else
  brew cask install google-chrome
fi

# Install Firefox
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get -y install firefox
else
  brew cask install firefox
fi

# Install Oracle Java 8
if [[ "$(uname)" == "Linux" ]]; then
  sudo add-apt-repository ppa:webupd8team/java
  sudo apt-get -y update
  sudo apt-get -y install oracle-java8-installer oracle-java8-set-default
else
  brew cask install java
fi

# Install Docker (Linux only)
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get -y remove docker docker-engine
  sudo apt-get -y install linux-image-extra-"$(uname -r)" linux-image-extra-virtual apt-transport-https ca-certificates curl software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt-get -y update
  sudo apt-get -y install docker-ce
fi

# Install Skype
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get -y install wget
  wget https://repo.skype.com/latest/skypeforlinux-64.deb -P /tmp
  sudo dpkg -i /tmp/skypeforlinux-64.deb
else
  brew cask install skype
fi

# Install Ubuntu Font (Ubuntu already has it, duh)
if [[ "$(uname)" == "Darwin" ]]; then
  wget http://font.ubuntu.com/download/ubuntu-font-family-0.83.zip -P /tmp
  unzip /tmp/ubuntu-font-family-0.83.zip
  sudo cp /tmp/ubuntu-font-family-0.83/*.ttf /Library/Fonts
fi

# Install VLC
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get -y install vlc
else
  brew cask install vlc
fi

# Install FileZilla
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get -y install filezilla
else
  brew cask install filezilla
fi

# Install Vagrant / VirtualBox
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get -y install virtualbox vagrant
else
  brew cask install virtualbox vagrant
fi

# Install Transmission
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get -y install transmission
else
  brew cask install transmission
fi

# Install Arduino
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get -y install arduino
else
  brew cask install arduino
fi

# Install macOS ~exclusive~ apps
if [[ "$(uname)" == "Darwin" ]]; then
  brew cask install amphetamine
  brew cask install bartender
  brew cask install cleanmymac
  brew cask install cloudapp
  brew cask install coconutbattery
  brew cask install cyberduck
  brew cask install flixtools
  brew cask install folx
  brew cask install istat-menus
  brew cask install itau
  brew cask install iterm2
  brew cask install keka
  brew cask install sizeup
  brew cask install sketch
  brew cask install slack
  brew cask install spotify
  brew cask install steam
  brew cask install x-lite
fi

# Clean the mess!
if [[ "$(uname)" == "Linux" ]]; then
  sudo apt-get -y autoremove
  sudo apt-get -y clean all
else
  brew cleanup
  brew prune
  brew cask cleanup
fi

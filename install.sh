# install nix
sh <(curl -L https://nixos.org/nix/install) --daemon

# source nix
. ~/.nix-profile/etc/profile.d/nix.sh

# install packages
nix-env -iA \
	nixpkgs.zsh \ 
	nixpkgs.neovim \
	nixpkgs.tmux \
	nixpkgs.stow 
#	nixpkgs.fish \ 

# stow dotfiles
stow git
stow nvim
stow tmux
stow zsh

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# use zsh as default shell
sudo chsh -s $(which zsh) $USER
#sudo chsh -s $(which fish) $USER

       
# Install oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Clone necessary plugins.
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# vim plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# install neovim plugins
nvim --headless +PlugInstall +qall


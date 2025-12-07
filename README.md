# dotfiles

Clone the repo somewhere

```sh
# cloning to ~/dotfiles
cd ~
git clone https://github.com/alanjose10/dotfiles.git
```

## zsh

```sh
ln -sfn ~/dotfiles/home/.zprofile ~/
ln -sfn ~/dotfiles/home/.zprofile ~/
ln -sfn ~/dotfiles/home/.zshrc ~/
```

## tmux

```sh
# Setup tpm
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# Setup catppuccin
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux

ln -sfn ~/dotfiles/tmux/tmux.conf ~/.config/tmux/tmux.conf
```

## nvim

```sh
ln -sfn ~/dotfiles/home/.config/nvim ~/.config/
```

<!-- TODO: Use stove -->


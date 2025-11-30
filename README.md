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
# clone tpm
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

ln -sfn ~/dotfiles/home/.config/tmux ~/.config/
```

## nvim

```sh
ln -sfn ~/dotfiles/home/.config/nvim ~/.config/
```

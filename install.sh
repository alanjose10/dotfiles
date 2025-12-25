#!/usr/bin/env bash
# install.sh - Automated dotfiles setup

set -e

echo "🚀 Setting up dotfiles..."

# Create necessary directories
mkdir -p ~/.config/tmux/plugins
mkdir -p ~/.config/nvim

# Install TPM (Tmux Plugin Manager)
if [ ! -d ~/.config/tmux/plugins/tpm ]; then
  echo "📦 Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
else
  echo "✅ TPM already installed"
fi

# Install catppuccin theme for tmux (pinned to v2.1.3)
if [ ! -d ~/.config/tmux/plugins/catppuccin ]; then
  echo "🎨 Installing catppuccin theme..."
  mkdir -p ~/.config/tmux/plugins/catppuccin
  git clone -b v2.1.3 https://github.com/catppuccin/tmux.git \
    ~/.config/tmux/plugins/catppuccin/tmux
else
  echo "✅ Catppuccin already installed"
fi

# Link dotfiles (customize these paths as needed)
echo "🔗 Linking configuration files..."
ln -sfn "$(pwd)/nvim" ~/.config/nvim
ln -sfn "$(pwd)/tmux/tmux.conf" ~/.config/tmux/tmux.conf
ln -sfn "$(pwd)/git/config" ~/.gitconfig
ln -sfn "$(pwd)/editorconfig/.editorconfig" ~/.editorconfig

# Bootstrap Neovim plugins
if command -v nvim &> /dev/null; then
  echo "📦 Installing Neovim plugins..."
  nvim --headless "+Lazy! sync" +qa
  echo "✅ Neovim plugins installed"
else
  echo "⚠️  Neovim not found - skipping plugin installation"
  echo "   Install Neovim and run: nvim --headless '+Lazy! sync' +qa"
fi

echo ""
echo "✅ Dotfiles setup complete!"
echo ""
echo "Next steps:"
echo "  1. Open tmux and press <prefix> + I to install tmux plugins"
echo "  2. Open nvim and run :Mason to verify LSP servers"
echo "  3. Restart your terminal"

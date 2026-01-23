# Gemini Context: Dotfiles Repository

This repository contains the personal configuration files (dotfiles) for the user, specifically tailored for macOS and Linux environments using the **Colemak-DH** keyboard layout.

## Project Overview

*   **Purpose:** Centralized management of configuration files for Neovim, Tmux, Zsh, and Kitty.
*   **Core Philosophy:** Lean and lite configuration, minimal plugins, performance-focused, and Colemak-DH optimized.
*   **Key Tools:**
    *   **Neovim:** Customized Lua-based config using `lazy.nvim` and `snacks.nvim`.
    *   **Tmux:** Terminal multiplexer with `tpm` and Catppuccin theme.
    *   **Zsh:** Shell configuration with custom functions for workflow optimization.
    *   **Kitty:** Terminal emulator configuration.

## Directory Overview

*   **`nvim/`**: The active Neovim configuration.
    *   `init.lua`: Bootstrap and core setup.
    *   `lua/core/`: Core options, keymaps, and autocommands (loaded first).
    *   `lua/plugins/`: Plugin specifications managed by `lazy.nvim`.
    *   `lsp/`: LSP server configurations.
    *   `after/ftplugin/`: Filetype-specific settings (e.g., Go, Protobuf) that override defaults.
*   **`nvim-old/`**: specific reference for a previous Neovim configuration.
*   **`tmux/`**: Tmux configuration file (`tmux.conf`).
*   **`zsh/`**: Zsh configuration files (`.zshrc`, `.zprofile`, `.zshenv`).
*   **`home/`**: Directory structure mirroring the user's home directory, containing configs for other tools (e.g., `.config/nvim`, `.config/tmux`).
*   **`kitty/`**: Kitty terminal configuration.
*   **`git/`**: Git global configuration.

## Installation & Setup

Configuration files are installed by creating symbolic links from this repository to the appropriate location in the user's home directory.

**Manual Linking Commands:**

```bash
# Neovim
ln -sfn ~/dotfiles/nvim ~/.config/nvim

# Tmux
ln -sfn ~/dotfiles/tmux/tmux.conf ~/.config/tmux/tmux.conf

# Zsh
ln -sfn ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -sfn ~/dotfiles/zsh/.zprofile ~/.zprofile

# Kitty
ln -sfn ~/dotfiles/kitty ~/.config/kitty
```

**Plugin Setup:**

*   **Tmux:** Requires `tpm` and `catppuccin` to be cloned manually:
    ```bash
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
    mkdir -p ~/.config/tmux/plugins/catppuccin
    git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
    ```
*   **Neovim:** `lazy.nvim` will automatically bootstrap and install plugins on the first launch.

## Key Configurations

### Neovim (`nvim/`)

*   **Package Manager:** `lazy.nvim`
*   **Main Helper:** `snacks.nvim` is heavily used for file picking, explorer, git integration, and UI elements.
*   **Keyboard Layout:** **Colemak-DH**.
    *   Home row: `arstdhneio`
    *   Navigation: Arrow keys on a layer (avoid `hjkl` for navigation if possible).
    *   Flash.nvim: Labels optimized for Colemak-DH.
*   **LSP & Formatting:**
    *   LSP servers configured in `lsp/` (using `vim.lsp.config` API).
    *   `conform.nvim` handles formatting (Format-on-save enabled for most types).
    *   `mason` manages external binaries.
    *   **Go:** Uses `gofumpt` and `goimports`. Inlay hints enabled.
    *   **Protobuf:** Uses `buf_ls`. Formatting is **disabled** by request; uses manual 4-space indentation.

**Essential Keymaps (Leader `<Space>`):**

| Key | Action | Tool |
| :--- | :--- | :--- |
| `<leader><space>` | Smart Find Files | Snacks |
| `<leader>ff` | Find Files | Snacks |
| `<leader>/` | Grep Project | Snacks |
| `<leader>e` | File Explorer | Snacks |
| `<leader>gg` | LazyGit | Snacks |
| `<leader>gb` | Git Blame Line | Snacks |
| `gd` | Go to Definition | LSP |
| `grr` | Find References | LSP |

### Tmux (`tmux/`)

*   **Prefix:** `Ctrl + a` (remapped from `Ctrl + b`).
*   **Theme:** Catppuccin (Mocha flavor).
*   **Keybindings:**
    *   `C-a Space`: Enter copy mode (vi-mode).
    *   `C-a p` / `C-a n`: Previous / Next window.
    *   `C-a r`: Reload config.
*   **Mouse:** Enabled.

### Zsh (`zsh/`)

*   **Aliases:** `lg` (lazygit), `vim`/`vi` (nvim), `k` (kubectl).
*   **Functions:**
    *   `v [dir] [session]`: Opens nvim in a new tmux window/session.
    *   `ts`: Fuzzy tmux session switcher.
    *   `kn`: Kubectl namespace switcher.
    *   `kc`: Kubectl context switcher.
*   **Dependencies:** `zoxide` (directory jumping), `fzf`, `kubectl`, `plz` (Linux only).

## Development Conventions

1.  **Indentation:** Always use **spaces** (2 or 4, context-dependent), **NEVER tabs**, except for Go files where tabs are mandatory.
2.  **Lua Style:**
    *   Use `vim.opt` for options.
    *   Use `keys` table in `lazy.nvim` specs for plugin keymaps.
    *   Document complex logic or keymaps with comments.
3.  **Modifying Configs:**
    *   Check `nvim/init.lua` to see load order.
    *   Add new plugins to `nvim/lua/plugins/`.
    *   Ensure no keymap conflicts with Colemak-DH layout or `flash.nvim`.
    *   Test changes by reloading Neovim or the specific module.

## Neovim Setup Goal
- The neovim configuration has been written from scratch to keep it lean and fast with only the necessary plugins and configurations necessary.
- I would like to only setup the LSPs, formatters and linters as needed.
- Each plugin should live in its own file allowing it to be easily removed or modified.

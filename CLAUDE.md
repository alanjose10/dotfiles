# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for managing configuration files across macOS systems. The user uses **Colemak-DH keyboard layout**, which affects all keybinding decisions in Neovim and other tools.

## Installation & Setup

Link config files manually using `ln -sfn <src> <dest>`:

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

# Gemini
ln -sfn ~/dotfiles/gemini/skills/nvim-expert ~/.gemini/skills/nvim-expert
```

Manual setup for tmux plugins:

```bash
# TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# Catppuccin theme for tmux
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
```

## Neovim Configuration Architecture

The active config is in `nvim/` (the `nvim-old/` directory contains a previous version for reference).

### Structure

```
nvim/
├── init.lua              # Entry point: bootstraps lazy.nvim, loads core/, imports plugins/
├── lazy-lock.json        # Plugin version lockfile
├── lsp/                  # LSP server configs (Neovim 0.11+ vim.lsp.config API)
│   ├── gopls.lua         # Go LSP with directory filters for monorepos
│   └── lua_ls.lua        # Lua LSP
└── lua/
    ├── core/             # Core configuration (loaded before plugins)
    │   ├── options.lua   # Vim options (tabs, UI, clipboard, etc.)
    │   ├── keymaps.lua   # Global keymaps (window nav, buffer nav, line moving)
    │   └── autocmds.lua  # Autocommands
    └── plugins/          # Plugin specs (auto-imported by lazy.nvim)
        ├── lspconfig.lua # LSP + Mason setup
        ├── conform.lua   # Formatting (format-on-save)
        ├── snacks.lua    # File picker, explorer, lazygit, git blame
        ├── gitsigns.lua  # Git gutter signs
        ├── flash.lua     # Fast navigation (Colemak-optimized)
        ├── blink.cmp.lua # Autocompletion
        ├── treesitter.lua
        └── [other plugins]
```

### Plugin Loading Flow

1. `init.lua` sets leader keys, loads `core/` modules, bootstraps lazy.nvim
2. lazy.nvim auto-imports all specs from `plugins/` directory
3. Uses separate data directory (`lazy/`) and lockfile to avoid conflicts with old config

### Key Configuration Principles

**Keyboard Layout:**
- Uses **Colemak-DH** layout with home row `arstdhneio` (not QWERTY)
- Uses **split ortholinear keyboard** with custom symbol layer
- Arrow keys are on a different layer (used for navigation, not hjkl)
- Bracket symbols `[]` are on symbols layer (avoid for frequent operations)
- Flash.nvim labels use Colemak-DH order
- No letter keys are excluded from flash labels
- Prefer `<leader>` prefix or letter-based keybindings over symbols

**Git Workflow:**
- Uses lazygit for staging, commits, stash (via `<leader>gg`)
- Uses gitsigns for gutter signs, inline blame toggle (`<leader>ub`)
- Snacks.nvim for git blame popup (`<leader>gb`) and file history (`<leader>gf`)
- All git keymaps use `<leader>g` prefix

**Formatting:**
- conform.nvim for formatting (replaced null-ls)
- Stylua configured inline to use spaces (not tabs) for Lua
- gofumpt for Go (respects Go's tabs-only standard)
- Format-on-save enabled globally

**LSP:**
- Mason for installing LSP servers, formatters, linters
- Uses new `vim.lsp.config()` and `vim.lsp.enable()` API (Neovim 0.11+)
- LSP server configs live in `nvim/lsp/` directory
- lua_ls has formatting disabled (conform handles it)
- gopls uses gofumpt for formatting

**Monorepo Performance:**
- Pickers exclude `.git`, `node_modules`, `plz-out`, `.plz-cache` directories
- Bigfile detection disables heavy features on large files (>1MB or >10K lines)
- LSP document highlight disabled for files >5K lines
- Trailing whitespace trim skipped for files >10K lines
- Format-on-save has 5s timeout for slow formatters
- gopls configured to filter out `plz-out`, `.plz-cache`, `vendor`, `third_party`

### Important Keymaps

Leader key: `<Space>`

**File Navigation (snacks.picker):**
- `<leader><space>` - Smart find files
- `<leader>ff` - Find files
- `<leader>/` - Grep project
- `<leader>,` - List buffers
- `<leader>e` - File explorer
- `<leader>fr` - Recent files (cwd)
- `<leader>fc` - Find config file
- `<leader>fp` - Projects
- `<leader>fz` - Zoxide directories

**Search (`<leader>s`):**
- `<leader>sw` - Grep word under cursor
- `<leader>sb` - Search buffer lines
- `<leader>sh` - Help pages
- `<leader>sk` - Keymaps
- `<leader>sc` - Command history

**Git (`<leader>g`):**
- `<leader>gg` - Open lazygit
- `<leader>gb` - Blame line (popup)
- `<leader>gf` - Git log for file
- `<leader>ub` - Toggle inline blame
- `<leader>uB` - Git blame file (vertical split)

**LSP:**
- `gd` - Go to definition
- `grr` - Find references
- `gri` - Go to implementation
- `gy` - Go to type definition
- `K` - Hover documentation
- `<leader>cd` - Show diagnostic
- `]d` / `[d` - Next/prev diagnostic

**Flash navigation (Colemak-optimized):**
- `s` - Flash jump (type 2 chars)
- `S` - Treesitter jump

**Formatting:**
- `<leader>cf` - Manual format (auto format-on-save enabled)

**Window/Buffer Navigation (core keymaps):**
- `<A-Arrow>` - Move between windows
- `<C-Arrow>` - Resize windows
- `<S-h>` / `<S-l>` - Previous/next buffer
- `<leader>bd` - Delete buffer

## Important Context

### User Preferences

1. **Lean and lite configuration** - Prefer minimal, essential plugins only. Avoid bloat, unnecessary features, and purely cosmetic plugins. Prioritize performance and simplicity.
2. **Always use spaces, never tabs** - Except for Go files (Go standard requires tabs)
3. **Colemak-DH layout** - When suggesting keymaps, prioritize home row efficiency
4. **Split ortholinear keyboard with custom symbol layer** - Avoid frequent use of bracket symbols `[]`, prefer `<leader>` prefix or letter-based keybindings
5. **Lazygit for git operations** - Don't add staging/commit keymaps to Neovim
6. **Inline comments preferred** - User likes well-documented configs
7. **Format on save** - Expected for all file types

### When Modifying Configs

**Neovim Plugin Files:**
- Each file in `plugins/` should return a plugin spec or array of specs
- Use `keys = {}` table for lazy-loaded keymaps (makes them available immediately)
- Add inline comments explaining each option
- Group related plugins in the same file when appropriate

**Options:**
- Global options go in `core/options.lua`
- Keep all `vim.opt` settings with inline comments

**Keymaps:**
- Global keymaps go in `core/keymaps.lua`
- Plugin-specific keymaps go in the plugin spec's `keys` or `config`
- Always add `desc` field for which-key integration
- Check for conflicts with flash.nvim (`s`, `S`) and existing bindings

**Formatting:**
- Configure formatters in `conform.lua` using `formatters_by_ft`
- Pass arguments via `prepend_args` (don't create external config files)
- Consider whether formatter should use tabs or spaces

### Common Patterns

**Adding a new plugin:**
1. Create `nvim/lua/plugins/plugin-name.lua`
2. Return a spec table with detailed comments
3. Use `keys` for keymaps, `event` for lazy loading
4. Document usage at the top of the file

**Modifying keymaps:**
1. Check if it conflicts with Colemak workflow
2. Verify no conflict with flash.nvim or other plugins
3. Use `<leader>` prefix for custom commands
4. Add descriptive `desc` field

**LSP/Formatter setup:**
1. Add to Mason's `ensure_installed` in `lspconfig.lua`
2. Configure formatter in `conform.lua`
3. For LSP, add to `servers` table in `lspconfig.lua`

## Other Configurations

### Tmux

Prefix key: `C-a` (instead of default `C-b`)

Key bindings:
- `C-a Space` - Enter copy mode (vi-mode)
- `C-a p` / `C-a n` - Previous/next window
- `C-a r` - Reload config

Uses Catppuccin theme and TPM for plugin management.

### Zsh

Custom shell functions:
- `v [dir] [session]` - Open nvim in a new tmux window/session
- `ts` - Tmux session switcher with fzf (ctrl-x to kill, enter to attach)
- `kn [namespace]` - kubectl namespace switcher
- `kc [context]` - kubectl context switcher
- `nvim-clean` - Neovim cleanup utility (cache, data, state)

Aliases: `lg` (lazygit), `vim`/`vi` (nvim), `k` (kubectl)

Uses zoxide for directory jumping (`z` command).

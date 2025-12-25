# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for managing configuration files across macOS systems. The user uses **Colemak-DH keyboard layout**, which affects all keybinding decisions in Neovim and other tools.

## Installation & Setup

Link each of the config file manually using `ln -sfn <src> <dest>` manually as required.

```bash
```
Manual setup for external dependencies (tmux plugins):

```bash
# TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# Catppuccin theme for tmux
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
```

## Neovim Configuration Architecture

### Structure

The Neovim config follows a modular Lua-based architecture using lazy.nvim as the plugin manager:

```
nvim/
├── init.lua              # Entry point: bootstraps lazy.nvim, loads core/, imports plugins/
├── lua/
│   ├── core/             # Core configuration (loaded before plugins)
│   │   ├── init.lua      # Loads all core modules in order
│   │   ├── options.lua   # Vim options (tabs, UI, clipboard, etc.)
│   │   ├── keymaps.lua   # Global keymaps
│   │   ├── autocmds.lua  # Autocommands
│   │   ├── filetypes.lua # Filetype detection
│   │   ├── tmux.lua      # Tmux integration
│   │   ├── floaterm.lua  # Floating terminal setup
│   │   └── popup-menu.lua # Custom popup menu
│   └── plugins/          # Plugin specs (auto-imported by lazy.nvim)
│       ├── lsp-config.lua
│       ├── conform.lua
│       ├── git.lua       # Contains both gitsigns & diffview
│       ├── flash.lua
│       └── [~20 plugin files]
```

### Plugin Loading Flow

1. `init.lua` bootstraps lazy.nvim
2. Loads `core/` modules sequentially via `require("core")`
3. lazy.nvim auto-imports all specs from `plugins/` directory
4. Each plugin file in `plugins/` returns a table (or array of tables) with plugin specs

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
- Uses Neovim plugins (gitsigns, diffview) for viewing blame and diffs only
- Inline git blame enabled by default in Neovim
- All git keymaps use `<leader>g` prefix

**Formatting:**
- conform.nvim for formatting (replaced null-ls)
- Stylua configured inline to use spaces (not tabs) for Lua
- gofumpt for Go (respects Go's tabs-only standard)
- Format-on-save enabled globally

**LSP:**
- Mason for installing LSP servers, formatters, linters
- Uses new `vim.lsp.config()` and `vim.lsp.enable()` API (Neovim 0.11+)
- lua_ls has formatting disabled (conform handles it)
- gopls uses gofumpt for formatting

### Important Keymaps

Leader key: `<Space>`

**Git (`<leader>g`):**
- `<leader>gb` - Blame line (popup)
- `<leader>gB` - Blame file
- `<leader>gd` - Diff this file
- `<leader>gp` - Preview hunk
- `<leader>gv` - Open diffview
- `<leader>gg` - Open lazygit
- `]h` / `[h` - Navigate hunks

**Flash navigation (Colemak-optimized):**
- `s` - Flash jump (type 2 chars)
- `S` - Treesitter jump
- Enhanced `f/F/t/T` work across lines

**Treesitter selection:**
- `<CR>` - Start/expand selection
- `<BS>` - Shrink selection
- `<Tab>` - Expand to outer scope

**Formatting:**
- `<leader>cf` - Manual format

**Mini.surround (`gs` prefix):**
- `gsa` - Add surrounding
- `gsd` - Delete surrounding
- `gsr` - Replace surrounding

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
- Group related plugins in the same file (e.g., gitsigns + diffview in `git.lua`)

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
1. Add to Mason's `ensure_installed` in `lsp-config.lua`
2. Configure formatter in `conform.lua`
3. For LSP, add to `servers` table in `lsp-config.lua`

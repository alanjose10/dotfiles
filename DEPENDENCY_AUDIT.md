# Dependency Audit Report

**Generated:** 2025-12-25
**Repository:** alanjose10/dotfiles

## Executive Summary

This dotfiles repository follows a **lean and minimal** philosophy with well-chosen dependencies. The configuration uses modern tooling with good defaults. This audit identifies potential improvements for security, maintenance, and bloat reduction.

### Key Findings

- ✅ **No critical security vulnerabilities** identified
- ⚠️ **3 potential bloat concerns** (optional features that may not be needed)
- 📦 **22 Neovim plugins** (reasonable for a full IDE experience)
- 🔧 **7 LSP servers + 5 formatters** (well-scoped for languages in use)
- 🎯 **Overall health: GOOD** - Dependencies are modern and purposeful

---

## 1. Neovim Plugin Dependencies

### Overview

**Plugin Manager:** lazy.nvim (modern, lazy-loading focused)
**Total Plugins:** 22
**Lock File:** `.gitignore`d (versions not tracked in git)

### Analysis by Category

#### Core IDE Features (Essential) ✅

| Plugin | Purpose | Status | Notes |
|--------|---------|--------|-------|
| `nvim-lspconfig` | LSP client | ✅ Essential | Core functionality |
| `mason.nvim` | LSP installer | ✅ Essential | Simplifies setup |
| `nvim-treesitter` | Syntax highlighting | ✅ Essential | Modern parsing |
| `saghen/blink.cmp` | Completion engine | ✅ Essential | Fast Rust-based completions |
| `nvim-telescope` | Fuzzy finder | ✅ Essential | File/buffer navigation |

**Recommendation:** Keep all. These are fundamental to a modern Neovim IDE experience.

---

#### UI/UX Enhancements (Quality of Life) ⚠️

| Plugin | Purpose | Bloat Risk | Recommendation |
|--------|---------|-----------|----------------|
| `bufferline.nvim` | Buffer tabs UI | Low | **Keep** - Useful for tab navigation |
| `lualine.nvim` | Status line | Low | **Keep** - Minimal performance impact |
| `indent-blankline.lua` | Indent guides | **Medium** | **Consider removing** - Purely visual, treesitter provides context |
| `nvim-neo-tree.lua` | File tree explorer | **Medium** | **Consider removing** - Telescope often sufficient for file navigation |
| `which-key.nvim` | Keymap helper | Low | **Keep** - Useful for discovering keymaps |
| `dressing.nvim` | UI improvements | Low | **Keep** - Better default UI with minimal overhead |
| `catppuccin.lua` | Color scheme | Low | **Keep** - Single theme is reasonable |

**Bloat Concerns:**

1. **`indent-blankline.lua`** - Adds visual indent guides
   - **Impact:** Low performance cost, purely cosmetic
   - **Alternative:** Treesitter already provides structural context
   - **Recommendation:** Remove if you prefer minimal visual noise

2. **`nvim-neo-tree.lua`** - Traditional file tree sidebar
   - **Impact:** ~500KB plugin, rarely used if you're a Telescope power user
   - **Alternative:** Telescope's `find_files` and `git_files` are faster
   - **Recommendation:** Remove if you rarely use `:Neotree` - you have Telescope configured

---

#### Git Integration ✅

| Plugin | Purpose | Status | Notes |
|--------|---------|--------|-------|
| `gitsigns.nvim` | Inline git status | ✅ Keep | Essential for diff viewing |
| `diffview.nvim` | Advanced diff viewer | ✅ Keep | Complements lazygit for visual diffs |
| `lazygit.nvim` | Lazygit integration | ✅ Keep | Primary git workflow tool |

**Recommendation:** Keep all. These align with the documented git workflow (lazygit for operations, nvim for viewing).

---

#### Code Editing Utilities ✅

| Plugin | Purpose | Status | Notes |
|--------|---------|--------|-------|
| `conform.nvim` | Formatting | ✅ Essential | Format-on-save is a requirement |
| `nvim-autopairs` | Auto-close brackets | ✅ Keep | Quality of life improvement |
| `mini.lua` | Mini utilities | ✅ Keep | mini.surround is actively used |
| `comment.nvim` | Comment toggling | ✅ Keep | Common operation |
| `flash.nvim` | Enhanced navigation | ✅ Keep | Optimized for Colemak-DH |
| `nvim-ufo.lua` | Code folding | ⚠️ Low priority | Useful but not essential |

**Recommendation:** Keep all unless you want maximum minimalism.

---

#### Advanced Features ⚠️

| Plugin | Purpose | Bloat Risk | Recommendation |
|--------|---------|-----------|----------------|
| `trouble.nvim` | Diagnostics viewer | Low | **Keep** - Centralized diagnostics are useful |
| `neoscroll.nvim` | Smooth scrolling | **HIGH** | **REMOVE** - Purely cosmetic animation |
| `telescope-ui-select` | Telescope UI override | Low | **Keep** - Consistent UI |
| `telescope-fzf-native` | Fast fuzzy search | Low | **Keep** - Performance enhancement |

**High-Priority Bloat:**

3. **`neoscroll.nvim`** - Smooth scrolling animations
   - **Impact:** Adds visual animations with no functional benefit
   - **Conflicts with:** "Lean and lite" philosophy
   - **Recommendation:** **Remove** - This is pure eye candy that may introduce input lag

---

### Neovim Plugin Recommendations Summary

#### 🗑️ Recommended Removals (Bloat Reduction)

1. **`neoscroll.nvim`** - Smooth scrolling (purely cosmetic)
2. **`indent-blankline.lua`** (optional) - Visual indent guides (redundant with treesitter)
3. **`nvim-neo-tree.lua`** (optional) - File tree (if you primarily use Telescope)

**Potential savings:** ~3 plugins, reduced visual complexity, slightly faster startup

---

## 2. LSP Servers & Formatters

### Installed via Mason

#### LSP Servers (7 total) ✅

```lua
ensure_installed = {
  "lua_ls",      -- Lua
  "jsonls",      -- JSON
  "yamlls",      -- YAML
  "gopls",       -- Go
  "pyright",     -- Python
  "bashls",      -- Bash
  "marksman",    -- Markdown
}
```

**Analysis:**
- **All servers are justified** - Corresponds to filetypes in use (config files, Go, Python, Shell)
- **No bloat detected** - Only languages actively used in development
- **Modern choices** - pyright (fast Python), gopls (official Go), marksman (lightweight Markdown)

**Recommendation:** ✅ Keep all servers.

---

#### Formatters (5 total) ✅

```lua
ensure_installed = {
  "stylua",      -- Lua (2 spaces)
  "gofumpt",     -- Go (tabs, stricter than gofmt)
  "ruff",        -- Python (fast formatter + linter)
  "shfmt",       -- Bash/Shell (2 spaces)
  "prettier",    -- JSON, YAML, Markdown, JS, TS, CSS, HTML
}
```

**Analysis:**
- **Well-configured** - Custom args ensure spaces (not tabs) except for Go
- **Modern tooling** - ruff (replaces black + isort + flake8), gofumpt (stricter than gofmt)
- **No redundancy** - Each formatter handles distinct filetypes
- **Prettier is versatile** - Handles 7+ filetypes with one tool

**Recommendation:** ✅ Keep all formatters. No bloat detected.

---

#### Potential Optimization: pyright vs basedpyright

**Current:** `pyright` (Microsoft's Python LSP)
**Alternative:** `basedpyright` (community fork with additional features)

- **basedpyright** is a drop-in replacement with more features (better type narrowing, async improvements)
- **Consideration:** Only switch if you need the extra features; pyright is stable and well-maintained
- **Recommendation:** ⚠️ Keep pyright unless you hit specific limitations

---

## 3. Tmux Plugin Dependencies

### Installed via TPM

```bash
set -g @plugin 'tmux-plugins/tpm'              # Plugin manager
set -g @plugin 'tmux-plugins/tmux-sensible'    # Sensible defaults
set -g @plugin 'tmux-plugins/tmux-yank'        # Enhanced copy/paste
```

**External Theme:**
```bash
# Manually installed
catppuccin/tmux (v2.1.3) - Pinned to specific version
```

### Analysis

✅ **Minimal and purposeful:**
- `tmux-sensible`: ~100 lines of defaults (commonly accepted best practices)
- `tmux-yank`: Cross-platform clipboard support (essential for macOS/Linux)
- `catppuccin`: Theme consistency with Neovim (single theme = no bloat)

⚠️ **Manual installation friction:**
- Requires manual git cloning of TPM and catppuccin
- Not automated in dotfiles setup

**Recommendation:**
- ✅ Keep all plugins - no bloat
- 📝 Consider documenting setup in a `Makefile` or `install.sh` for easier bootstrapping

---

## 4. GitHub Actions / CI-CD Dependencies

### Workflows

1. **`claude.yml`** - Claude Code integration for issue/PR comments
   - **Action:** `anthropics/claude-code-action@v1`
   - **Status:** ✅ Active, well-configured

2. **`claude-code-review.yml`** - Automatic PR code reviews
   - **Action:** `anthropics/claude-code-action@v1`
   - **Status:** ✅ Active, well-configured

### Analysis

✅ **No bloat concerns:**
- Both workflows are lean and purposeful
- No unnecessary steps or dependencies
- Using pinned action versions (`@v1` - consider pinning to SHA for security)

⚠️ **Security Consideration:**
- Action versions use `@v1` (tag-based)
- **Best practice:** Pin to commit SHA for immutability
  ```yaml
  uses: anthropics/claude-code-action@v1  # Current
  uses: anthropics/claude-code-action@a1b2c3d4  # More secure (example)
  ```

**Recommendation:**
- ✅ Keep both workflows
- 📝 Consider pinning to commit SHAs for supply chain security

---

## 5. Missing Lock Files & Version Control

### Current State

```
nvim/lazy-lock.json      # .gitignored - plugin versions not tracked
tmux/plugins             # .gitignored - manually installed
```

### Concerns

⚠️ **Reproducibility Issues:**

1. **Neovim plugins** - lazy-lock.json is ignored
   - **Impact:** Different machines may install different plugin versions
   - **Risk:** Breaking changes in plugin updates can break config
   - **Example:** If `blink.cmp` v2.0 introduces breaking changes, fresh installs will break

2. **Tmux catppuccin** - Pinned to v2.1.3 in docs, but installed manually
   - **Impact:** Easy to forget to check out the correct tag
   - **Risk:** Visual inconsistencies if wrong version installed

### Recommendations

📝 **Option 1: Track lazy-lock.json (Recommended)**
```bash
# Remove from .gitignore
git rm --cached nvim/lazy-lock.json
git add nvim/lazy-lock.json
git commit -m "Track Neovim plugin versions for reproducibility"
```

**Pros:**
- Exact version reproducibility across machines
- Can audit plugin updates in git diffs
- Prevents surprise breakages from plugin updates

**Cons:**
- Lock file changes appear in git (but this is actually good for auditing)

---

📝 **Option 2: Automated Setup Script**

Create `install.sh` to automate dependency installation:

```bash
#!/usr/bin/env bash
# Automated dotfiles setup

# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# Install catppuccin (pinned version)
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git \
  ~/.config/tmux/plugins/catppuccin/tmux

# Bootstrap Neovim plugins
nvim --headless "+Lazy! sync" +qa

echo "✅ Dotfiles setup complete"
```

**Pros:**
- Reproducible setup across machines
- Documents installation process as code
- Easy onboarding for new machines

---

## 6. Security Audit

### Known Vulnerabilities

✅ **No known CVEs** in current dependencies (as of 2025-12-25)

### Security Recommendations

1. **GitHub Actions - Pin to commit SHAs**
   ```yaml
   # Before
   uses: actions/checkout@v4

   # After (example)
   uses: actions/checkout@b4ffde65f46336ab88eb53be808477a3936bae11  # v4.1.1
   ```

2. **Mason packages** - Auto-update disabled (good!)
   ```lua
   auto_update = false,  -- ✅ Prevents surprise breaking changes
   ```

3. **Neovim plugin updates** - Manual via `:Lazy sync`
   - ✅ Allows reviewing changes before updating
   - 📝 Review release notes before major version bumps

---

## 7. Outdated Packages Check

### Neovim Plugins

**How to check:**
```vim
:Lazy check  " Check for available updates
:Lazy log    " View plugin changelogs
```

**Recommendation:** Run `:Lazy check` monthly to stay current

---

### Mason Packages

**How to check:**
```vim
:Mason       " Open Mason UI, press 'U' to update all
```

**Recommendation:** Update formatters/LSPs quarterly or when specific bugs are fixed

---

### Tmux Plugins

**How to check:**
```bash
# In tmux, press prefix + U (e.g., Ctrl+a U)
# Or manually:
cd ~/.config/tmux/plugins/tpm && git pull
```

**Recommendation:** Update TPM plugins semi-annually (they rarely change)

---

## 8. Final Recommendations

### 🗑️ Remove (Bloat Reduction)

1. **`neoscroll.nvim`** - Purely cosmetic smooth scrolling
   ```lua
   # Delete file: nvim/lua/plugins/neoscroll.lua
   ```

2. **(Optional)** `indent-blankline.lua` - Visual guides (redundant with treesitter)
3. **(Optional)** `nvim-neo-tree.lua` - File tree (if you primarily use Telescope)

**Impact:** -1 to -3 plugins, faster startup, cleaner UI

---

### 📝 Add/Improve (Maintenance & Security)

1. **Track lazy-lock.json** for version reproducibility
   ```bash
   echo '# Removed: nvim/lazy-lock.json' >> .gitignore
   git add nvim/lazy-lock.json
   ```

2. **Create install.sh** for automated setup
   - Clone TPM automatically
   - Install catppuccin with correct tag
   - Bootstrap Neovim plugins

3. **Pin GitHub Actions** to commit SHAs (optional security hardening)

4. **Add update schedule** to CLAUDE.md
   ```markdown
   ## Dependency Updates
   - Neovim plugins: Monthly via :Lazy check
   - LSP/formatters: Quarterly via :Mason
   - Tmux plugins: Semi-annually via prefix+U
   ```

---

### ✅ Keep (No Changes Needed)

- All LSP servers (7) - well-scoped
- All formatters (5) - modern and efficient
- Tmux plugins (3) - minimal and purposeful
- Git plugins (3) - aligned with workflow
- Core IDE plugins (18-21) - essential functionality

---

## Appendix A: Dependency Inventory

### Complete Plugin List (22 total)

```
Core IDE (5):
├── nvim-lspconfig + mason + mason-lspconfig
├── nvim-treesitter
├── saghen/blink.cmp (+ LuaSnip, friendly-snippets)
└── nvim-telescope (+ fzf-native, ui-select, plenary)

UI/UX (7):
├── bufferline.nvim
├── lualine.nvim
├── indent-blankline.lua  ⚠️ Bloat candidate
├── nvim-neo-tree.lua     ⚠️ Bloat candidate
├── which-key.nvim
├── dressing.nvim
└── catppuccin.lua

Git (3):
├── gitsigns.nvim
├── diffview.nvim
└── lazygit.nvim

Editing (6):
├── conform.nvim
├── nvim-autopairs
├── mini.lua (mini.surround)
├── comment.nvim
├── flash.nvim
└── nvim-ufo.lua

Advanced (1):
├── trouble.nvim
└── neoscroll.nvim  ⚠️ High bloat - Remove
```

---

## Appendix B: Update Commands Reference

```bash
# Neovim plugins
nvim -c "Lazy check" -c "Lazy log"

# Mason LSP/formatters
nvim -c "Mason"

# Tmux plugins (in tmux session)
# Press: <prefix> + U

# Check for dotfiles updates
git fetch origin
git log HEAD..origin/main --oneline

# Neovim version
nvim --version

# Check LSP server versions
lua vim.print(vim.lsp.get_clients())
```

---

## Appendix C: Estimated Sizes

| Category | Count | Est. Size | Notes |
|----------|-------|-----------|-------|
| Neovim plugins | 22 | ~15-20 MB | Mostly Lua, some compiled binaries |
| LSP servers | 7 | ~50-100 MB | Language-specific, varies |
| Formatters | 5 | ~20-30 MB | Prettier is largest (~15 MB) |
| Tmux plugins | 3 | ~500 KB | Very lightweight |
| **Total** | - | **~90-150 MB** | Reasonable for full IDE setup |

**Comparison:**
- VS Code: ~500 MB+ (just the base app)
- IntelliJ IDEA: ~2-3 GB
- Neovim + plugins: ~100 MB ✅ Very lean

---

## Summary Table

| Category | Total | Issues | Bloat | Outdated | Action Needed |
|----------|-------|--------|-------|----------|---------------|
| Neovim Plugins | 22 | 0 | 3 candidates | Check via `:Lazy` | Remove 1-3 plugins |
| LSP Servers | 7 | 0 | 0 | Check via `:Mason` | None |
| Formatters | 5 | 0 | 0 | Check via `:Mason` | None |
| Tmux Plugins | 3 | 0 | 0 | Check via `<prefix>U` | None |
| GitHub Actions | 2 | 0 | 0 | Pin to SHA (optional) | Optional hardening |

**Overall Grade:** A- (Excellent with minor optimizations possible)

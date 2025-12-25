# Recommended Changes - Implementation Guide

**Based on:** DEPENDENCY_AUDIT.md
**Date:** 2025-12-25

## Quick Summary

Your dotfiles are in **excellent shape**. This guide provides optional optimizations for:
- **Bloat reduction:** Remove 1-3 unnecessary plugins
- **Reproducibility:** Track plugin versions
- **Automation:** Simplify fresh installs

**Time to implement:** 10-15 minutes

---

## Priority 1: Remove Bloat (High Impact, Low Effort)

### 1. Remove neoscroll.nvim (Recommended)

**Why:** Purely cosmetic smooth scrolling animation that conflicts with "lean and lite" philosophy.

```bash
# Remove the plugin file
rm nvim/lua/plugins/neoscroll.lua

# Restart Neovim and run
nvim -c "Lazy clean"
```

**Impact:** Faster scrolling, one less plugin to maintain

---

### 2. (Optional) Remove indent-blankline.lua

**Why:** Visual indent guides are redundant with treesitter's structural context.

**Consider removing if:** You prefer minimal visual noise

```bash
rm nvim/lua/plugins/indent-blankline.lua
nvim -c "Lazy clean"
```

---

### 3. (Optional) Remove nvim-neo-tree.lua

**Why:** File tree is redundant if you primarily use Telescope for file navigation.

**Consider removing if:** You rarely use `:Neotree` command

```bash
rm nvim/lua/plugins/nvim-neo-tree.lua
nvim -c "Lazy clean"
```

**Alternative:** Keep it if you like having a visual file tree occasionally

---

## Priority 2: Improve Reproducibility (Medium Impact, Low Effort)

### Track lazy-lock.json for version stability

**Problem:** Plugin versions aren't tracked, causing reproducibility issues across machines.

**Solution:**

```bash
# 1. Remove lazy-lock.json from .gitignore
# Edit .gitignore and remove the line: nvim/lazy-lock.json

# 2. Add the lock file to git
git add nvim/lazy-lock.json
git commit -m "Track Neovim plugin versions for reproducibility"
```

**Benefits:**
- Exact version reproducibility across machines
- Audit plugin updates in git diffs
- Prevents surprise breakages

---

## Priority 3: Automate Setup (Low Impact, Medium Effort)

### Create install.sh for fresh machine setup

**Problem:** Manual steps required for tmux plugins installation.

**Solution:** Create automated installation script.

```bash
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
```

**Usage:**

```bash
# Make executable
chmod +x install.sh

# Run on fresh machine
./install.sh
```

---

## Priority 4: Update CLAUDE.md Documentation (Low Impact, Low Effort)

### Add dependency update schedule

Add to CLAUDE.md under a new section:

```markdown
## Dependency Management

### Update Schedule

**Neovim Plugins:** Monthly
- Run `:Lazy check` to see available updates
- Run `:Lazy log` to review changelogs
- Run `:Lazy update` to install updates

**LSP Servers & Formatters:** Quarterly
- Run `:Mason` and press `U` to update all
- Or run `:MasonUpdate` to update individually

**Tmux Plugins:** Semi-annually
- In tmux, press `<prefix> + U` (e.g., `Ctrl+a U`)
- Or manually: `cd ~/.config/tmux/plugins/tpm && git pull`

### Checking for Outdated Dependencies

```bash
# Neovim plugins
nvim -c "Lazy check"

# Mason packages
nvim -c "Mason"

# Tmux plugins
# In tmux: <prefix> + U
```

### Version Control

Plugin versions are tracked in `nvim/lazy-lock.json` for reproducibility.
Review lock file changes before committing to understand what updated.
```

---

## Priority 5: (Optional) Security Hardening

### Pin GitHub Actions to commit SHAs

**Why:** Tag-based versions can be force-pushed (supply chain attack risk)

**Implementation:**

```yaml
# .github/workflows/claude.yml
# .github/workflows/claude-code-review.yml

# Before:
- uses: actions/checkout@v4

# After: (example - use actual latest SHA)
- uses: actions/checkout@b4ffde65f46336ab88eb53be808477a3936bae11  # v4.1.1

# Before:
- uses: anthropics/claude-code-action@v1

# After: (check anthropics/claude-code-action repo for latest SHA)
- uses: anthropics/claude-code-action@<commit-sha>  # v1.x.x
```

**How to find commit SHA:**

```bash
# Visit GitHub repo and copy commit SHA from latest release tag
# Example: https://github.com/actions/checkout/releases
```

**Trade-off:** More secure but requires manual updates to get new features

---

## Implementation Checklist

Use this checklist to track your progress:

### Immediate (5 minutes)

- [ ] Remove `nvim/lua/plugins/neoscroll.lua`
- [ ] Run `nvim -c "Lazy clean"` to remove plugin
- [ ] Test scrolling behavior (should feel snappier)

### Soon (10 minutes)

- [ ] Remove `nvim/lazy-lock.json` from `.gitignore`
- [ ] Run `git add nvim/lazy-lock.json`
- [ ] Commit: `git commit -m "Track Neovim plugin versions"`
- [ ] (Optional) Remove `indent-blankline.lua` if desired
- [ ] (Optional) Remove `nvim-neo-tree.lua` if you don't use it

### Optional (15-30 minutes)

- [ ] Create `install.sh` script (copy from Priority 3 above)
- [ ] Test `install.sh` on current machine
- [ ] Make executable: `chmod +x install.sh`
- [ ] Add to git: `git add install.sh`
- [ ] Update `CLAUDE.md` with dependency update schedule
- [ ] Pin GitHub Actions to commit SHAs (if desired)

---

## Testing Your Changes

After implementing changes:

```bash
# 1. Verify Neovim still works
nvim

# 2. Check plugin health
:checkhealth lazy

# 3. Verify LSP servers
:LspInfo

# 4. Check formatters
:ConformInfo

# 5. Test key workflows
#    - Open file with Telescope: <leader>ff
#    - Format buffer: <leader>cf
#    - Git blame: <leader>gb
#    - Search in project: <leader>fg (multigrep)
```

---

## Before & After Comparison

### Before
- 22 Neovim plugins
- No version tracking (reproducibility issues)
- Manual tmux plugin setup
- Smooth scrolling animation

### After (Recommended)
- 19-21 Neovim plugins (removed 1-3 bloat plugins)
- Version tracking via lazy-lock.json
- Automated setup via install.sh
- Snappier scrolling, cleaner config

---

## Questions & Considerations

### "Should I track lazy-lock.json?"

**Yes, if:**
- You use multiple machines and want identical plugin versions
- You want to audit plugin updates before accepting them
- You want reproducible builds

**No, if:**
- You prefer always getting latest versions
- You manage a single machine only

**Recommendation:** Track it. The benefits outweigh the minor git noise.

---

### "Is neoscroll.nvim really bloat?"

**Yes, because:**
- It's purely cosmetic (no functional benefit)
- Adds animation overhead
- Conflicts with "lean and lite" philosophy in CLAUDE.md

**No, if:**
- You genuinely enjoy the smooth scrolling experience
- Visual appeal is important to you

**Recommendation:** Try removing it for a week. If you miss it, add it back.

---

### "Should I remove nvim-neo-tree?"

**Check your usage:**

```vim
# In Neovim, check how often you use it:
:Neotree
```

**If you use it regularly:** Keep it
**If you haven't used it in months:** Remove it (you can always add it back)

---

## Rolling Back Changes

If you remove a plugin and miss it:

```bash
# 1. Restore the plugin file from git
git restore nvim/lua/plugins/neoscroll.lua

# 2. Restart Neovim and run
nvim -c "Lazy sync"
```

---

## Questions?

If you have questions about any recommendation:

1. Check the full audit report: `DEPENDENCY_AUDIT.md`
2. Review plugin documentation: `:help <plugin-name>`
3. Test changes in a separate branch first

---

**Happy optimizing! 🚀**

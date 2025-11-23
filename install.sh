#!/usr/bin/env bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$HOME"
SOURCE_DIR="$DOTFILES_DIR/home"

backup_file() {
  local target="$1"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    local backup="${target}.backup.$(date +%Y%m%d%H%M%S)"
    echo "Backing up $target -> $backup"
    mv "$target" "$backup"
  fi
}

link_item() {
  local src="$1"
  local rel="${src#$SOURCE_DIR/}"
  local dest="$HOME_DIR/$rel"

  mkdir -p "$(dirname "$dest")"

  backup_file "$dest"

  # -s: symlink, -f: overwrite existing symlink
  ln -sfn "$src" "$dest"
  echo "Linked $dest -> $src"
}

echo "Dotfiles directory: $DOTFILES_DIR"
echo "Source directory:   $SOURCE_DIR"
echo

# Find all files and dirs inside home/, excluding .git
while IFS= read -r path; do
  link_item "$path"
done < <(find "$SOURCE_DIR" -mindepth 1 -maxdepth 20 ! -path '*/.git/*')

echo
echo "✅ Done! Your dotfiles are now symlinked into \$HOME."
echo "You may want to restart your terminal session to apply any changes."
echo "Happy coding! 🚀"


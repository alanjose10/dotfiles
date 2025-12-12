# Load the local env vars if defined
if [ -f "$HOME/.env.local" ]; then
  . "$HOME/.env.local"
fi

# Source cargo env vars if present
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

export EDITOR="nvim"
export VISUAL="nvim"

# Created by `pipx` on 2025-10-22 23:10:33
export PATH="$PATH:~/.local/bin"

# add to path if ~/go/bin exists
if [ -d "$HOME/go/bin" ]; then
    export PATH="$PATH:$HOME/go/bin"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Only apply when running inside tmux
# to enable option/command + arrow to navigate text
if [[ -n $TMUX ]]; then
  # Emacs keymap (default in zsh)
  bindkey -M emacs '^[[1;3D' backward-word
  bindkey -M emacs '^[[1;3C' forward-word
  bindkey -M emacs '^[[D' beginning-of-line
  bindkey -M emacs '^[[C' end-of-line

  # for vi-mode
  bindkey -M viins '^[[1;3D' backward-word
  bindkey -M viins '^[[1;3C' forward-word
  bindkey -M viins '^[[D' beginning-of-line
  bindkey -M viins '^[[C' end-of-line
fi

# eval "$(pyenv init -)"
# if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# init zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# init plz autocomplete
if command -v plz >/dev/null 2>&1; then
  source <(plz --completion_script)
fi

# init kubeclt
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
  alias k=kubectl
  compdef k=kubectl
fi



autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '

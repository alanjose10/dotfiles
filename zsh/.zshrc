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
  cd() {   
    # Forward all args to zsh
    z "$@"
  }
fi

# init plz autocomplete
if command -v plz >/dev/null 2>&1; then
  source <(plz --completion_script)

  alias sef="plz sef"
  source <(sef autocomplete-script)
fi

# init kubeclt
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
  alias k=kubectl
  compdef k=kubectl

  export KUBECONFIG=~/.kube/config
  for file in ~/.kube/configs/*.yaml; do
    export KUBECONFIG=$KUBECONFIG:$file
  done
fi

# init fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '



# Tracing in SATs
jaeger_deploy() {
        docker run -d --name jaeger \
        -p 16686:16686 \
        -p 4318:4318 \
        jaegertracing/all-in-one:1.53
}
jaeger_teardown() {
        docker stop jaeger && docker rm jaeger
}
jaeger_upload() {
        while read -r line
        do
                curl http://localhost:4318/v1/traces --header 'Content-Type: application/json; charset=utf-8' --data "@-" <<< "$line"
        done < $1
        echo
}
test_and_trace() {
    plz test --rerun "$@" || return
    filepath="$(dirname $(plz query output $1))/$(plz query print $1 | grep "trace.json" | cut -d "'" -f 2)"
    echo "Traces exported to $filepath"
    jaeger_upload "$filepath"
}

# open nvim in a new window inside tmux
start-nvim() {
    # Current directory and its basename
    local dir session
    dir="$(pwd)"
    session="$(basename "$dir")"

    # If we're inside tmux already
    if [ -n "$TMUX" ]; then
        tmux new-window -c "$dir" "nvim"
    else
        # If session doesn't exist, create it
        if ! tmux has-session -t "$session" 2>/dev/null; then
            tmux new-session -d -s "$session" -c "$dir"
        fi

        # Create a new window running nvim (first window may already exist)
        tmux new-window -t "$session:" -c "$dir" "nvim"

        # Attach to the session
        tmux attach-session -t "$session"
    fi
}

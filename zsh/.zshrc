# Created by `pipx` on 2025-10-22 23:10:33
export PATH="$PATH:~/.local/bin"

# add to path if ~/go/bin exists
if [ -d "$HOME/go/bin" ]; then
    export PATH="$PATH:$HOME/go/bin"
fi

# add to path if ~/bin exists
if [ -d "$HOME/bin" ]; then
    export PATH="$PATH:$HOME/bin"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# init zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi



# init kubeclt
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
  alias k=kubectl
  compdef k=kubectl

  export KUBECONFIG=~/.kube/config
  
fi

# init fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '





# open nvim in a new window inside tmux
# TODO: add features
# - specify directory as argument (default cwd)
# - make name shorter
# - choose session to use if multiple found
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


# Do Mac-specific stuff here
if [[ $(uname) == "Darwin" ]]; then
  
  if [[ -d "/opt/homebrew/opt/libpq" ]]; then
    export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
    export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
  fi

fi
    

# Do workstation specific stuff here
if [[ $(uname) == "Linux" ]]; then

  # plz autocomplete
  if command -v plz >/dev/null 2>&1; then
    source <(plz --completion_script)
  fi
    
  for file in ~/.kube/configs/*.yaml; do
    export KUBECONFIG=$KUBECONFIG:$file
  done

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

fi

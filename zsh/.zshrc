# Add user binaries to PATH (prepend for higher priority)
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/go/bin" ]; then
  export PATH="$HOME/go/bin:$PATH"
fi

if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi

autoload -Uz compinit
compinit

export NVM_DIR="$HOME/.nvm"
# Lazy load nvm - only initialize when used (saves 200-500ms on startup)
nvm() {
  unset -f nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm "$@"
}
# Also lazy load node and npm to trigger nvm initialization
node() {
  unset -f node
  nvm > /dev/null 2>&1
  node "$@"
}
npm() {
  unset -f npm
  nvm > /dev/null 2>&1
  npm "$@"
}


# init zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# Common aliases
alias lg='lazygit'
alias vim='nvim'
alias vi='nvim'
if command -v bat >/dev/null 2>&1; then
  alias cat='bat'
fi



# kubectl namespace switcher - lists namespaces and optionally switches to one
kn() {
  kubectl get ns ; echo
  if [[ "$#" -eq 1 ]]; then
    kubectl config set-context --current --namespace $1 ; echo
  fi
  echo "Current namespace [ $(kubectl config view --minify | grep namespace | cut -d " " -f6) ]"
}

# kubectl context switcher - lists contexts and optionally switches to one
kc() {
  kubectl config get-contexts -o name ; echo
  if [[ "$#" -eq 1 ]]; then
    kubectl config use-context $1 ; echo
  fi
  echo "Current context [ $(kubectl config current-context) ]"
}

# init kubectl
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
# Two-line prompt: time, path, git branch on first line; exit status and $ on second
PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f
%(?..%F{red}✗%f )$ '





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

  # Build KUBECONFIG from all yaml files in ~/.kube/configs/
  if [[ -d ~/.kube/configs ]]; then
    local configs=(~/.kube/configs/*.yaml(N))
    if [[ ${#configs[@]} -gt 0 ]]; then
      export KUBECONFIG="$KUBECONFIG:${(j.:.)configs}"
    fi
  fi

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

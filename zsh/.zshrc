# Helper function to safely add directories to PATH (avoids duplicates)
add_to_path() {
  if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1:$PATH"
  fi
}

# Add user binaries to PATH (prepend for higher priority)
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/go/bin"
add_to_path "$HOME/bin"

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY          # Share history across terminals
setopt HIST_IGNORE_ALL_DUPS   # Don't save duplicates
setopt HIST_FIND_NO_DUPS      # Don't show duplicates in search
setopt HIST_IGNORE_SPACE      # Don't save commands starting with space

autoload -Uz compinit
# Only regenerate completion dump once per day for faster startup
if [[ -n ${HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# init zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# Common aliases
alias lg='lazygit'
alias vim='nvim'
alias vi='nvim'



# kubectl namespace switcher - lists namespaces and optionally switches to one
kn() {
  local ns
  local current_ns
  current_ns=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null || echo "default")
  ns=$(kubectl get namespaces -o name | sed 's/namespace\///' | \
    fzf --height 40% --reverse \
        --header "Current Namespace: $current_ns | enter: switch namespace, esc: exit" \
        --preview "kubectl get namespace {1}; echo; kubectl get pods --namespace {1} | head -n 15" \
        --preview-window right:40%)

  if [[ -n "$ns" ]]; then
    kubectl config set-context --current --namespace "$ns"
    echo "Switched to namespace: $ns"
  fi
}

# kubectl context switcher - lists contexts and switches to one
kc() {
  local context
  local current_context
  current_context=$(kubectl config current-context)
  context=$(kubectl config get-contexts -o name | \
    fzf --height 40% --reverse \
        --header "Current Context: $current_context | enter: use context, esc: exit" \
        --preview "kubectl config get-contexts {1}" \
        --preview-window right:60%)

  if [[ -n "$context" ]]; then
    kubectl config use-context "$context"
  fi
}

# init kubectl
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
  alias k=kubectl
  compdef k=kubectl

  export KUBECONFIG=~/.kube/config

fi

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
# Two-line prompt: time, path, git branch on first line; exit status and $ on second
PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f
%(?..%F{red}✗%f )$ '


# Tmux session switcher using fzf
# ctrl-x to kill a session, enter to attach/switch
ts() {
    # Check if any sessions exist
    if ! tmux list-sessions &>/dev/null; then
        echo "No tmux sessions"
        return 1
    fi

    local session
    # Format: session_name (windows) [attached]
    session=$(tmux list-sessions -F "#{session_name} (#{session_windows} windows)#{?session_attached, [attached],}" 2>/dev/null | \
        fzf --height 40% --reverse \
            --header "enter: attach, ctrl-x: kill, esc: exit" \
            --preview "tmux list-windows -t {1}" \
            --preview-window right:50% \
            --bind "ctrl-x:execute-silent(tmux kill-session -t {1})+reload(tmux list-sessions -F '#{session_name} (#{session_windows} windows)#{?session_attached, [attached],}' 2>/dev/null || echo '')")

    # Extract just the session name (first word)
    session="${session%% *}"
    [[ -z "$session" ]] && return

    if [[ -n "$TMUX" ]]; then
        tmux switch-client -t "$session"
    else
        tmux attach-session -t "$session"
    fi
}

# Git branch switcher - lists branches and switches to one
gb() {
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Not a git directory."
    return 1
  fi

  local branch
  branch=$(git branch --sort=-committerdate --color=always | \
    fzf --ansi --height 40% --reverse \
        --header "enter: checkout, esc: exit" \
        --preview "git log -n 20 --color=always --graph --date=short --pretty='format:%C(auto)%cd %h%d %s' \$(echo {} | sed 's/^[* ]*//' | awk '{print \$1}')" \
        --preview-window right:60%)

  # Clean up branch name (remove * and spaces)
  branch=$(echo "$branch" | sed 's/^[* ]*//' | awk '{print $1}')

  if [[ -n "$branch" ]]; then
    git checkout "$branch"
  fi
}


# Do Mac-specific stuff here
if [[ $(uname) == "Darwin" ]]; then

  if [[ -d "/opt/homebrew/opt/libpq" ]]; then
    export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
    export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
  fi

  # Init fzf
  if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
  fi
fi


# Do workstation specific stuff here
if [[ $(uname) == "Linux" ]]; then

  # init fzf
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

fi

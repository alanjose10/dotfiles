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

# Open nvim in a new tmux window
v() {
    # Show help if requested
    if [[ "$1" == "--help" || "$1" == "-h" ]]; then
        cat <<EOF
Usage: v [directory] [session-name]

Open nvim in a new tmux window with the given directory.

Arguments:
  directory      Target directory (default: current directory)
  session-name   Custom session name (default: shortened directory basename)

Examples:
  v                    # Open nvim in current directory
  v ~/projects/foo     # Open nvim in ~/projects/foo
  v . my-session       # Open nvim in current directory with custom session name

Window naming:
  Windows are named "[vim] <dirname>" for easy identification
EOF
        return 0
    fi

    local dir session base_session suffix window_name

    # Determine target directory
    if [[ -n "$1" ]]; then
        dir="$(cd "$1" 2>/dev/null && pwd)" || {
            echo "Error: Directory '$1' not found" >&2
            return 1
        }
    else
        dir="$(pwd)"
    fi

    # Set window name as "[vim] dirname"
    window_name="[vim] $(basename "$dir")"

    # Determine session name (custom or derived from directory)
    if [[ -n "$2" ]]; then
        session="$2"
    else
        base_session="$(basename "$dir")"
        # Truncate to 20 chars max for shorter names
        if [[ ${#base_session} -gt 20 ]]; then
            session="${base_session:0:17}..."
        else
            session="$base_session"
        fi
    fi

    # If already inside tmux, just create a new window
    if [[ -n "$TMUX" ]]; then
        tmux new-window -n "$window_name" -c "$dir" "nvim"
        return 0
    fi

    # Handle session name conflicts by appending a number
    base_session="$session"
    suffix=1
    while tmux has-session -t "$session" 2>/dev/null; do
        session="${base_session}-${suffix}"
        ((suffix++))
    done

    # Create new session with nvim window
    tmux new-session -d -s "$session" -n "$window_name" -c "$dir"
    tmux send-keys -t "$session" "nvim" C-m
    tmux attach-session -t "$session"
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

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


# Cross-terminal word/line navigation (Option/Alt/Cmd + arrows) for tmux and bare terminals
_word_left_keys=(
  $'\e[1;3D'  # xterm/gnome Alt+Left
  $'\e[1;9D'  # mac terminals Option+Left with ESC+ meta
  $'\eb'      # Meta+b fallback
)
_word_right_keys=(
  $'\e[1;3C'  # xterm/gnome Alt+Right
  $'\e[1;9C'  # mac terminals Option+Right with ESC+ meta
  $'\ef'      # Meta+f fallback
)
_line_start_keys=(
  $'\e[H'   # Home / Cmd+Left mappings
  $'\e[1~'  # Linux console Home
  $'\eOH'   # xterm Home
)
_line_end_keys=(
  $'\e[F'   # End / Cmd+Right mappings
  $'\e[4~'  # Linux console End
  $'\eOF'   # xterm End
)
for _km in emacs viins; do
  for _k in "${_word_left_keys[@]}"; do bindkey -M "$_km" "$_k" backward-word; done
  for _k in "${_word_right_keys[@]}"; do bindkey -M "$_km" "$_k" forward-word; done
  for _k in "${_line_start_keys[@]}"; do bindkey -M "$_km" "$_k" beginning-of-line; done
  for _k in "${_line_end_keys[@]}"; do bindkey -M "$_km" "$_k" end-of-line; done
done
unset _word_left_keys _word_right_keys _line_start_keys _line_end_keys _km _k

# eval "$(pyenv init -)"
# if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

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

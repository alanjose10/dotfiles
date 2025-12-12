function kn () {
  kubectl get ns ; echo
  if [[ "$#" -eq 1 ]]; then
    kubectl config set-context --current --namespace $1 ; echo
  fi
  echo "Current namespace [ $(kubectl config view --minify | grep namespace | cut -d " " -f6) ]"
}

function kc () {
  kubectl config get-contexts -o name ; echo
  if [[ "$#" -eq 1 ]]; then
    kubectl config use-context $1 ; echo
  fi
  echo "Current context [ $(kubectl config current-context) ]"
}

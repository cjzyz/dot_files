alias k='kubectl'

# kubectl completion
if command -v kubectl &> /dev/null; then
    source <(kubectl completion bash)
fi

# helm completion
if command -v helm &> /dev/null; then
    source <(helm completion bash)
fi

# flux completion
if command -v flux &> /dev/null; then
    source <(flux completion bash)
fi

# Sets the current namespace in the kubeconfig
function kns() {
  if [ -z "$1" ]; then
    echo "$(kubectl config view --minify --output 'jsonpath={..namespace}')"
  else
    if kubectl get namespace "$1" > /dev/null 2>&1; then
      kubectl config set-context --current --namespace="$1"
    else
      echo "Namespace '$1' does not exist."
    fi
  fi
}

# Sets the context in use in the kubeconfig
function kcx() {
  if [ -z "$1" ]; then
    kubectl config current-context
  else
    if kubectl config get-contexts "$1" > /dev/null 2>&1; then
      kubectl config use-context "$1"
    else
      echo "Context '$1' does not exist."
    fi
  fi
}

# Custom bash completion for custom functions
function _kns_complete() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "$(kubectl get namespaces -o jsonpath='{.items[*].metadata.name}')" -- "$cur") )
}

function _kcx_complete() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "$(kubectl config get-contexts -o name)" -- "$cur") )
}

complete -o default -F __start_kubectl k
complete -F _kcx_complete kcx
complete -F _kns_complete kns

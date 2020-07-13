# Setup fzf
# ---------
if [[ ! -d "/usr/local/opt/fzf" ]]; then
  echo "fzf.plugin.zsh: fzf is not yet installed, install and link it with:"
  echo '  `brew install fzf; /usr/local/opt/fzf/install; rm ~/.fzf.bash; rm ~/.fzf.zsh`'
  return
fi

if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"

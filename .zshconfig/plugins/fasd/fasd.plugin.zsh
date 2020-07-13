# fasd documentation: https://github.com/clvv/fasd

# check if fasd is installed
if (( ! ${+commands[fasd]} )); then
  return
fi

fasd_cache="${ZSH_CACHE_DIR}/fasd-init-cache"
if [[ "$commands[fasd]" -nt "$fasd_cache" || ! -s "$fasd_cache" ]]; then
  fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install \
    zsh-wcomp zsh-wcomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# Use both the local file at ~/.fasd and spotlight as backends
export _FASD_BACKENDS="spotlight native"

# Default fasd aliases 
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection

# Advanced aliases from fasd zsh plugin
alias v='f -e "$EDITOR"'    # open a file in vim
alias o='a -e open'         # open any file in the Mac-default program
alias j='zz'                # jump, with interactive selection

# Largely copied from oh-my-zsh (.oh-my-zsh/lib/completion.zsh)

autoload -U compinit && compinit            # zsh-style autocomplete
autoload -U +X bashcompinit && bashcompinit # load bash autocompletions as well

setopt nobeep               # don't beep on tab completes
setopt complete_in_word     # autocomplete from within a word
setopt always_to_end        # move cursor to end of word after complete

unsetopt menu_complete      # don't automatically complete a word without sufficientmatch
setopt auto_menu            # after tabbing once 


# Pretty completion on "kill <process_name>"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# bindkey -M menuselect '^o' accept-and-infer-next-history
zstyle ':completion:*:*:*:*:*' menu select

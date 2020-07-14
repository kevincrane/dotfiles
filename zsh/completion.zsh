# Largely copied from oh-my-zsh (.oh-my-zsh/lib/completion.zsh)

# Load all autocomplete functions
autoload -U +X bashcompinit && bashcompinit # load bash autocompletions as well

setopt nobeep               # don't beep on tab completes
setopt complete_in_word     # autocomplete from within a word
setopt always_to_end        # move cursor to end of word after complete

unsetopt menu_complete      # don't automatically complete a word without sufficient match
setopt auto_menu            # after tabbing once, step through the menu of completions


# Fuzzy matching when doing autocomplete
# zstyle ':completion:*' matcher-list 'r:|?=** m:{a-z\-}={A-Z\_}'

# Pretty completion on "kill <process_name>"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

zstyle ':completion:*' menu select              # Highlights selected item in completion list
zstyle ':completion:*' insert-tab pending       # Pasting with tabs doesn't perform completion
zstyle ':completion:*' verbose true             # provide verbose completion information
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}   # activate color-completion
zstyle ':completion:*:processes' command 'ps -au$USER'          # on processes completion complete all user processes

# Set completion cache location
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$ZSH_CACHE_DIR/"

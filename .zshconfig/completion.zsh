# Largely copied from oh-my-zsh (.oh-my-zsh/lib/completion.zsh)

# Build up function completion fpath from plugin directories
PLUGIN_DIR=${0:a:h}/plugins
for plugin in $(ls $PLUGIN_DIR); do
  fpath=($fpath $PLUGIN_DIR/$plugin)
done

# Load all autocomplete functions
autoload -U compinit && compinit -d $ZSH_CACHE_DIR/zcompdump-$ZSH_VERSION
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

# Highlights selected item in completion list
zstyle ':completion:*' menu select

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# Set completion cache location
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$ZSH_CACHE_DIR/"

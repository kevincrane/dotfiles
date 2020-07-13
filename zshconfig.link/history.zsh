# Copied from oh-my-zsh (.oh-my-zsh/lib/completion.zsh)

# Usage:
# -c : delete history file
# -v : print all history events
#  # : print last N events (must be positive)
# default behavior: print last 15 events

HIST_STAMPS="mm/dd/yyyy"

## History wrapper
function omz_history {
  local clear list verbose
  zparseopts -E c=clear l=list v=verbose

  if [[ -n "$clear" ]]; then
    # if -c provided, clobber the history file
    echo -n >| "$HISTFILE"
    echo >&2 History file deleted. Reload the session to see its effects.
  elif [[ -n "$list" ]]; then
    # if -l provided, run as if calling `fc' directly
    builtin fc "$@"
  elif [[ ${@[-1]-} = "$verbose" ]]; then
    # if -v provided, print all history events (from 1)
    builtin fc -l "${@[0,-2]}" 1
  elif [[ ${@[-1]-} = *[0-9]* ]]; then
    # if a number was provided, print that many history events
    builtin fc -l ""${@[0,-2]}"" -"${@[-1]-}"
  else
    # default behavior, if no arguments provided, print the last 15 events
    builtin fc -l "$@" -15
  fi
}

# Timestamp format
case ${HIST_STAMPS-} in
  "mm/dd/yyyy") alias history='omz_history -f' ;;
  "dd.mm.yyyy") alias history='omz_history -E' ;;
  "yyyy-mm-dd") alias history='omz_history -i' ;;
  "") alias history='omz_history' ;;
  *) alias history="omz_history -t '$HIST_STAMPS'" ;;
esac

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

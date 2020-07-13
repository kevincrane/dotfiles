# Copied from oh-my-zsh history plugin:
#   https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/history/history.plugin.zsh

# Modified to match my own changes to the history command in history.zsh, which
# limited history's output to 15 lines; -v flag prints entire history
alias h='history'
alias hs='history -v | grep'
alias hsi='history -v | grep -i'

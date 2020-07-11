##### kcrane's zsh config #####

# TODO
# - load plugins as submodules
#   - in plugins.zsh, source the appropriate file for each plugin
#   - for each plugin in the list below, add as submodule, source from plugins.zsh
# - Add a bin directory to dotfiles
# - Add an install dir with scripts to install various things
#   - one folder for each app to install
# - bootstrap.sh
#   - find every directory; mkdir -p each of the directories
#   - find every file; symlink each file to same location in ~
#   - add option --clean; does same process in reverse, but deletes symlink for files and rmdir for directories
# - Create diff script; call it before running bootstrap.sh and ask for confirmation to proceed if diffs present
# - find remaining rc files to make
#   - vimrc
#   - gitconfig
#   - Terminal config (also make red and blue more obvious colors for ls; and don't highlight directories in ls)
# - find unique macos settings
# - find all homebrew apps
# - done, go play with your computer


# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Load all zsh configs fromm .zshconf
for file in $HOME/.zshconfig/*.zsh; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;


### Miscellaneous configs ###
# Note: can be moved to misc.zsh if too unwieldy here

# Allow the shell to be pretty
autoload -U colors && colors
setopt auto_cd              # Automatically cd if you type just a directory name
setopt interactivecomments  # Recognize comments on the CLI

# Move cursor between words with Bash behavior
autoload -U select-word-style && select-word-style bash



# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    colorize
    git
    history
    history-substring-search
    jsontools
    nmap
    ripgrep
    zsh-syntax-highlighting
)

# The git plugin installs 150 aliases; this undoes all of them.
# unalias ${(k)aliases[(R)git *]}
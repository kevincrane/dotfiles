##### kcrane's zsh config #####

# TODO
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
# - README (how to bootstrap, how to clean, how to add new plugins, how to add new dotfiles, how to install apps, how add or update plugins)
# - done, go play with your computer


# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";
export ZSH_CACHE_DIR="$HOME/.cache/zsh"
mkdir -p $ZSH_CACHE_DIR

# Move cursor between words with Bash behavior (must be called before plugins)
autoload -U select-word-style && select-word-style bash

# Load all zsh configs fromm .zshconf
for file in $HOME/.zshconfig/*.zsh; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;


### Extra configs ###
# NB: can be moved to misc.zsh if too unwieldy here

# Allow the shell to be pretty
autoload -U colors && colors
setopt auto_cd              # Automatically cd if you type just a directory name
setopt interactivecomments  # Recognize comments on the CLI

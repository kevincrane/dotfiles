#!/usr/bin/env zsh

# Make vim the default editor.
export EDITOR='vim';

export PAGER='less';

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='50000';
export HISTFILESIZE="${HISTSIZE}";
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

# Avoid issues with `gpg` as installed via Homebrew.
# https://stackoverflow.com/a/42265848/96656
export GPG_TTY=$(tty);

# Hide the “default interactive shell is now zsh” warning on macOS.
export BASH_SILENCE_DEPRECATION_WARNING=1;

# Set Homebrew root directory
export BREW_PREFIX=$(brew --prefix)

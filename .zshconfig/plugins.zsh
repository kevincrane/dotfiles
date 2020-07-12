#!/usr/bin/env zsh

PLUGIN_DIR=.zshconfig/plugins

# Plugins should be found in .zshconfig/plugins
# Each one is sourced from either <plugin_name>/{<plugin_name>.zsh, _<plugin_name>}
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

source $PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
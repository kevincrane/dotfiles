#!/usr/bin/env zsh

PLUGIN_DIR=${0:a:h}/../.zshconfig/plugins

for plugin in $(ls $PLUGIN_DIR); do
    cd $PLUGIN_DIR/$plugin
    if builtin test -e $PLUGIN_DIR/$plugin/.git; then
        current_branch=$(git rev-parse --abbrev-ref HEAD)
        echo "=> Pulling latest version of $plugin (branch $current_branch)...";
        git pull;
    else
        echo "$PLUGIN_DIR/$plugin/.git"
        echo "=> Skipping plugin $plugin, not a git repo"
    fi
done
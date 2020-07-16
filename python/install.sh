#!/usr/bin/env zsh

echo "=> Installing python3 and global packages"
brew install python3
brew install ipython

if [ -L /usr/local/bin/python ]; then
  unlink /usr/local/bin/python
fi
if [ -L /usr/local/bin/pip ]; then
  unlink /usr/local/bin/pip
fi
ln -s /usr/local/bin/python3 /usr/local/bin/python
ln -s /usr/local/bin/pip3 /usr/local/bin/pip

eval "`pip completion --zsh`"     # enable pip autocompletion


# Install packages used by python3
echo "=> Installing python3 global packages"
pip install requests


echo "=> Done installing python3 and global packages"

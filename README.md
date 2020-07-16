# Kevin's dotfiles
Configuration files for a new MacOS installation; includes zsh, macos, vim, sublime, etc.

## Components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/install.sh**: Any file named `install.sh` is executed when you run `script/install`. To avoid being loaded automatically, its extension is `.sh`, not `.zsh`.
- **topic/\*.link**: Any file ending in `*.link` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `scripts/bootstrap`.

## Install

Run this:

```sh
git clone --recursive https://github.com/kevincrane/dotfiles.git ~/.dotfiles
ln -s ~/.dotfiles ~/workspace/dotfiles  # optional, but i instinctively expect projects in workspace
cd ~/.dotfiles
scripts/bootstrap.sh
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.link`,
which sets up a few paths that'll be different on your particular machine.

### dot

Run `dot` periodically as well. This is a simple script that installs some
dependencies, sets sane macOS defaults, and so on. Tweak this script, and
occasionally run `dot` from time to time to keep your environment fresh and
up-to-date. You can find this script in `bin/`.

* sets up your gitconfig.local file
* updates git plugin submodules
* sets default MacOS config values (`macos/set-defaults.sh`)
* installs homebrew & all apps (`homebrew/brew.sh`)
* runs every `install.sh` script (`**/install.sh`)

## Common Operations

### How to add new dotfiles

If we're starting a new app or topic, create a new directory. Put any installation
steps in `install.sh`. Put anything to run on ZSH startup in `<config>.zsh`. If
the config will be symlinked from the HOME directory, create `<config>.link`.
The more rare files are `path.zsh` (always loaded first) and `completion.zsh`
(always loaded last).

### How to add a new ZSH plugin

Create a new directory at `zsh/plugins/<plugin>`. Any file at `<plugin>.plugin.zsh`
or `<plugin>.zsh` will get loaded on startup. This is the format followed by
Oh-My-Zsh, so it should be easy download either the `.plugin.zsh` file or the
encompassing folder straight into place. You can also use `_<plugin>` files
for autocompletion configs.

Finally, add this new plugin to the list `plugins` in `zsh/plugins.zsh`.

Because we can use Oh-My-Zsh plugins, occasionally you just want to link straight
to the plugin's git repo instead of copying everything to our own. You can do
that with:

```sh
git submodule add https://github.com/<plugin_repo> zsh/plugins/<plugin>
git pull --recurse-submodules
```

### How to install new Homebrew apps

New Homewbrew apps get installed from `homebrew/brew.sh`. If you need to configure
any extra environment variables, aliases, or configs for these apps can go in
`homebrew/homebrew_config.zsh`.

### How to save the configurations for an app

If an app needs extra configuration beyond just installing it, first make sure
it's in its own app folder (e.g. `sublime3`). Then you'll need to identify
which settings need to be saved in the dotfile repo.

If you need to link a full configuration file, you can symlink it as follows
in `install.sh`. This is more dangerous than I'd lke since you're deleting the
original, so be sure the original is copied into this repo before you run it.
After that you should be deleting the original and then immediately linking it
back to itself. See `sublime3/install.sh` for an example.

```sh
CURRENT_DIR="${0:a:h}"
rm <original_config>
ln -s $CURRENT_DIR/<dotfile_config> <original_config>
```

The other option is to manually write new config files to Mac's `plist` config
system. This is better for smaller apps that don't have as many configurations.
See `rectangle/install.sh` for an example.

```sh
defaults read <app.package.name>  # view all values currently set
defaults write <app.package.name> config1 -bool true
defaults write <app.package.name> config2 -int 123
```

The config locations and package names are sometimes hard to track down, but a
very good repository of them lives with [mackup](https://github.com/lra/mackup/tree/master/mackup/applications).

### How to save a new Mac preference setting

Mac config values are set in `macos/set-defaults.sh`. This gets called as a
part of `dot` as well. Each value is set as following:

```sh
defaults read  # this will print every config value from every app
defaults read <scope>  # print config values from this scope
defaults write <scope> <config> -bool true
defaults write <scope> <config> -string "words"
defaults write <scope> <config> -int 123
defaults write <scope> <config> -float 0.123

```

`<scope>` can be an app package (e.g. `com.knollsoft.Rectangle`) or framework
(`NSGlobalDomain`) or any string identifier.

### How to restore backed up configs

There are several locations that'll get linked when you run `bootstrap.sh` and
`dot`. Unfortunately it's not very automatic to restore your configs, but it's
not impossible.

To restore backed up dotfiles in the $HOME directory:

```sh
ll -a ~/ | grep '.bak'
mv <dotfile>.bak <dotfile>  # for each backed up dotfile
```

To delink your configs from the `dotfiles` repo:

```sh
rg -g install.sh "ln -s"  # these files are linking their config files to an application
# find the original config location
mv ~/.dotfile/<app>/<config_file> <original_location>/<config_file>
```

## Acknowledgements
Thanks to @holman for his great [dotfiles repo](https://github.com/holman/dotfiles) that was heavily cloned and referenced when writing this one.

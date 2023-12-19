# Dotfiles 

#### Default configuration folder: `$HOME/.config`

#### Default clone path: `$HOME/dotfiles`

## repo.sh
A convinience script used to automatically create github repository from the command line.

### Requirements
1. Github personal token with OAuth `public_repo` scope should be present at `$HOME/.config/gh-repocreate.token`

### Usage
```console
repo.sh 
+Reading token...
+Enter repo name: dummyrepo
+Enter repo desc: dummydesc
+Creating repo...
+Created repo with name: dummyrepo !
```

### Todos
- Add support for opening the repo on browser after creation
- Proper error handling 

## tmux.conf
Tmux configuration file.

### Requirements 
1. Install [TPM](https://github.com/tmux-plugins/tpm)

## hammerspoon.lua
hammerspoon configuration file

### Requirements 
1. Install [AppLauncher](https://www.hammerspoon.org/Spoons/AppLauncher.html)

## .zshrc


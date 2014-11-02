# Installation
1. Initialize the repo

  If there's already a ~/.config directory...
  ```bash
  cd ~/.config
  git init
  git remote add origin git@github.com:smithdalec/.config.git
  ```
  Otherwise...
  ```bash
  cd ~
  git clone git@github.com:smithdalec/.config.git .config
  ```
1. Set-up symlinks
```bash
ln -s ~/.config/atom ~/.atom
ln -s ~/.config/git/gitconfig ~/.gitconfig
ln -s ~/.config/git/gitignore ~/.gitignore
ln -s ~/.config/PhpStorm/WebIde70 ~/Library/Preferences/WebIde70
ln -s ~/.config/iTerm/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
```

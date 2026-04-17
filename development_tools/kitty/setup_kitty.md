# Install
```bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
mkdir -p ~/.local/bin
ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/kitty

echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc  
source ~/.bashrc
```

# Add shortcut
- Settings -> Keyboard -> View and Customize Shortcuts -> Custom Shortcuts
- Click `Add Shortcut`
    - Name: kitty
    - Command: /home/dustan-kraus/.local/kitty.app/bin/kitty
    - Shortcut: press `Ctrl + Alt + t`

# Config
```bash
git clone git@github.com:kraudust/computer_setup.git
ln -s ~/git/personal/computer_setup/kitty ~/.config/kitty
```
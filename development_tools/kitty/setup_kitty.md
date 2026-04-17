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
    - Command: kitty --start-as=maximized
    - Shortcut: press `Ctrl + Alt + t`

# Config
```bash
git clone git@github.com:kraudust/computer_setup.git
ln -s ~/git/personal/computer_setup/kitty ~/.config/kitty
```

# Font setup
Select font and uncheck titlebar as here, except select the mono version of JetBrainsMono: (JetBrainsMono Nerd Font Mono Regular)

- To get font go to: [nerd font](https://www.nerdfonts.com/font-downloads)
    - Download font choice from link above (JetBrains Mono is my top choice right now)
    - extract and copy font folder to /usr/share/fonts/truetype/ folder
    - Will need to select the font for whatever terminal you are using (kitty, [[terminator_setup]], etc.)
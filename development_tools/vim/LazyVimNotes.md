```toc
title: Table of Contents
```
# LazyVim Installation
[http://www.lazyvim.org/installation](http://www.lazyvim.org/installation)

## Prerequisites
Install neovim first. See [neovim_setup](neovim_setup.md) note

a [nerd font](https://www.nerdfonts.com/font-downloads)
- Download font choice from link above (JetBrains Mono is my top choice right now)
- extract and copy font folder to /usr/share/fonts/truetype/ folder
- Will need to select the font for whatever terminal you are using (kitty, [[terminator_setup]], etc.)

lazygit
```bash
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
```

ripgrep
```shell
sudo apt-get install ripgrep
```

fd
```shell
sudo apt install fd-find
ln -s $(which fdfind) ~/.local/bin/fd
```

fzf
```bash
sudo apt install fzf
```

Need this so mason can install Ruff or something like that
```bash
sudo apt install python3-venv
```

For language stuff
```bash
sudo apt update
sudo apt install nodejs npm
sudo npm install -g pyright
```

If getting pyright issues:
```bash
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
source ~/.bashrc  # or source ~/.zshrc
nvm install --lts
nvm use --lts
npm uninstall -g pyright
npm install -g pyright
```

A terminal that supports true color and undercurl (I don't see the appeal of this):
terminator (my preference)
```
sudo apt install terminator
```

to test for true color:
```shell
awk 'BEGIN{
    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
    for (colnum = 0; colnum<77; colnum++) {
        r = 255-(colnum*255/76);
        g = (colnum*510/76);
        b = (colnum*255/76);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
}'
```

## Installation
Forked the lazyvim repo [https://github.com/LazyVim/starter](https://github.com/LazyVim/starter) so I have my own copy that I can modify, install by cloning the fork to local machine using the command below.

```shell
git clone https://github.com/kraudust/starter.git ~/.config/nvim
```

Start Neovim
```shell
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` to view current plugin status. Hit `q` to close the window.

Run :LazyHealth after installation to check install.

See: [http://www.lazyvim.org/keymaps](http://www.lazyvim.org/keymaps) for keymaps.

# LazyVim Plugins
## Extras to load
- Start vim `nvim`
- From the startup page, hit `x` to load Lazy Extras
- Press `x` by each plugin or language you want to install
- Recommended to install the languages you use as a minimum
- probably should explore the recommended plugins

# Textbook on LazyVim
See textbook [here](https://lazyvim-ambitious-devs.phillips.codes/course/chapter-1/)
## Notes
### Getting Around
- In normal mode, s to seek, then start typing the word and use the letters to jump there
- `ctrl-d` and `ctrl-u` to move a half page down or up
- `ctrl-f` and `ctrl-b` to move a full page forward or back
- `zz` `zt` `zb` to move the current line to the middle, top and bottom
- Moving by words: `b` `e` `w` move to beginning, end, and to next word of words
- Moving to specific line number: `:100` or `100G` or `gg` to top and `G` to bottom

# Customizations
## Files and what they do:
\<space>? neo-tree help when in neotree
\<leader>f Right now this doesn't search into git submodules, I need it to.
I want to turn off diagnostics, or at least get it working where it can find files etc.

TODO: Explore all the plugins used and make my own config that just uses the ones I want and then ditch lazy vim while still using the lazy plugin manager

This contains all the plugins used: [https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/plugins](https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/plugins)

Instructions are here: [https://www.lazyvim.org/plugins](https://www.lazyvim.org/plugins)
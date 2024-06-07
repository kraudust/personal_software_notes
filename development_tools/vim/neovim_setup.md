```toc
title: Table of Contents
```
# Neovim Installation
Install some dependencies with the commands below:
```shell
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip
```
Install [neovim](https://github.com/neovim/neovim/tree/master) from source (latest stable isn't in apt on ubuntu 20.04):
```shell
sudo apt-get install ninja-build gettext cmake unzip curl build-essential
git clone git@github.com:neovim/neovim.git
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=Release
sudo make install
```
# LazyVim Installation
[http://www.lazyvim.org/installation](http://www.lazyvim.org/installation)

## Prerequisites
a [nerd font](https://www.nerdfonts.com/font-downloads)
- Download font choice from link above (JetBrains Mono is my top choice right now)
- extract and copy font folder to /usr/share/fonts/truetype/ folder
- Will need to select the font for whatever terminal you are using (kitty, [[terminator_setup]], etc.)

lazygit
```shell
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
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

# Customizations
## Files and what they do:
Things I want, relative line numbers
\<space>? neo-tree help when in neotree
\<leader>f Right now this doesn't search into git submodules, I need it to.
I want to turn off diagnostics, or at least get it working where it can find files etc.



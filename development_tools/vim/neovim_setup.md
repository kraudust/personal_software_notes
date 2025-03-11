```toc
title: Table of Contents
```

# Neovim Installation

Install some dependencies with the commands below:
```shell
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip
```

## Appimage
- Go here and download the latest .appimage (nvim-linux-x86_64.appimage): [https://github.com/neovim/neovim/releases/](https://github.com/neovim/neovim/releases/)
- Run the following to make it executable and have it be runnable from anywhere with `nvim`:
```bash
sudo apt install fuse
chmod u+x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
```

## From Source
Install [neovim](https://github.com/neovim/neovim/tree/master) from source (latest stable isn't in apt on ubuntu 20.04):
```shell
sudo apt-get install ninja-build gettext cmake unzip curl build-essential
git clone git@github.com:neovim/neovim.git
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=Release
sudo make install
```







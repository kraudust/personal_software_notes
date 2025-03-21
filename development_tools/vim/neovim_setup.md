```toc
title: Table of Contents
```

# Neovim Installation

Install some dependencies with the commands below:
```shell
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip
```

## From Source
Install [neovim](https://github.com/neovim/neovim/tree/master) from source (latest stable isn't in apt on ubuntu 20.04) (https://github.com/neovim/neovim/blob/master/BUILD.md)
```shell
sudo apt-get install ninja-build gettext cmake unzip curl build-essential
git clone git@github.com:neovim/neovim.git
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
```







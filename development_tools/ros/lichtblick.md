# Installation
## Install dependencies
### Node.js
- Download Node.js from [here](https://nodejs.org/en/) by clicking the `Download Node.js (LTS)` button. This will download a  `node-v22.13.0-linux-x64.tar.xz` file
- Extract the files: `tar -xf node-v22.13.0-linux-x64.tar.xz`
- Move the file to where you're going to use it: `sudo mv node-v22.13.0-linux-x64 /usr/local/node-v22.13.0`
- Update your `.bashrc` file by adding the following line: `export PATH=/usr/local/node-v22.13.0/bin:$PATH` and resource your bashrc file `source ~/.bashrc`

## Install repo
The Lichtblick repo is [here](https://github.com/Lichtblick-Suite/lichtblick). Install it with the following.
```bash
git clone https://github.com/lichtblick-suite/lichtblick.git
git lfs pull
corepack enable
yarn install
yarn run desktop:build:prod
yarn run package:linux
```

## Create a desktop shortcut
If you don't want to launch Lichtblick from the terminal each time (with `./dist/linux-unpacked/lichtblick`), you can create a clickable desktop shortcut using the following:

Open a terminal and create a .desktop file in the applications directory
```bash
code ~/.local/share/applications/lichtblick.desktop
```

Populate it with the following contents (replacing the `Exec` and `Icon` paths with the correct path to the `lichtblick` directory)
```
[Desktop Entry]
Version=1.0
Name=Lichtblick
Comment=Run the Lichtblick app
Exec=/home/dustan-kraus/git/personal/lichtblick/dist/linux-unpacked/lichtblick
Icon=/home/dustan-kraus/git/personal/lichtblick/packages/suite-desktop/resources/icon/icon.png
Terminal=false
Type=Application
Categories=Utility;
```

Make it executable
```bash
chmod +x ~/.local/share/applications/lichtblick.desktop
```

## Running
- Follow instructions to create a desktop shortcut above, or launch it with: `./dist/linux-unpacked/lichtblick`


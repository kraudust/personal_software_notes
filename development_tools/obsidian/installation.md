Run the following (going to the repo to identify the current version):
```bash
sudo apt remove obsidian
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.8.7/obsidian_1.8.7_amd64.deb
sudo dpkg -i obsidian_1.8.7_amd64.deb 
sudo apt-get install -f
```
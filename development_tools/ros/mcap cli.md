```bash
# Find version here: https://github.com/foxglove/mcap/releases
wget https://github.com/foxglove/mcap/releases/download/releases/mcap-cli/v0.0.62/mcap-linux-amd64
chmod +x mcap-linux-amd64
sudo mv mcap-linux-amd64 /usr/local/bin/mcap
# Verify
mcap --version  
mcap --help
```
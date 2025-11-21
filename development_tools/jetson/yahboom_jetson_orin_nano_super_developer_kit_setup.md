# Assembling the acrylic case:
- https://www.youtube.com/watch?v=ZdqbEAZZopE&ab_channel=YahboomTechnology

# Connecting to Jetson
- `ssh jetson@192.168.55.1`, password `yahboom`

# Docker with nvidia runtime
- Clone this repo to the jetson: [https://github.com/jetsonhacks/install-docker](https://github.com/jetsonhacks/install-docker "https://github.com/jetsonhacks/install-docker")
- Run the install script: bash ./install_nvidia_docker.sh
- Run the configure script: bash ./configure_nvidia_docker.sh
- Restart the vehicle

# Tips
Don't enter the password everytime you ssh or scp:
```bash
ssh-copy-id -i ~/.ssh/id_ed25519.pub jetson@192.168.55.1
```

# Power modes
![](Pasted%20image%2020250930132659.png)

# Virtual Display
- Some stuff needs a display or will seg fault (pangolin viewer, etc.) if ssh'd in with no display. Do the following to set up a virtual display.
```bash
apt-get install -y xvfb
Xvfb :99 -screen 0 1920x1080x24 &  
export DISPLAY=:99  
export XDG_RUNTIME_DIR=/tmp/runtime-root
```
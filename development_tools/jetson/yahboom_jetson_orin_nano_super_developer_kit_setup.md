# Assembling the acrylic case:
- https://www.youtube.com/watch?v=ZdqbEAZZopE&ab_channel=YahboomTechnology

# Connecting to Jetson
- `ssh jetson@192.168.55.1`, password `yahboom`

# Docker with nvidia runtime
- Clone this repo to the jetson: [https://github.com/jetsonhacks/install-docker](https://github.com/jetsonhacks/install-docker "https://github.com/jetsonhacks/install-docker")
- Run the install script: bash ./install_nvidia_docker.sh
- Run the configure script: bash ./configure_nvidia_docker.sh
- Restart the vehicle
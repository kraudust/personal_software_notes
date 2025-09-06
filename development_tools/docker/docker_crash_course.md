```toc
title: Table of Contents
```
# Useful tutorials/links
- [https://learndocker.online/](https://learndocker.online/) -> [Hands on Tutorial Notes](#Hands%20on%20Tutorial%20Notes)
- [https://blog.gruntwork.io/a-crash-course-on-docker-34073b9e1833](https://blog.gruntwork.io/a-crash-course-on-docker-34073b9e1833) -> This page mostly comes from this link
# What is docker
- Virtualizes the user space (processes, memory, mount points, and networking), isolating code from host machine and any other containers. 
![[images/Pasted image 20241001133758.png]]

# Install docker
Run the INstall docker script and the Install docker nvidia script.
Follow the [instructions on the Docker website](https://docs.docker.com/engine/install/ubuntu) to install Docker Engine for ubuntu. Once it’s installed, you should have the `docker` command available on your command line.
Instructions below from: [https://docs.docker.com/engine/install/ubuntu](https://docs.docker.com/engine/install/ubuntu)
1. Run the following to uninstall all conflicting packages:
```bash
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras

# Images, containers, volumes, or custom configuration files on your host aren't automatically removed. To delete all images, containers, and volumes:
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
```
1. Install using the apt repository. Follow the instructions on the website linked above. Or if that doesn't work, the website also has some instructions to install from a package. You can do that too.
2. Install from a package
    1. Go to the following link to download the .deb file for your distribution (selecting pool/stable/amd64)[https://download.docker.com/linux/ubuntu/dists/](https://download.docker.com/linux/ubuntu/dists/)
    2. Download the following `deb` files for the Docker Engine, CLI, containerd, and Docker Compose packages:
        - `containerd.io_<version>_<arch>.deb`
        - `docker-ce_<version>_<arch>.deb`
        - `docker-ce-cli_<version>_<arch>.deb`
        - `docker-buildx-plugin_<version>_<arch>.deb`
        - `docker-compose-plugin_<version>_<arch>.deb`
    3. Install the `.deb` packages. Update the paths in the following example to where you downloaded the Docker packages.
    ```bash
    sudo dpkg -i ./containerd.io_<version>_<arch>.deb \
    ./docker-ce_<version>_<arch>.deb \
    ./docker-ce-cli_<version>_<arch>.deb \
    ./docker-buildx-plugin_<version>_<arch>.deb \
    ./docker-compose-plugin_<version>_<arch>.deb
    ```
    4. Verify that the Docker Engine installation is successful by running the hello-world image.
    ```bash
    sudo service docker start
    sudo docker run hello-world
    ```
    5. Receiving errors when trying to run without root? The `docker` user group exists but contains no users, which is why you’re required to use `sudo` to run Docker commands. Continue to [Linux postinstall](https://docs.docker.com/engine/install/linux-postinstall) to allow non-privileged users to run Docker commands and for other optional configuration steps.

# Install docker script
```
#!/bin/bash

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

# Install docker nvidia script
```
#!/bin/bash

# get nvidia container path
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# update refs
sudo apt-get update

# install
sudo apt-get install -y nvidia-container-toolkit

# add config to docker runtime
sudo bash -c "echo '{\"default-runtime\":\"nvidia\",\"runtimes\":{\"nvidia\":{\"path\":\"nvidia-container-runtime\",\"runtimeArgs\":[]}}}' > /etc/docker/daemon.json"

# restart
sudo systemctl restart docker
```

# Run Docker Image
You can run Docker images locally using the `docker run` command, which has the following syntax:

```bash
docker run <IMAGE> [COMMAND]
```

Where `IMAGE` is the Docker image to run and `COMMAND` is an optional command to execute. For example, here’s how you can run a Bash shell in an Ubuntu 20.04 Docker image (note the command below includes the `-it` flag so you get an interactive shell where you can type):

```bash
docker run -it ubuntu:20.04 bash
```

And voilà, you’re now in Ubuntu! If you’ve never used Docker before, this can seem fairly magical. Try running some commands. For example, you can look at the contents of `/etc/os-release` to verify you really are in Ubuntu:

```bash
cat /etc/os-release
```

How did this happen? Well, first, Docker searches your local file system for the `ubuntu:20.04` image. If you don’t have that image downloaded already, Docker downloads it automatically from [Docker Hub](https://hub.docker.com/), which is a _Docker Registry_ that contains shared Docker images. The `ubuntu:20.04` image happens to be a public Docker image — an official one maintained by the Docker team — so you’re able to download it without any authentication. However, it’s also possible to create private Docker images which only certain authenticated users can use.

Once the image is downloaded, Docker runs the image, executing the `bash` command, which starts an interactive Bash prompt, where you can type. Try running the `ls` command to see the list of files.

You might notice that’s not your file system. That’s because Docker images run in containers that are isolated at the userspace level: when you’re in a container, you can only see the file system, memory, networking, etc. in that container. Any data in other containers, or on the underlying host operating system, is not accessible to you. This is one of the things that makes Docker useful for running applications: the image format is self-contained, so Docker images run the same way no matter where you run them, and no matter what else is running there.

To see this in action, write some text to a `test.txt` file as follows:

```bash
echo "Hello, World!" > test.txt
```

Next, exit the container by hitting `Ctrl-D` on Windows and Linux or `Cmd-D` on macOS, and you should be back in your original command prompt on your underlying host OS. If you try to look for the `test.txt` file you just wrote, you’ll see that it doesn’t exist: the container’s file system is totally isolated from your host OS.

Now, try running the same Docker image again:

```bash
docker run -it ubuntu:20.04 bash
```

Notice that this time, since the `ubuntu:20.04` image is already downloaded, the container starts almost instantly. This is another reason Docker is useful for running applications: unlike virtual machines, containers are lightweight, boot up quickly, and incur little CPU or memory overhead.

You may also notice that the second time you fired up the container, the command prompt looked different. That’s because you’re now in a totally new container; any data you wrote in the previous one is no longer accessible to you. Run `ls -al` and you’ll see that the `test.txt` file does not exist. Containers are isolated not only from the host OS, but also from each other.

Hit `Ctrl-D` or `Cmd-D` again to exit the container, and back on your host OS, run the `docker ps -a` command to see output similar to below:
```
CONTAINER ID IMAGE COMMAND CREATED STATUS  
3e0081565a5d ubuntu:20.04 "bash" 5 min ago Exited (0) 5 sec ago  
d96ad3779966 ubuntu:20.04 "bash" 14 min ago Exited (0) 5 min ago
```

This will show you all the containers on your system, including the stopped ones (the ones you exited). You can start a stopped container again by using the `docker start <ID>` command, setting `ID` to an ID from the `CONTAINER ID` column of the `docker ps` output. For example, here is how you can start the first container up again (and attach an interactive prompt to it via the `-ia` flags):

```bash
docker start -ia d96ad3779966
```

You can confirm this is really the first container by outputting the contents of `test.txt`:

```bash
cat test.txt
```

Hit `Ctrl-D` or `Cmd-D` again to exit the container. Note that every time you run `docker run` and exit, you are leaving behind containers, which take up disk space. You may wish to clean them up with the `docker rm <CONTAINER_ID>` command, where `CONTAINER_ID` is the ID of the container from the `docker ps` output. Alternatively, you could include the `--rm` flag in your `docker run` command to have Docker automatically clean up when you exit the container.

# Run a web app using Docker
Let’s now see how a container can be used to run a web app. On your host OS, run a new container as follows:
```bash
docker run training/webapp
```
The [training/webapp image](https://github.com/docker-training/webapp) from Docker Hub contains a simple Python “Hello, World” web app for testing. When you run the image, it fires up the web app, listening on port 5000 by default. However, try to access the web app via `curl` or your web browser, it won’t work:
```bash
curl localhost:5000
```
What’s the problem? Actually, it’s not a problem, but a feature! Docker containers are isolated from the host operating system and other containers, not only at the file system level, but also in terms of networking. So while the container really is listening on port 5000, that is only on a port _inside_ the container, which isn’t accessible on the host OS. If you want to expose a port from the container on the host OS, you have to do it via the `-p` flag.

First, hit `Ctrl-C` to shut down the `training/webapp` container: note it’s `C` this time, not `D`, and its `Ctrl` regardless of OS, as you’re shutting down a process, rather than exiting an interactive prompt. Now re-run the container, but this time with the `-p` flag as follows:

```bash
docker run -p 5000:5000 training/webapp
```
Adding `-p 5000:5000` to the command tells Docker to expose port 5000 inside the container on port 5000 of the host OS. If you test the URL again, you should now be able to see the web app working:
```bash
curl localhost:5000
```

# Create your own Docker Image
So far, you’ve used two images from Docker Hub, `ubuntu:20.04` and `training/webapp`, but what if you wanted to create your own Docker image with your own code in it? For example, imagine that in a folder called `web-server`, you had the following `index.html` file:
```html
<html>
  <body>
    <h1>Hello, World!</h1>
  </body>
</html>
```
One way to create a Docker image for a dirt-simple web server that can serve up `index.html` is to create a file called `Dockerfile` in the `web-server` folder with the following contents:
```
FROM python:3
WORKDIR /usr/src/app
COPY index.html .
CMD ["python", "-m", "http.server", "8000"]
```
A `Dockerfile` is a text file that consists of a series of commands in capital letters that instruct Docker how to build a Docker image. The commands used in the preceding `Dockerfile` do the following:
- `FROM`: This specifies the _base_ _image_. The preceding code uses the [official python image](https://hub.docker.com/_/python) from Docker Hub, which, as you can probably guess, has Python already installed. One convenient thing about Docker is that you can build on top of officially-maintained images that have the dependencies you need already installed.
- `WORKDIR`: This specifies the working directory for any subsequent commands. If the directory doesn’t already exist, Docker will create it.
- `COPY`: This copies files from the host OS into the Docker image. The preceding code copies the `index.html` file into the Docker image
- `CMD`: This specifies the default command to execute in the image when someone does `docker run` (if they don’t override the command). I’m using a Python command from the [big list of HTTP server one-liners](https://gist.github.com/willurd/5720255) to fire up a simple web-server that will serve the `index.html` file on port 8000.

To build a Docker image from your `Dockerfile`, go into the `web-server` folder, and run the `docker build` command:
```bash
docker build -t example-server .
```

The `-t` flag specifies the tag—effectively a name—to use for this image. After the image finishes building, you should be able to see it, along with all other images on your computer, by running the `docker images` command:
```
$ docker images
REPOSITORY        TAG      IMAGE ID       CREATED          SIZE
example-server    latest   6ff8ae0a667b   8 minutes ago    867MB
python            3        008af51dfec3   12 days ago      867MB
ubuntu            20.04    a457a74c9aaa   5 months ago     65.6MB
training/webapp   latest   6fae60ef3446   1 year ago       349MB
```
And now you can run your Docker image using the `docker run` command you used earlier, using the `-p` flag to map port 8000 in the container to port 8000 on your host OS:
```bash
docker run -p 8000:8000 example-server
```
Check `localhost:8000` to see if the server is working:
```
$ curl localhost:8000
<html>
  <body>
    <h1>Hello, World!</h1>
  </body>
</html>
```

# Conclusion
You’ve now seen how to run create and run Docker containers. This all works great for running a small number of containers on your own computer, but when running Docker containers in production, you’ll probably want to use a _container orchestration tool_ to handle scheduling (picking which servers should run a given container workload), auto healing (automatically redeploying containers that failed), auto scaling (scaling the number of containers up and down in response to load), load balancing (distributing traffic across containers), and all the other requirements of running and managing production apps.

The most popular Docker orchestration tool these days is Kubernetes. To learn more about that, head over to [part 2 of this series](https://blog.gruntwork.io/a-crash-course-on-kubernetes-a96c3891ad82), [A crash course on Kubernetes](https://blog.gruntwork.io/a-crash-course-on-kubernetes-a96c3891ad82).

# Hands on Tutorial Notes
## Introduction
- Docker avoids dependency hell as the deependencies are packaged in the container
    - The application will run the same no matter the machine because everything needed is all packaged together
- Containers have been around for decades, but historically, they've been hard to use. Docker came up with the tooling that makes containers easy to use, share, etc.
    - Docker gives you the tooling around containers\
- 2 Types of docker containers
    - Windows containers - must run on windows
    - Linux containers - must run on linux
## Docker Fundamentals
### Running your first container
```bash
docker container run hello-world
```
This connects to the Docker daemon, pulls the hello-world image from the Docker Hub, created a new container from that image that runs the executable that produces output, THe Docker daemon streamed that output to the Docker client which sent the output to the terminal

```bash
docker container run -it alpine sh
```
When you want to run an interactive shell in a docker container, you must use the `-it` flag
- Ctrl-d exits the container
### Finding images
- Go to [hub.docker.com](hub.docker.com) and find a docker image you're familiar with
    - Make sure to look for images with the official label
    - The way to use tags is as follows: `docker container run -it ubuntu:24.10 sh` for example.
### Container management
To see currently running containers
```bash
docker container ls
```
To kill a currently running container from inside the container use `ctrl-d`.

To exit the container without killing it, `ctrl-p ctrl-q` Then to list containers running:
```bash
~ $ docker container ls
CONTAINER ID   IMAGE          COMMAND   CREATED              STATUS              PORTS     NAMES
59ea406974bd   ubuntu:24.10   "sh"      About a minute ago   Up About a minute             silly_fermat

```
To show all containers: `docker container ls -a`
To reattach to this container: 
```bash
docker container attach silly_fermat
```

To remove a docker container:
```bash
docker container rm <CONTAINER ID>
```

To remove a docker image:
```bash
docker image ls # to show images
docker image rm <image name>
```


## Utilizing Docker
## Adopting Docker

# OKSI Docker
- gitlab.oksi.ai:5050/products/omniscience/core/omniscience/onnx -> tags have versions as needed, -> image id is a hash of the exact docker file, if you want to know if you have the same docker image as someone, look at the image id
- Platforms we need to support:
    - amd64, jetson (l4t linux 4 tegra)
- 
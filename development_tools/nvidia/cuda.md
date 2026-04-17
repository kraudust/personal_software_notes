# Setup CUDA
- Follow instructions here [https://docs.nvidia.com/cuda/cuda-installation-guide-linux/#meta-packages](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/#meta-packages) which ultimately takes you to a link that does the following, but make sure to click on the link to install the correct cuda version for your nvidia driver (run `nvidia-smi` to find out)
```bash
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.8.0/local_installers/cuda-repo-ubuntu2204-12-8-local_12.8.0-570.86.10-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2204-12-8-local_12.8.0-570.86.10-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2204-12-8-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-8
```

Then follow the post installation instructions (below is for cuda 12.4), update for your version:
```
echo 'export PATH=/usr/local/cuda-12.4/bin${PATH:+:${PATH}}' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-12.4/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' >> ~/.bashrc
```

# Setup instructions from work
# NVIDIA Drivers

- These drivers are required to utilize your computer's GPU while running the software
- Run the following command inside your terminal and you should receive output resembling the following:

```
$ nvidia-smi
Wed Dec  3 18:20:48 2025       
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 570.195.03             Driver Version: 570.195.03     CUDA Version: 12.8     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA RTX 2000 Ada Gene...    Off |   00000000:01:00.0 Off |                  N/A |
| N/A   41C    P8              4W /   16W |      11MiB /   8188MiB |      0%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+
                                                                                         
+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI              PID   Type   Process name                        GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
|    0   N/A  N/A            5865      G   /usr/lib/xorg/Xorg                        4MiB |
+-----------------------------------------------------------------------------------------+
```

- If not, run the following command, which installs and runs the `ubuntu-drivers` package:

```
$ sudo apt-get update && sudo apt-get install ubuntu-drivers-common && sudo ubuntu-drivers install
```

- You will most likely need to restart your machine for the changes to be applied. After restarting, run the `nvidia-smi` command again to check for the correct output.

# CUDA Toolkit

- This is a software development package used for developing, compiling, and optimizing CUDA applications
- For the latest version of CUDA Toolkit: [https://developer.nvidia.com/cuda-downloads](https://developer.nvidia.com/cuda-downloads)
    - Using the most recent version should be backwards compatible and therefore work when develop/running the software. If not, use an older version via the archive: [https://developer.nvidia.com/cuda-toolkit-archive](https://developer.nvidia.com/cuda-toolkit-archive)
- Once on the page, select these options:
    - Operating system: Linux
    - Architecture: x86_64
    - Distribution: Ubuntu
    - Version: whichever you're using (most of us are currently on 22.04)
    - Installer Type: runfile (local)
- From the provided installation instructions, run the `wget` command to download the runfile, e.g.:

```
$ wget https://developer.download.nvidia.com/compute/cuda/13.0.2/local_installers/cuda_13.0.2_580.95.05_linux.run
```

- From there, run these commands to change it to an executable, then run it in a way that only installs the toolkit and not any associated drivers:

```
$ chmod +x cuda_*.run
$ sudo ./cuda_*_.run --silent --toolkit
```

- Add the following lines to your `~/.bashrc` file, while replacing `<VERSION>` with the corresponding CUDA Toolkit version (run `ls /usr/local | grep cuda-` to get an idea of what to write):

```
export PATH=/usr/local/cuda-<VERSION>/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-<VERSION>/lib64:$LD_LIBRARY_PATH
```

- Run `source ~/.bashrc` to source the file, then run the following command, and you should see a similar output with the corresponding version information:

```
$ nvcc --version
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2025 NVIDIA Corporation
Built on Wed_Apr__9_19:24:57_PDT_2025
Cuda compilation tools, release 12.9, V12.9.41
Build cuda_12.9.r12.9/compiler.35813241_0
```
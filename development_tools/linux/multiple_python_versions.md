Use virtual environments to use specific python versions, but first need to install the new python version desired:

# Example with python 3.9.19
Using ubuntu 22.04 which ships with python 3.10, but maybe want to use python3.9 for some code that is reliant on that specific python version.

Install dependencies:
```
sudo apt install tar build-essential checkinstall libreadline-dev \
libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev \
libbz2-dev openssl libffi-dev
```

Download and untar the desired python version:
```sh
mkdir ~/src
mkdir ~/.python3p9
cd ~/src
wget http://www.python.org/ftp/python/3.9.19/Python-3.9.19.tgz
tar -zxvf Python-3.9.19.tgz
cd Python-3.9.19

./configure --prefix=/home/${USER}/.python3p9 --enable-optimizations
make
make install
```

Make a virtualenv with your desired python version:
```
virtualenv .venv_py3p9 -p ~/.python3p9/bin/python3.9
```

Source the environment:
```
source .venv_py3p9/bin/activate
```

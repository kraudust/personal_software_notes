- Github repo: https://github.com/OpenDDS/OpenDDS
- Guide: https://opendds.readthedocs.io/en/latest-release/devguide/index.html

# Installing in docker example
```
# Install OpenDDS
WORKDIR /tmp
RUN git clone --branch v3.32.0 --recurse-submodules \
        https://github.com/OpenDDS/OpenDDS.git OpenDDS-3.32.0
WORKDIR /tmp/OpenDDS-3.32.0
RUN export RAPIDJSON_ROOT="$PWD/tools/rapidjson" && \
    ./configure \
        --prefix=/usr/local \
        --install-origin-relative && \
    . ./setenv.sh && \
    export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${DDS_ROOT}/lib/x64:${ACE_ROOT}/lib/x64" && \
    make -j$(nproc) && \
    make install
```

# Installing on host machine
```
git clone --branch v3.32.0 --recurse-submodules https://github.com/OpenDDS/OpenDDS.git OpenDDS-3.32.0
cd OpenDDS-3.32.0
./configure --prefix=/opt/OpenDDS --install-origin-relative --no-tests
. ./setenv.sh
make -j$(nproc)
sudo make install INSTALL_PREFIX=/opt/OpenDDS
```
- export LD_LIBRARY_PATH=/opt/OpenDDS/lib:$LD_LIBRARY_PATH

# Installing on host machine round 2
- Download the .tar.gz file from here: https://github.com/OpenDDS/OpenDDS/releases
```
tar -xzf OpenDDS-3.32.0.tar.gz
rm OpenDDS-3.32.0.tar.gz
cd OpenDDS-3.32.0/
./configure --prefix=/opt/OpenDDS
. ./setenv.sh
make -j$(nproc)
either:
sudo make install INSTALL_PREFIX=/opt/OpenDDS
or:
sudo checkinstall --pkgname=opendds --pkgversion=3.32.0 --arch=arm64 --pkglicense=OSI --pkggroup=devel --pkgsource=https://github.com/OpenDDS/OpenDDS --maintainer=dustan.kraus1@oksi.ai --requires="libstdc++6, perl, python3" make install INSTALL_PREFIX=/opt/OpenDDS

setting --arch=amd64 for x64 desktop/laptop or --arch=arm64 if for jetson/other arm devices
```
# Making a deb package on the jetson
```bash
sudo checkinstall --pkgname=opendds --pkgversion=3.32.0 --arch=arm64  --pkglicense=OSI --pkggroup=devel --pkgsource=https://github.com/OpenDDS/OpenDDS --maintainer=dustan.kraus1@oksi.ai --requires="libstdc++6, perl, python3" make install INSTALL_PREFIX=/opt/OpenDDS

Can also pass flag --install=no if you do not want it to install

sudo dpkg -i opendds_3.32.0-1_arm64.deb
```
- When prompted, answer as follows:

![](Pasted%20image%2020250611080034.png)




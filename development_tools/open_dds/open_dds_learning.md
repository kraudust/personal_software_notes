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
./configure
make -j$(nproc)
sudo make install INSTALL_PREFIX=/usr/local
```




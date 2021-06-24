# refer ./media-driver/.github/ubuntu.yml

# vaapi has media-driver, libva, gmmlib, 
git clone --recurse-submodules https://github.com/ChipsnMedia/vaapi.git
# git submodule update  # try if there is no all files in submodule.
# if install toolchain base on clang12 job
## echo "clang-12 missed in the image, installing from llvm"
## echo "deb [trusted=yes] http://apt.llvm.org/focal/ llvm-toolchain-focal-12 main" | sudo tee -a /etc/apt/sources.list
## sudo apt-get update
## sudo apt-get install -y --no-install-recommends clang-12

# install toolchain base on gcc-10
## nothing to do?

# install prerequisites
sudo apt-get update
sudo apt-get install -y --no-install-recommends \
          cmake \
          libdrm-dev \
          libegl1-mesa-dev \
          libgl1-mesa-dev \
          libx11-dev \
          libxext-dev \
          libxfixes-dev \
          libwayland-dev \
          make \
          build-essential \
          autoconf \
          automake \
          libtool \
          m4 \
          pkg-config


# print tools versions
cmake --version
#/usr/bin/clang-12 --version
#/usr/bin/clang++-12 --version
/usr/bin/gcc-10 --version
/usr/bin/g++-10 --version


# build libva
cd libva
./autogen.sh --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu
make -j$(nproc)
sudo make install
cd ..

# build gmmlib
cd gmmlib
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=/usr/lib/x86_64-linux-gnu ..
make VERBOSE=1 -j$(nproc)
sudo make install
cd ..
cd ..

# build media-driver
cd media-driver
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=/usr/lib/x86_64-linux-gnu \
    -DCMAKE_C_FLAGS_RELEASE="-O2 -Wformat -Wformat-security -Wall -Werror -D_FORTIFY_SOURCE=2 -fstack-protector-strong" \
    -DCMAKE_CXX_FLAGS_RELEASE="-O2 -Wformat -Wformat-security -Wall -Werror -D_FORTIFY_SOURCE=2 -fstack-protector-strong" \
    ..
make VERBOSE=1 -j$(nproc)
sudo make install
cd ..
cd ..

# build libva-utils
cd libva-utils
./autogen.sh --enable-tests --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu
make -j$(nproc)
sudo make install


sudo apt install vainfo
#build ffmpeg 4.4
cd FFmpeg
./configure --disable-x86asm
make
sudo make install
which ffmpeg
ffmpeg -version
cd ..

# for gstreamer
sudo apt install python3 python3-pip python3-setuptools python3-wheel ninja-build
sudo apt-get install flex bison libz-dev

pip3 install --user meson
export PATH="/home/ta/.local/bin:$PATH"

cd gst-build
git checkout -b 1.19.1
# modify gst-build/meson_options.txt to option('vaapi', type : 'feature', value : 'enabled')
meson builddir 
cd builddir
ninja
ninja devenv # set some env variables to use this build in default
cd ..
cd ..


# for conformance test env.
sudo apt install python3
sudo apt install python3-pip
pip3 install -U pytest
export PATH="$PATH:/home/ta-ubuntu/.local/bin"
pytest --version



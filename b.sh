# refer ./media-driver/.github/ubuntu.yml

# vaapi has media-driver, libva, gmmlib, 
git clone --recurse-submodules https://github.com/ChipsnMedia/vaapi.git
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
sudo apt install ffmpeg
# to install ffmpeg 4.4 ( for av1 vaapi decoder ) if ffmpeg is 4.3 
sudo add-apt-repository ppa:savoury1/ffmpeg4
sudo apt full-upgrade
ffmpeg -version

# for gstreamer
sudo apt-get install libgstreamer1.0-0 gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-doc gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio
sudo apt install gstreamer1.0-vaapi


# for conformance test env.
sudo apt install python3
sudo apt install python3-pip
pip3 install -U pytest
export PATH="$PATH:/home/ta-ubuntu/.local/bin"
pytest --version



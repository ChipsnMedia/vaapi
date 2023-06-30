

# Build and Install libvpuapi library and vpu kernel-mode driver and VPU FW in C&M libvpuapi package(cnm-wave517-libvpuapi_v5.5.72_rSVN_REVISON.tar.gz)
#copy cnm-wave517-libvpuapi_v5.5.72_rSVN_REVISON.tar.gz file from FTP to this folder

#extract C&M libvpuapi package (cnm-wave517-libvpuapi_v5.5.72_rSVN_REVISON.tar.gz
tar -xvzf cnm-wave517-libvpuapi_v5.5.72_r1111.tar.gz

cd wave517_dec_pvric_nommf_mthread_v5.5.72_vaapi/

#build libvauapi package
make -f libvpuapi.mak PRODUCT=WAVE517 clean 
make -f libvpuapi.mak PRODUCT=WAVE517

#install libvpuapi headers and so file and VPU FW to system devenv
#the bellow command will copy libvpuapi header file to /usr/local/include/ and ibvpuapi.so file and VPU fw bin file to  /usr/local/lib/ 
sudo make -f libvpuapi.mak PRODUCT=WAVE517 install 
sudo ldconfig

#build vpu kernel driver
cd vdi/linux/driver
make
#install vpu kernel driver
./load.sh

# vaapi has media-driver, libva, gmmlib, 
sudo apt install git git-lfs &&  git lfs install ## vaapi-fits Git Large File Storage (Git LFS) to track the assets.tbz2 file. Therefore, you will need to install Git LFS before cloning this repository to your local system.
 
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
git checkout master
./autogen.sh --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu
make -j$(nproc)
sudo make install
cd ..

# build gmmlib
cd gmmlib
git checkout master
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=/usr/lib/x86_64-linux-gnu ..
make VERBOSE=1 -j$(nproc)
sudo make install
cd ..
cd ..

# build media-driver
cd media-driver
git checkout master
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=/usr/lib/x86_64-linux-gnu \
    -DCMAKE_C_FLAGS_RELEASE="-O2 -Wformat -Wformat-security -Wall -Werror -D_FORTIFY_SOURCE=2 -fstack-protector-strong" \
    -DCMAKE_CXX_FLAGS_RELEASE="-O2 -Wformat -Wformat-security -Wall -Werror -D_FORTIFY_SOURCE=2 -fstack-protector-strong" \
    ..
make -j$(nproc)
sudo make install
cd ..
cd ..

# build libva-utils
cd libva-utils
git checkout master
./autogen.sh --enable-tests --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu
make -j$(nproc)
sudo make install


sudo apt install vainfo
#build ffmpeg 4.4
cd FFmpeg
git checkout master
./configure --disable-x86asm --extra-cflags=-fno-stack-protector --enable-libdav1d
make
sudo make install # install ffmpeg binary to /usr/local/bin/ffmpeg
which ffmpeg
ffmpeg -version
cd ..

# for gstreamer
sudo apt install python3 python3-pip python3-setuptools python3-wheel ninja-build libaom-dev flex bison libz-dev libpixman-1-dev meson
pip3 install --user meson
export PATH="$HOME/.local/bin:$PATH"

cd gst-build
git checkout master
meson builddir 
ninja -C builddir
#ninja -C builddir devenv # set some env variables to use this build in default
cd ..



#for vaapi-fits
cd vaapi-fits
git checkout master
sudo apt install git-lfs  ## This project uses Git Large File Storage (Git LFS) to track the assets.tbz2 file. Therefore, you will need to install Git LFS before cloning this repository to your local system.
git lfs install 
sudo pip3 install -r requirements.txt
./vaapi-fits list


# for CNM conformance test env.
sudo apt install python3
sudo apt install python3-pip
pip3 install -U pytest
export PATH="$PATH:/home/ta-ubuntu/.local/bin"
pytest --version



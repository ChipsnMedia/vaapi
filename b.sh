
sudo apt-get -qq update
sudo apt-get install -y build-essential
sudo apt-get install -y autoconf
sudo apt-get install -y automake
sudo apt-get install -y libtool
sudo apt-get install -y m4
sudo apt-get install -y lcov
sudo apt-get install -y perl
sudo apt-get install -y pkg-config
sudo apt-get install -y libdrm-dev
sudo apt-get install -y autoconf
sudo apt-get install -y libegl1-mesa-dev
sudo apt-get install -y libgl1-mesa-dev
sudo apt-get install -y libwayland-dev
sudo apt-get install -y libx11-dev
sudo apt-get install -y libxext-dev
sudo apt-get install -y libxfixes-dev
sudo apt-get install -y intel-gpu-tools
sudo apt install git
sudo apt install ffmpeg
sudo apt-get install vainfo

git clone --recursive https://github.com/ChipsnMedia/vpu_vaapi.git
#git clone https://github.com/intel/intel-vaapi-driver
#git clone https://github.com/intel/libva.git
cd libva
./autogen.sh --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu
make -j$(nproc)
sudo make install
cd ..
cd intel-vaapi-driver
#sudo make uninstall
./autogen.sh --enable-tests --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu
make -j$(nproc)
sudo make install
make check


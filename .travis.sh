#!/usr/bin/env bash
export PATH=$PATH:/opt/brcm/hndtools-mipsel-linux/bin:/opt/brcm/hndtools-mipsel-uclibc/bin

echo ========== custom path ============
echo $PATH
   
# echo ========== touch ============
# echo `which touch`
# which touch
# which sleep
# date
# time

# libtool bug fix for libvorbis
export echo=echo



pre_build_prep()
{
cd ~

sudo pip install certifi -U


# https://www.franzoni.eu/python-requests-ssl-and-insecureplatformwarning/
sudo pip install pyOpenSSL ndg-httpsclient pyasn1 -U

sudo pip install  urllib3 -U
sudo pip install requests -U

git clone --depth 1 -b travis https://github.com/oglops/tomato.git
# because I need to revert an old commit, I have to check out the whole history
# git clone -b travis https://github.com/oglops/tomato.git
git clone --depth 1 -b v140 https://github.com/oglops/tomato-gui.git

sudo ln -s ~/tomato/tools/brcm /opt/brcm

rsync -rpv --ignore-times  ./tomato-gui/*  ./tomato/release/src-rt/router/www/  --exclude .git

echo ========== pkg-config --exists uuid ==========
pkg-config pkg-config --exists uuid && echo 1

echo ========== bison ==========
apt-cache showpkg bison

cd ~
wget http://launchpadlibrarian.net/140087283/libbison-dev_2.7.1.dfsg-1_amd64.deb
wget http://launchpadlibrarian.net/140087282/bison_2.7.1.dfsg-1_amd64.deb
sudo dpkg -i libbison-dev_2.7.1.dfsg-1_amd64.deb
sudo dpkg -i bison_2.7.1.dfsg-1_amd64.deb

cd tomato/release/src-rt

# echo ========== pastee ==========
# python $TRAVIS_BUILD_DIR/pastee.py  ./router/mysql/configure.mipsel


# is missing on your system

# cd ~
# wget http://ftp.gnu.org/gnu/automake/automake-1.10.tar.gz
# tar xf automake-1.10.tar.gz
# cd automake-1.10
# sh configure --prefix /usr
# sudo make install

# cd ~
# wget http://ftp.gnu.org/gnu/automake/automake-1.12.tar.gz
# tar xf automake-1.12.tar.gz
# cd automake-1.12
# sh configure --prefix /usr
# sudo make install


# cd ~
# wget http://ftp.gnu.org/gnu/automake/automake-1.8.tar.gz
# tar xf automake-1.8.tar.gz
# cd automake-1.8
# sh configure --prefix /usr
# sudo make install


cd ~
wget http://ftp.gnu.org/gnu/automake/automake-1.11.tar.gz
tar xf automake-1.11.tar.gz
cd automake-1.11
sh configure --prefix /usr
make
sudo make install



cd ~
wget http://ftp.gnu.org/gnu/automake/automake-1.15.tar.gz
tar xf automake-1.15.tar.gz
cd automake-1.15
sh configure --prefix /usr
make
sudo make install


cd ~
wget http://ftp.gnu.org/gnu/automake/automake-1.13.4.tar.gz
tar xf automake-1.13.4.tar.gz
cd automake-1.13.4
sh configure --prefix /usr
make
sudo make install



# mysql warns for this
cd ~
wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.63.tar.gz 
tar xf autoconf-2.63.tar.gz
cd autoconf-2.63
sh configure --prefix /usr
make
sudo  make install

# cd ~
# wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.68.tar.gz 
# tar xf autoconf-2.68.tar.gz
# cd autoconf-2.68
# sh configure --prefix /usr
# sudo  make install



cd ~
wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz 
tar xf autoconf-2.69.tar.gz
cd autoconf-2.69
sh configure --prefix /usr
make
sudo  make install



# cd ~
# wget http://gnu.mirror.globo.tech/libtool/libtool-2.4.2.tar.gz
# tar xvf libtool-2.4.2.tar.gz
# cd libtool-2.4.2
# sh configure --prefix=/usr
# sudo  make install


cd ~
wget http://gnu.mirror.globo.tech/libtool/libtool-2.4.6.tar.gz
tar xvf libtool-2.4.6.tar.gz
cd libtool-2.4.6
sh configure --prefix=/usr
make
sudo  make install

# sudo apt-get purge libncurses5 libncurses5-dev libncursesw5 libncursesw5-dev

# ncurse 6

# dirty hack to disable ncursesw
sudo rm -rf /usr/include/ncursesw

# cd ~
# wget https://ftp.gnu.org/gnu/ncurses/ncurses-6.0.tar.gz
# tar xvf ncurses-6.0.tar.gz
# cd ncurses-6.0
# ./configure --prefix=/usr --enable-widec --enable-pc-files
# make
# sudo  make install

# try same version in local travis

echo =========== autotools versions ===========
dpkg -l | grep "autogen\|autoconf\|automake\|libtool"


echo =========== ncursesw versions ===========
dpkg -l | grep curse
ls -lt /usr/include/ncur*
head -200 /usr/include/ncursesw/curses.h
echo =========== ncurses versions ===========
head -200 /usr/include/ncurses.h


# official image verions
# =========== autotools versions ===========
# ii  autoconf                           2.69-6                                     all          automatic configure script builder
# ii  autogen                            1:5.18-2ubuntu2                            amd64        automated text file generator
# ii  automake                           1:1.14.1-2ubuntu1                          all          Tool for generating GNU Standards-compliant Makefiles
# ii  libltdl-dev:amd64                  2.4.2-1.7ubuntu1                           amd64        A system independent dlopen wrapper for GNU libtool
# ii  libltdl7:amd64                     2.4.2-1.7ubuntu1                           amd64        A system independent dlopen wrapper for GNU libtool
# ii  libopts25:amd64                    1:5.18-2ubuntu2                            amd64        automated option processing library based on autogen
# ii  libopts25-dev                      1:5.18-2ubuntu2                            amd64        automated option processing library based on autogen
# ii  libtool                            2.4.2-1.7ubuntu1                           amd64        Generic library support script


# local version
# i  autoconf                            2.68-1ubuntu2                                       automatic configure script builder
# ii  autogen                             1:5.12-0.1ubuntu1                                   automated text file generator
# ii  automake                            1:1.11.3-1ubuntu2                                   Tool for generating GNU Standards-compliant Makefiles
# ii  libltdl-dev                         2.4.2-1ubuntu1                                      A system independent dlopen wrapper for GNU libtool
# ii  libltdl7                            2.4.2-1ubuntu1                                      A system independent dlopen wrapper for GNU libtool
# ii  libopts25                           1:5.12-0.1ubuntu1                                   automated option processing library based on autogen
# ii  libopts25-dev                       1:5.12-0.1ubuntu1                                   automated option processing library based on autogen
# ii  libtool                             2.4.2-1ubuntu1                                      Generic library support script

cd ~
wget https://downloads.sourceforge.net/project/libuuid/libuuid-1.0.3.tar.gz
tar xf libuuid-1.0.3.tar.gz
cd libuuid-1.0.3
# sh configure --prefix /usr
# CC=mipsel-uclibc-gcc CXX=mipsel-uclibc-g++ AR=mipsel-uclibc-ar RANLIB=mipsel-uclibc-ranlib ./configure --host=mipsel-uclibc-linux --prefix=$HOME/uuid-install

CC=mipsel-uclibc-gcc CXX=mipsel-uclibc-g++ AR=mipsel-uclibc-ar RANLIB=/opt/brcm/hndtools-mipsel-uclibc/bin/mipsel-uclibc-ranlib ./configure --host=mipsel-uclibc-linux --prefix=$HOME/uuid-install
make
sudo  make install

echo ========== pkg-config --exists uuid again ==========
pkg-config --exists uuid && echo 1

# echo /usr/share/aclocal | sudo tee --append /usr/local/share/aclocal/dirlist

# echo =========== dirlist ===========

# cat /usr/local/share/aclocal/dirlist

echo =========== usr/local/share/aclocal ===========
ls /usr/local/share/aclocal/

echo =========== /usr/share/aclocal ===========
ls /usr/share/aclocal

# sudo ln -sT /usr/share/aclocal  /usr/local/share/aclocal-

}

build_tomato()
{
    echo ================= BROADCOM_SDK =====================
    echo $BROADCOM_SDK
    # which cp


    # cd ~/tomato/release/src-rt

    # echo ======before=========
    # pwd
    # ls -l router/mysql

    # cp -f router/mysql/configure.mipsel router/mysql/configure 

    # echo ======after=========
    # ls -l router/mysql




    # https://bugs.archlinux.org/task/10012

    # cd router/libvorbis
    # libtoolize --force --copy
    # aclocal
    # autoconf
    # automake
    # ./autogen.sh 

    

#     make distclean ; rm ~/advancedTomato.txt;  time make V1=RT-N5x-CN- V2=-140 r2z  2>&1 | tee ~/advancedTomato.txt
#     make distclean
#     rm ~/advancedTomato.txt;  

    # time make V1=RT-N5x-CN- V2=-140 r2z  > ~/advancedTomato.txt

    # apply patch in https://github.com/tomatofirmware/tomato/commit/ce39fb4b4a348773355fc2779505db4c5b28d750
    if [ "$TT_BUILD" == "rtn53" ] || [ "$TT_BUILD" == "n60" ] || [ "$TT_BUILD" == "n6" ] || [ "$TT_BUILD" == "e2500" ] || [ "$TT_BUILD" == "e3200" ] || [ "$TT_BUILD" == "wndr64" ]; then
        cd ~/tomato/release/$BROADCOM_SDK/linux
        patch -R -p4 < fix4usbap.patch
    fi


    # cd ~/tomato
    # if [ "$TT_BUILD" == "wndr64" ] ; then
    #     git show 46f7c5f0da4204eb61ff5108c7dd7a835df39576 | git apply -R
    # fi
   
    cd ~/tomato/release/$BROADCOM_SDK

    # make V1=RT-N5x-CN- V2=-140 r2z &
    if [ "$TT_BUILD" == "r2q3m" ] || [ "$TT_BUILD" == "r2q3v" ] ; then
        make V1=RT-N5x-CN- V2=-140-q3  $TT_BUILD > /dev/null &
    elif [ "$TT_BUILD" == "hg32064k" ] || [ "$TT_BUILD" == "hg32032k" ]; then
        make V1=RT-N5x-CN- V2=-140-hg320  $TT_BUILD > /dev/null &
    else
        make V1=RT-N5x-CN- V2=-140 $TT_BUILD > /dev/null  &
    fi
    
    local build_pid=$!

    # Start a runner task to print a "still running" line every 5 minutes
    # to avoid travis to think that the build is stuck
    {
        while true
        do
            sleep 300
            printf "Crosstool-NG is still running ...\r"
        done
    } &
    local runner_pid=$!

    # Wait for the build to finish and get the result
    wait $build_pid 2>/dev/null 
    local result=$?

    # Stop the runner task
    kill $runner_pid
    wait $runner_pid 2>/dev/null

    echo ====== result =========
   # ls -l ~/tomato/release/image
   # ls -l ~/tomato/release/src-rt
   
    ls -l ~/tomato/release/$BROADCOM_SDK/image

    # Return the result
    # return $result
    return 0
    



# echo ========== pastee ==========
# python $TRAVIS_BUILD_DIR/pastee.py  -d config.log ./router/libvorbis/config.log
# python $TRAVIS_BUILD_DIR/pastee.py  -d Makefile ./router/libvorbis/Makefile
# python $TRAVIS_BUILD_DIR/pastee.py  -d configure ./router/libvorbis/configure


#     echo ======after make=========
#     ls -l router/mysql
#     echo ======after make=========
#     ls -l 

#     echo ======config.log=========
#     echo `pwd`
#     pwd
#     cat ./router/mysql/config.log

#     echo ======configure.mipsel=========
#     cat ./router/mysql/configure.mipsel

    # echo ======configure=========
    # cat ./router/mysql/configure

    # echo ======config.log=========
    # cat ./config.log    
}

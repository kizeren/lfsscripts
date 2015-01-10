#!/bin/sh
#Setup some stuff.
pkgname=openssl
_ver=1.0.0d
# use a pacman compatible version scheme
pkgver=${_ver/[a-z]/.${_ver//[0-9.]/}}
pkgrel=1
pkgdesc='The Open Source toolkit for Secure Sockets Layer and Transport Layer Security'
url="https://www.openssl.org"
license=('GPL3')
depends=('glibc' 'sh')
source=(ftp://www.openssl.org/source/${pkgname}-${_ver}.tar.gz)
md5sums=('40b6ea380cc8a5bf9734c2f8bf7e701e')

md5check="$md5sums  $pkgname-${_ver}.tar.gz"


taropt="-zxf"

#Get ready the source.
echo -e "\e[01;33mCreating build directory.\e[00m"
mkdir $pkgname-${_ver}-build
cd $pkgname-${_ver}-build
echo -e "\e[01;33mGetting source package.\e[00m"
wget $source


#Check md5 fail if not correct.
    if !  echo "$md5check" | md5sum -c - >/dev/null ; then
      echo -e "\e[00;31mThe checksums do not match.\e[00m"
        exit 1;
    fi
#Check md5 if success
    if  echo "$md5check" | md5sum -c - >/dev/null ; then
      echo -e "\e[01;33mThe checksums do match.\e[00m"
    fi



echo -e "\e[01;33mUnpackign the source package.\e[00m"
tar $taropt $pkgname-${_ver}.tar.gz
cd $pkgname-${_ver}

#Don't forget the patches!

#Configure options for the build.

./config --prefix=/usr --openssldir=/etc/ssl --libdir=lib \
		shared zlib enable-md2 -Wa,--noexecstack



#Make
echo -e "\e[01;33mRunning Make.\e[00m"
echo -e "\e[01;33mThis may take some time.\e[00m"
make --quiet

#Extras before install

#Remove package before install.
echo -e "\e[01;33mRemoving old package.\e[00m"
paco -B openssl
#This requires sudo to install.  
echo -e "\e[01;33mInstalling $pkgname-${_ver}.\e[00m"
paco -lD "make INSTALL_PREFIX=$pkgdir MANDIR=/usr/share/man install"

#Extras after install


#rm the build directory.
cd ../../
rm -R $pkgname-${_ver}-build

echo -e "\e[01;33mDone installing $pkgname-${_ver}.\e[00m"

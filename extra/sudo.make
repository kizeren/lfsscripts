#!/bin/sh
#Setup some stuff.


pkgname=sudo
_ver=1.7.4p4
pkgver=${_ver/[a-z]/.${_ver//[0-9.]/}}
pkgrel=1
pkgdesc="Give certain users the ability to run some commands as root"
url="http://www.sudo.ws/sudo/"
license=('custom')
depends=('glibc pam')
source=(ftp://ftp.sudo.ws/pub/sudo/$pkgname-$_ver.tar.gz)


taropt="-xf"

#Get ready the source.
echo -e "\e[01;33mCreating build directory.\e[00m"
mkdir $pkgname-$_ver-build
cd $pkgname-$_ver-build
echo -e "\e[01;33mGetting source package.\e[00m"
wget -q $source
echo -e "\e[01;33mUnpackign the source package.\e[00m"
tar $taropt $pkgname-$_ver.tar.gz
cd $pkgname-$_ver

#Configure options for the build.
echo -e "\e[01;33mRunning configure.\e[00m"
./configure --prefix=/usr --libexecdir=/usr/lib \
    --with-ignore-dot --with-all-insults \
    --enable-shell-sets-home --disable-root-sudo \
    --with-logfac=auth --without-pam --without-sendmail --quiet
#Make
echo -e "\e[01;33mRunning Make.\e[00m"
echo -e "\e[01;33mThis may take some time.\e[00m"
make --quiet

#Extras before install

#Remove package before install.
echo -e "\e[01;33mRemoving old package.\e[00m"
paco -B sudo
#This requires sudo to install.
echo -e "\e[01;33mInstalling $pkgname-$pkgver.\e[00m"
paco -lD make install

#Extras after install


#rm the build directory.
cd ../../
rm -R $pkgname-$_ver-build

echo -e "\e[01;33mDone installing $pkgname-$_ver.\e[00m"

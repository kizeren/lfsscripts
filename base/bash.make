#!/bin/sh
#Setup some stuff.
pkgname=bash
pkgver=4.3
pkgrel=1
pkgdesc="The GNU Bourne Again shell"
arch=('i686' 'x86_64')
license=('GPL')
url="http://www.gnu.org/software/bash/bash.html"
groups=('base')
backup=(etc/profile.bash etc/skel/.bashrc etc/skel/.bash_profile)
depends=('readline>=6.1' 'glibc')
provides=('sh')
source=(http://ftp.gnu.org/gnu/bash/bash-4.1.tar.gz)
patchfile1=(http://www.linuxfromscratch.org/patches/lfs/6.7/bash-4.1-fixes-2.patch)
taropt="-xvf"

echo -e "\e[0;32 Building $pkgname-$pkgver.\e[00m"



#Get ready the source.
mkdir $pkgname-$pkgver-build
cd $pkgname-$pkgver-build
wget $source
wget $patchfile1
tar $taropt $pkgname-$pkgver.tar.gz
cd $pkgname-$pkgver

#Don't forget the patches!
patch -Np1 -i ../bash-4.1-fixes-2.patch

#Configure options for the build.
./configure --prefix=/usr --bindir=/bin \
    --htmldir=/usr/share/doc/bash-4.1 --without-bash-malloc \
    --with-installed-readline
#Make
make

#Extras before install

#Remove package before install.

#This requires sudo to install.  
paco -lD make install

#Extras after install


#rm the build directory.
cd ../../
rm -R $pkgname-$pkgver-build
rm $pkgname-$pkgver.tar.gz

echo All done!

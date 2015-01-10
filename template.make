Severly needs updating!

#!/bin/sh
#
#Hopefully in time these scripts will be come useful to some.
#The idea was taken from ARCH linux PKGBUILD system.
#They just run all the nessicary stuff all the end user has to do
#is sit back and watch it work.  There however is no error checking
#or a way to stop the tests or script if they fail.
#
#USE AT YOUR OWN RISK!!!!
#Feel free to contribute more scripts geared towards LFS.
#





#Setup some stuff.



pkgname=NAME OF THE PACKAGE TO BE INSTALLED
pkgver=VERSION OF PACKAGE TO BE INSTALLED
pkgdesc="DESCRIPTION OF PACKAGE TO BE INSTALLED NEEDS QUOTES"
license=(IF PACKAGE CONTAINS A LICENSE PLACE IT HERE.  ie: 'GPL' MUST HAVE TICK MARKS)
url="SOFTWARE WEBSITE ADDRESS"
groups=(WHAT PART OF OS/LFS THIS SOFTWARE BELONGS TOO ie: 'base' MUST HAVE TICK MARKS)
depends=(WHAT DEPENDENCIES ARE NEEDED FIRST ie: 'readline>=6.1' 'glibc' MUST HAVE TICK MARKS)
provides=(WHAT PROGRAMS ARE INSTALLED WITH THIS PACKAGE ie: 'sh' MUST HAVE TICK MARKS)
source=(LOCATION FOR SOURCE PACKAGE DOWNLOAD ie: ftp://ftp.gnu.org/pub/gnu/${pkgname}/${pkgname}-${pkgver}.tar.gz)
patchfile1=(LOCATION FOR PATCH FILE ie: http://www.linuxfromscratch.org/patches/lfs/6.7/bash-4.1-fixes-2.patch)
taropt="OPTIONS FOR UNPACKING SOURCE ie: -xvf"

#Get ready the source.
#The following will create the build directory, download and unpack source.
mkdir $pkgname-$pkgver-build
cd $pkgname-$pkgver-build
wget $source
wget $patchfile1
tar $taropt $pkgname-$pkgver.tar.gz
cd $pkgname-$pkgver

#Don't forget the patches!
patch -Np1 -i ../bash-4.1-fixes-2.patch

#Configure options for the build.
#Put your configure args here.
./configure --prefix=/usr --bindir=/bin \
    --htmldir=/usr/share/doc/bash-4.1 --without-bash-malloc \
    --with-installed-readline
#Make
#Any make options.
make

#Extras before install

#Remove package before install.
#I use paco to track package on LFS install.
paco -B bash
#This requires sudo to install.
#This will call paco to record installation files for later removal if needed.  
sudo paco -lD make install

#Extras after install


#rm the build directory.
#Time for clean up removes all source and leftovers.
cd ../../
rm -R $pkgname-$pkgver-build

echo All done!
echo Installed $provides.

#!/bin/sh
#Setup some stuff.
pkgname=texinfo
pkgver=4.13
realpkgver=4.13a
pkgdesc="Utilities to work with and produce manuals, ASCII text, and on-line documentation from a single source file"
arch=('i686' 'x86_64')
url="http://www.gnu.org/software/texinfo/"
license=('GPL3')
depends=('ncurses' 'findutils' 'gzip')
source=(ftp://ftp.gnu.org/pub/gnu/${pkgname}/${pkgname}-${pkgver}.tar.gz)

taropt="-xvf"

echo -e "\e[0;32Building $pkgname-$pkgver.\e[00m"


#Get ready the source.
mkdir $pkgname-$pkgver-build
cd $pkgname-$pkgver-build
wget $source
tar $taropt $pkgname-$pkgver.tar.gz
cd $pkgname-$pkgver

#Don't forget the patches!

#Configure options for the build.
./configure --prefix=/usr

#Make
make

#Extras before install

#Remove package before install.
paco -B texinfo
#This requires sudo to install.  
paco -lD make install

#Extras after install


#rm the build directory.
cd ../../
rm -R $pkgname-$pkgver-build

echo All done!

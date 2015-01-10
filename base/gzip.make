#!/bin/sh
#Setup some stuff.
pkgname=gzip
pkgver=1.4
pkgdesc="GNU compression utility"
arch=('i686' 'x86_64')
url="http://www.gnu.org/software/gzip/"
license=('GPL3')
depends=('glibc' 'bash')
makedepends=('patch')
install=gzip.install
source=(ftp://ftp.gnu.org/pub/gnu/gzip/gzip-$pkgver.tar.gz)
taropt="-xvf"

#Get ready the source.
mkdir $pkgname-$pkgver-build
cd $pkgname-$pkgver-build
wget $source
tar $taropt $pkgname-$pkgver.tar.gz
cd $pkgname-$pkgver

#Configure options for the build.
./configure --prefix=/usr --bindir=/bin
#Make
make

#Extras before install

#Remove package before install.
paco -B gzip
#This requires sudo to install.  
paco -lD make install

#Extras after install
mv -v /bin/{gzexe,uncompress,zcmp,zdiff,zegrep} /usr/bin
mv -v /bin/{zfgrep,zforce,zgrep,zless,zmore,znew} /usr/bin


#rm the build directory.
cd ../../
rm -R $pkgname-$pkgver-build
rm $pkgname-$pkgver.tar.gz

echo All done!

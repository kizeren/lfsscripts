#!/bin/sh
#Setup some stuff.
pkgname=net-tools
pkgver=1.60
pkgrel=14
pkgdesc="Configuration tools for Linux networking"
arch=(i686 x86_64)
license=('GPL')
url="http://www.tazenda.demon.co.uk/phil/net-tools"
depends=('glibc')
backup=('etc/conf.d/nisdomainname')
source=(http://www.tazenda.demon.co.uk/phil/$pkgname/$pkgname-$pkgver.tar.bz2)
patchfile1=(http://www.linuxfromscratch.org/patches/blfs/6.3/net-tools-1.60-gcc34-3.patch)
patchfile2=(http://www.linuxfromscratch.org/patches/blfs/6.3/net-tools-1.60-kernel_headers-2.patch)
patchfile3=(http://www.linuxfromscratch.org/patches/blfs/6.3/net-tools-1.60-mii_ioctl-1.patch)
taropt="-xvf"

#Get ready the source.
mkdir $pkgname-$pkgver-build
cd $pkgname-$pkgver-build
wget $source
wget $patchfile1
wget $patchfile2
wget $patchfile3
tar $taropt $pkgname-$pkgver.tar.bz2
cd $pkgname-$pkgver

#Don't forget the patches!
patch -Np1 -i ../net-tools-1.60-gcc34-3.patch 
patch -Np1 -i ../net-tools-1.60-kernel_headers-2.patch 
patch -Np1 -i ../net-tools-1.60-mii_ioctl-1.patch 

#Configure options for the build.
yes "" | make config 
sed -i -e 's|HAVE_IP_TOOLS 0|HAVE_IP_TOOLS 1|g' \
       -e 's|HAVE_MII 0|HAVE_MII 1|g' config.h 
sed -i -e 's|# HAVE_IP_TOOLS=0|HAVE_IP_TOOLS=1|g' \
       -e 's|# HAVE_MII=0|HAVE_MII=1|g' config.make 

#Make
make

#Extras before install

#Remove package before install.

#This requires sudo to install.  
#Need to test PACO installation with this.
make update

#Extras after install


#rm the build directory.
cd ../../
rm -R $pkgname-$pkgver-build

echo All done!

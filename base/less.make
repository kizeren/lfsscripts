#!/bin/sh
#Setup some stuff.
pkgname=less
pkgver=436
pkgrel=2
pkgdesc="A terminal based program for viewing text files"
license=('GPL3')
arch=('i686' 'x86_64')
url="http://www.greenwoodsoftware.com/less"
groups=('base')
depends=('ncurses' 'pcre')
source=(http://www.greenwoodsoftware.com/$pkgname/$pkgname-$pkgver.tar.gz)
md5sums="817bf051953ad2dea825a1cdf460caa4"
md5check="$md5sums  $pkgname-$pkgver.tar.gz"
taropt="-zxf"

echo -e "\e[0;32mBuilding $pkgname-$pkgver.\e[00m"

#Get ready the source.
echo -e "\e[00;31mCreating build directory.\e[00m"
mkdir $pkgname-$pkgver-build
cd $pkgname-$pkgver-build
echo -e "\e[00;31mGetting source package.\e[00m"
wget $source
echo "$md5check" > md5sum.check

#Check md5 fail if not correct.
    if !  echo "$md5check" | md5sum -c - >/dev/null ; then
      echo -e "\e[00;31mThe checksums do not match.\e[00m"
	exit 1;
    fi
#Check md5 if success
    if  echo "$md5check" | md5sum -c - >/dev/null ; then
      echo -e "\e[01;33mThe checksums do match.\e[00m"
    fi


echo -e "\e[00;31mUnpackign the source package.\e[00m"
tar $taropt $pkgname-$pkgver.tar.gz
cd $pkgname-$pkgver


#Start the build.
echo -e "\e[00;31mRunning configure.\e[00m"
./configure --prefix=/usr --sysconfdir=/etc --quiet
echo -e "\e[00;31mRunning Make.\e[00m"
echo -e "\e[00;31mThis may take some time.\e[00m"

make --quiet

#This requires sudo to install.  
paco -lD make install

#rm the build directory.
rm -R ../../$pkgname-$pkgver-build

echo All done!

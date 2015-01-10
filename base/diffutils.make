#!/bin/sh
#Setup some stuff.
pkgname=diffutils
pkgver=3.0
pkgdesc="Utility programs used for creating patch files"
arch=('i686' 'x86_64')
url="http://www.gnu.org/software/diffutils"
license=('GPL3')
depends=('glibc' 'sh')
source=(ftp://ftp.gnu.org/gnu/$pkgname/$pkgname-$pkgver.tar.gz)
md5sums=('684aaba1baab743a2a90e52162ff07da')

md5check="$md5sums  $pkgname-$pkgver.tar.gz"


taropt="-zxf"

#Get ready the source.
echo -e "\e[01;33mCreating build directory.\e[00m"
mkdir $pkgname-$pkgver-build
cd $pkgname-$pkgver-build
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
tar $taropt $pkgname-$pkgver.tar.gz
cd $pkgname-$pkgver

#Don't forget the patches!

#Configure options for the build.
echo -e "\e[01;33mRunning configure.\e[00m"
./configure --prefix=/usr --quiet
#Make
echo -e "\e[01;33mRunning Make.\e[00m"
echo -e "\e[01;33mThis may take some time.\e[00m"
make --quiet

#Extras before install

#Remove package before install.
echo -e "\e[01;33mRemoving old package.\e[00m"
paco -B diffutils
#This requires sudo to install.  
echo -e "\e[01;33mInstalling $pkgname-$pkgver.\e[00m"
paco -lD make install

#Extras after install


#rm the build directory.
cd ../../
rm -R $pkgname-$pkgver-build

echo -e "\e[01;33mDone installing $pkgname-$pkgver.\e[00m"


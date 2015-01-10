#!/bin/sh
#Setup some stuff.
pkgname=wget
pkgver=1.12
pkgrel=2
pkgdesc="A network utility to retrieve files from the Web"
url="http://www.gnu.org/software/wget/wget.html"
license=('GPL3')
depends=('glibc openssl')
source=(ftp://ftp.gnu.org/gnu/$pkgname/$pkgname-$pkgver.tar.gz)
taropt="-xf"

read -p "The following dependencies are needed before installing. If they are already install 
press enter.  If not control+x to stop and install $depends first."

#Get ready the source.
echo -e "\e[01;33mCreating build directory.\e[00m"
mkdir $pkgname-$pkgver-build
cd $pkgname-$pkgver-build
echo -e "\e[01;33mGetting source package.\e[00m"
wget -q $source
echo -e "\e[01;33mUnpackign the source package.\e[00m"
tar $taropt $pkgname-$pkgver.tar.gz
cd $pkgname-$pkgver

#Configure the build.
echo -e "\e[01;33mRunning configure.\e[00m"
./configure --prefix=/usr --sysconfdir=/etc --quiet

#Make
echo -e "\e[01;33mRunning Make.\e[00m"
echo -e "\e[01;33mThis may take some time.\e[00m"
make --quiet

#Extras

#Wget have to remove old version first!!
#Should only be done after new version is made.  What do we do with out wget? :)
echo -e "\e[01;33mRemoving old package.\e[00m"
paco -B wget


#This requires sudo to install. 
echo -e "\e[01;33mInstalling $pkgname-$pkgver.\e[00m"
paco -lD make install

#rm the build directory.
cd ../../
rm -R $pkgname-$pkgver-build
rm $pkgname-$pkgver.tar.gz

echo -e "\e[01;33mDone installing $pkgname-$pkgver.\e[00m"

pacoball -g $pkgname -d $PACOBALL/core

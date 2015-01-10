#!/bin/sh
#Setup some stuff.


pkgname=pcre
pkgver=8.10
pkgrel=2
pkgdesc="A library that implements Perl 5-style regular expressions"
url="http://www.pcre.org/"
license=('BSD')
depends=('gcc-libs')
options=('!libtool')
source=(http://downloads.sourceforge.net/pcre/${pkgname}-${pkgver}.tar.bz2)
patchfile1=(http://www.linuxfromscratch.org/patches/blfs/6.3/pcre-7.6-abi_breakage-1.patch)
patchfile2=(http://www.linuxfromscratch.org/patches/blfs/6.3/pcre-7.6-security_fix-1.patch)
md5sums=('780867a700e9d4e4b9cb47aa5453e4b2')
sha1sums=('8b345da0f835b2caabff071b0b5bab40564652be')



md5check="$md5sums  $pkgname-$pkgver.tar.bz2"
taropt="-jxf"

#Get ready the source.
echo -e "\e[01;33mCreating build directory.\e[00m"
mkdir $pkgname-$pkgver-build
cd $pkgname-$pkgver-build
echo -e "\e[01;33mGetting source package.\e[00m"
wget -q $source
echo -e "\e[01;33mGetting patchfiles.\e[00m"
wget -q $patchfile1
wget -q $patchfile2
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


echo -e "\e[01;33mUnpacking the source package.\e[00m"
tar $taropt $pkgname-$pkgver.tar.bz2
cd $pkgname-$pkgver
echo -e "\e[01;33mPatching.\e[00m"
#patch -Np1 -i ../pcre-7.6-abi_breakage-1.patch 
#patch -Np1 -i ../pcre-7.6-security_fix-1.patch 

#Start the build.
echo -e "\e[01;33mRunning configure.\e[00m"
./configure --prefix=/usr --enable-utf8 --enable-unicode-properties  --quiet 
echo -e "\e[01;33mRunning Make.\e[00m"
echo -e "\e[01;33mThis may take some time.\e[00m"

make -j2 --quiet

#Remove package beforing installing new version.
echo -e "\e[01;33mRemoving old package.\e[00m"
paco -B pcre

#This requires sudo to install.  
echo -e "\e[01;33mInstalling $pkgname-$pkgver.\e[00m"
paco -lD "make install"
paco -lD+ "install -dm755 /lib &&  mv /usr/lib/libpcre.so.* /lib/ &&  ln -sf ../../lib/libpcre.so.0 /usr/lib/libpcre.so"
paco -lD+  "install -Dm644 LICENCE /usr/share/licenses/${pkgname}/LICENSE"



#rm the build directory.
rm -R ../../$pkgname-$pkgver-build

echo -e "\e[01;33mDone installing $pkgname-$pkgver.\e[00m"
echo -e "\e[01;35mInstalled Programs: pcregrep, pcretest, and pcre-config\e[00m"
echo -e "\e[01;35mInstalled Libraries: libpcre.{so,a}, libpcrecpp.{so,a} and libpcreposix.{so,a}\e[00m" 

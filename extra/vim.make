#!/bin/sh
#Setup some stuff.
pkgname=vim
pkgver=7.3
pkgdesc="A terminal based program for viewing text files"
license=('GPL3')
url="http://www.vim.org"
source=(ftp://ftp.vim.org/pub/vim/unix/$pkgname-$pkgver.tar.bz2)
md5sums="5b9510a17074e2b37d8bb38ae09edbf2"
md5check="$md5sums  $pkgname-$pkgver.tar.bz2"
taropt="-jxf"

#Get ready the source.
echo -e "\e[01;31mCreating build directory.\e[00m"
mkdir $pkgname-$pkgver-build
cd $pkgname-$pkgver-build
echo -e "\e[01;31mGetting source package.\e[00m"
wget -q $source
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


echo -e "\e[01;31mUnpackign the source package.\e[00m"
tar $taropt $pkgname-$pkgver.tar.bz2
cd vim73

#Change default directory of vimrc.
echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h


#Start the build.
echo -e "\e[01;31mRunning configure.\e[00m"
./configure --prefix=/usr --enable-multibyte --quiet
echo -e "\e[01;31mRunning Make.\e[00m"
echo -e "\e[01;31mThis may take some time.\e[00m"

make --quiet

#This requires sudo to install.  
paco -lD make install

#Symlink vi to vim.

paco -lD+ "ln -sv vim /usr/bin/vi
for L in  /usr/share/man/{,*/}man1/vim.1; do
    ln -sv vim.1 $(dirname $L)/vi.1
done"

#Symlink docs.
paco -lD+ "ln -sv ../vim/vim73/doc /usr/share/doc/vim-7.3"

#rm the build directory.
rm -R ../../$pkgname-$pkgver-build

echo All done!
echo Installed $pkgname-$pkgver.

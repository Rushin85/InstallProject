#!/bin/sh

# Check if the user is ROOT
if [ $(id -u) -ne 0 ]
then
    echo "You are not ROOT! Please login as ROOT."
    exit
fi

# Latest Available Kernel version
LatestKernel="3.18.3-031803-generic"

# Required Packages
Headers_All="http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.18.3-vivid/linux-headers-3.18.3-031803_3.18.3-031803.201501161810_all.deb"
Headers_i386="http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.18.3-vivid/linux-headers-3.18.3-031803-generic_3.18.3-031803.201501161810_i386.deb"
Image_i386="http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.18.3-vivid/linux-image-3.18.3-031803-generic_3.18.3-031803.201501161810_i386.deb"
Headers_amd64="http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.18.3-vivid/linux-headers-3.18.3-031803-generic_3.18.3-031803.201501161810_amd64.deb"
Image_amd64="http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.18.3-vivid/linux-image-3.18.3-031803-generic_3.18.3-031803.201501161810_amd64.deb"

# Debian Packages
DEB="linux-headers-3.18.3*.deb linux-image-3.18.3*.deb"

# Currently Installed Kernel Version
CurrentKernel_release=$(uname -r)

# System Architecture
SystemArch=$(uname -i)

# Check if System already has latest kernel installed
if [ "$CurrentKernel" = "$LatestKernel" ]
then
    echo "Wow! Your System is Already Updated to Latest Available Kernel Version!"
    echo "Program will now exit..."
    sleep 2s
    exit
fi

# If latest kernel is not available, then check the system architecture and download necessary packages

# For 32-bit Systems

if [ $SystemArch = "i386" ] || [ $SystemArch = "i686" ]
then

    echo "Kernel upgrade process for 32-bit systems will now start..."
    sleep 2s
    echo "Downloading required packages.."
    sleep 2s

    wget $Headers_All
    wget $Headers_i386
    wget $Image_i386

    echo "Download process completed. Packages are present in $(pwd) directory"
    sleep 2s

    echo "Installing the packages..."
    dpkg -i $DEB

# For 64-bit Systems
elif [ $SystemArch = "x86_64" ]
then
    echo "Kernel upgrade process for 64-bit systems will now start..."
    sleep 2s

    wget $Headers_All
    wget $Headers_amd64
    wget $Image_amd64

    echo "Download process completed. Packages are present in $(pwd) directory"
    sleep 2s

    echo "Installing the packages..."
    dpkg -i $DEB

# If system architecture is not compatible
else
    echo "Packages for following system architecture not found :  $SystemArch"
    echo "Program will now exit..."
    sleep 2s
exit
fi

    echo "Your system has been successfully upgraded to latest kernel version $(LatestKernel)."
    echo "System will now reboot."
    sleep 5s
    shutdown -r now
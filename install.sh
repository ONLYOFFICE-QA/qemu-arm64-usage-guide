#!/usr/bin/env bash

SYSTEM_NAME='ubuntu20.04'

IMAGE_URL='http://ports.ubuntu.com/ubuntu-ports/dists/focal-updates/main/installer-arm64/20101020ubuntu614.3/legacy-images/netboot/mini.iso'
INSTALL_IMAGE='mini.iso'
if [ -f "$INSTALL_IMAGE" ]; then
    echo "$INSTALL_IMAGE already exists. Skipping download"
else 
    echo "$FILE does not exist. Downloading it"
    wget $IMAGE_URL
fi

sudo apt-get install qemu-system-arm
sudo apt-get install qemu-efi-aarch64
sudo apt-get install qemu-utils

dd if=/dev/zero of=flash1.img bs=1M count=64
dd if=/dev/zero of=flash0.img bs=1M count=64
dd if=/usr/share/qemu-efi-aarch64/QEMU_EFI.fd of=flash0.img conv=notrunc
qemu-img create $SYSTEM_NAME-image.img 20G

qemu-system-aarch64 \
    -nographic -machine virt,gic-version=max \
    -m 512M \
    -cpu max \
    -smp 4 \
    -netdev user,id=vnet,hostfwd=:127.0.0.1:0-:22 \
    -device virtio-net-pci,netdev=vnet \
    -drive file=ubuntu-image.img,if=none,id=drive0,cache=writeback \
    -device virtio-blk,drive=drive0,bootindex=0 \
    -drive file=$INSTALL_IMAGE,if=none,id=drive1,cache=writeback \
    -device virtio-blk,drive=drive1,bootindex=1 \
    -drive file=flash0.img,format=raw,if=pflash \
    -drive file=flash1.img,format=raw,if=pflash 

#!/usr/bin/env bash

SYSTEM_NAME='ubuntu20.04'

qemu-system-aarch64 \
    -nographic \
    -machine virt,gic-version=max \
    -m 2G \
    -cpu max \
    -smp 4 \
    -netdev user,id=vnet,hostfwd=:127.0.0.1:0-:22 \
    -device virtio-net-pci,netdev=vnet \
    -drive file=$SYSTEM_NAME-image.img,if=none,id=drive0,cache=writeback \
    -device virtio-blk,drive=drive0,bootindex=0 \
    -drive file=flash0.img,format=raw,if=pflash \
    -drive file=flash1.img,format=raw,if=pflash 

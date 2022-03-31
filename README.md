# QEMU arm64 usage guide

This is project for easy start of local usage of ARM64 based system via QEMU.
Based on [this](https://futurewei-cloud.github.io/ARM-Datacenter/qemu/how-to-launch-aarch64-vm/)
article

## Hot to use

1. Install your system on local img file, like `ubuntu20.04-image.img`
2. Run your system

### Installation

1. Open `install.sh`
2. Edit `SYSTEM_NAME` - this should be name of image
3. Edit `IMAGE_URL` - this is url for system to download
4. Edit `INSTALL_IMAGE` - this is image name from URL

Or you can leave all values by default to use ubuntu20.04

After that - run `install.sh` and terminal Ubuntu (or other)
install steps will be shown  
It's a rather slow process, may took 3 hour for full installation  
After process completed you will be asked to login -
you can login and run `sudo shutdown 0` to finish installation  

### Run you system

1. Open `run.sh` and make sure that `SYSTEM_NAME`
   is the same as on Installation step
2. `bash run.sh` - after 1-3 minute of boot process
   there will be login prompt. Login and use as always.

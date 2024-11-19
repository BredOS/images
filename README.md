
[![Latest GitHub Release](https://img.shields.io/github/release/BredOS/images.svg?label=Latest%20Release)](https://github.com/BredOS/images/releases/latest)
[![Total GitHub Downloads](https://img.shields.io/github/downloads/BredOS/images/total.svg?&color=E95420&label=Total%20Downloads)](https://github.com/BredOS/images/releases)

# BredOS Image build files.

These are the officially supported images.</br>
For the downstream / experimental images, check the [downstream](https://github.com/BredOS/images/tree/downstream) branch.</br>

## Modifying the images to add new device
To define hardware onto the kernel (like for example to add a temperature sensor) the kernel on ARM systems needs to be explicitly told about the hardware using the kernel device tree.

Currently, there are 2 ways to alter the device tree of a system:
 - Using the device tree overlay (DTO) method.
 - Recompiling the kernel

The DTO method is highly recommended since it is much more flexible and does not require recompiling the kernel, which is very time consuming.

### Device Tree Overlay (DTO) method
Depending on if your device is UEFI or U-Boot enabled, the steps to enable the DTO will be different.

Below are detailed instructions and examples for the DTO method:
 - https://wiki.bredos.org/en/how-to/how-to-setup-panthor
 - https://wiki.indiedroid.us/Nova/device-tree-overlay


### Recompiling the kernel
The kernel recompilation method is the traditional way to perform changes at the device tree.

Steps:
1. Build the kernel with makepkg:
    - Fork [sbc-pkgbuilds](https://github.com/BredOS/sbc-pkgbuilds/tree/main) and change into the directory that holds the kernel
    - Run `makepkg -sr` to pull the kernel source code from the [BredOS kernel repository](https://github.com/BredOS/linux-rockchip), which is saved in `linux-rockchip-rkr3/src/linux-rockchip`.
    - Make the necessary changes in `linux-rockchip-rkr3/src/linux-rockchip`.
    - Note that your changes won't get saved if you remove the directory.
    - After making the changes, run `makepkg -srf` to make the kernel package in arch format.

2. Now you have the kernel package. Copy the kernel package to the temp repo /tmp/repo and update the repo database
```
mkdir /tmp/repo
cp *.pkg.tar.zst /tmp/repo
cd /tmp/repo
repo-add test-repo.db.tar.gz /tmp/repo/*pkg.tar.zst
```

3. Add the temp repo to the pacman.conf file under the specific board-cfg folder. For example, for orangepi 5, go to https://github.com/BredOS/images/tree/main/opi5-image and
then to <board-cfg>/pacman.conf.aarch64 where <board-cfg> is opi5-image:
```ini
[test-repo]
SigLevel = Never
Server = file:///tmp/repo
```

4. Then just build the image using [mkimage](https://github.com/BredOS/mkimage).

## Building specific images
Instructions for building in each subfolder.</br>
Build dependencies:
```
python-prettytable arch-install-scripts grub parted gptfdisk edk2-rk3588-devel
```
</br>
› To build from x86_64, you need to install:

```
qemu-user-static-binfmt qemu-user-static
```

and run:
```
systemctl restart systemd-binfmt
```

</br>
Also make sure your system has the BredOS gpg keys and mirrorlist.

```
sudo pacman-key --recv-keys 77193F152BDBE6A6 BF0740F967BA439D DAEAD1E6D799C638 1BEF1BCEBA58EA33
sudo pacman-key --lsign-key 77193F152BDBE6A6 BF0740F967BA439D DAEAD1E6D799C638 1BEF1BCEBA58EA33
echo -e '# --> BredOS Mirrorlist <-- #\n\n# BredOS Main mirror\nServer = https://repo.bredos.org/repo/$repo/$arch\n' |sudo tee /etc/pacman.d/bredos-mirrorlist
```


[![Latest GitHub Release](https://img.shields.io/github/release/BredOS/images.svg?label=Latest%20Release)](https://github.com/BredOS/images/releases/latest)
[![Total GitHub Downloads](https://img.shields.io/github/downloads/BredOS/images/total.svg?&color=E95420&label=Total%20Downloads)](https://github.com/BredOS/images/releases)

# BredOS Image build files.

These are the officially supported images.</br>
For the downstream / experimental images, check the [downstream](https://github.com/BredOS/images/tree/downstream) branch.</br>

## Building
Instructions for building are in each subfolder.

steps:
 - Clone the repository.
 - get the mkimage.py script at [https://github.com/BredOS/mkimage](https://github.com/BredOS/mkimage)

Then, for specific hardware:

For example, to build the opi5-image:
```
mkimage.py -w ./work/ -o ./out/ -c ./opi5-image/
```

For the fydetabduo-image:
```
mkimage.py -w ./work/ -o ./out/ -c ./fydetabduo-image
```

## the mkimage.py script

To create an image for your chosen SBC, run the mkimage.py script with the appropriate arguments. The basic usage is:

```bash
./mkimage.py -w /tmp/work -o ./output -c <board-cfg>
```

Where:
- `-w`: the working directory to use
- `-o`: the output directory for the resulting image
- `-c`: the board configuration file to use
    
## **WARNING:** If your system has less than 16 GB of RAM, it is recommended to use a different directory for the working directory, as using `/tmp/work` can cause performance issues due to the limited space in the `/tmp` directory.

For example, to create an image for the Rock 5 board, using the lxqt-rock5b-image configuration, with a working directory of /tmp/work and an output directory of ./output, you would run:

```bash
./mkimage.py -w /tmp/work -o ./output -c ./lxqt-rock5b-image
```

## Board Configuration Files

Board configuration files are for a specific SBC. These files are located, for example, in the opi5-image or fydetabduo-image directories.

A different SBC need a new configuration file. You can use an existing configuration file as a starting point.

Below is the structure in each board configuration directory:
- alarmimg/: the directory containing the basic system files for the image
- fixperms.sh: a shell script for fixing file permissions on the system files
- idbloader.img and u-boot.itb: files needed for U-Boot on Rock 5 boards
- packages.aarch64: a list of packages to be installed on the image
- pacman.conf.aarch64: the configuration file used to create the image itself
- profiledef: a file containing basic information about the image, such as the version number, device, architecture, file system type, image name, image type, backend, and cmdline

Some boards like the Rock 4C+ have more files, containing patches, or extra firmware.

## Usage and details
Instructions for building in each subfolder.</br>
Build dependencies:
```
python-prettytable arch-install-scripts grub parted
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
sudo pacman-key --recv-keys 77193F152BDBE6A6 BF0740F967BA439D DAEAD1E6D799C638
sudo pacman-key --lsign-key 77193F152BDBE6A6 BF0740F967BA439D DAEAD1E6D799C638
echo -e '# --> BredOS Mirrorlist <-- #\n\n# BredOS Main mirror\nServer = https://repo.bredos.org/repo/$repo/$arch\n' |sudo tee /etc/pacman.d/bredos-mirrorlist
```

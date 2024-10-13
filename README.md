
[![Latest GitHub Release](https://img.shields.io/github/release/BredOS/images.svg?label=Latest%20Release)](https://github.com/BredOS/images/releases/latest)
[![Total GitHub Downloads](https://img.shields.io/github/downloads/BredOS/images/total.svg?&color=E95420&label=Total%20Downloads)](https://github.com/BredOS/images/releases)

# BredOS Image build files.

These are the officially supported images.</br>
For the downstream / experimental images, check the [downstream](https://github.com/BredOS/images/tree/downstream) branch.</br>

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

# BredOS Image build files.

Instructions for building in each subfolder.</br>›
To build from x86_64, you need to install the following:
```
sudo pacman -S qemu-user-static-binfmt qemu-user-static && systemctl restart systemd-binfmt
```
Also make sure your system has the BredOS gpg keys and mirrorlist.
```
sudo pacman-key --recv-keys 77193F152BDBE6A6 BF0740F967BA439D DAEAD1E6D799C638
sudo pacman-key --lsign-key 77193F152BDBE6A6 BF0740F967BA439D DAEAD1E6D799C638
echo -e "# --> BredOS Mirrorlist <-- #\n\n# BredOS Main mirror\nServer = https://repo.bredos.org/repo/$repo/$arch\n" |sudo tee /etc/pacman.d/bredos-mirrorlist
```

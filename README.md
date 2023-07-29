# BredOS Image build files.

Instructions for building in each subfolder.<br />
<br />
To build from x86_64, <code>pacman -S qemu-user-static-binfmt qemu-user-static && systemctl restart systemd-binfmt</code> as root.<br />
Also make sure your system has the BredOS gpg keys and mirrorlist.<br />
<br />
<code>pacman-key --recv-keys 77193F152BDBE6A6 BF0740F967BA439D DAEAD1E6D799C638 && sudo pacman-key --lsign-key 77193F152BDBE6A6 BF0740F967BA439D DAEAD1E6D799C638</code><br />
<code>echo -e "# --> BredOS Mirrorlist <-- #\n\n# BredOS Main mirror\nServer = https://repo.bredos.org/repo/$repo/$arch\n" > /etc/pacman.d/bredos-mirrorlist</code><br />
<br />

#! /usr/bin/env python
from time import strftime

img_version = strftime("%Y-%m-%d")
edition = "Cinnamon"
arch = "aarch64"  # aarch64, armv7h, riscv64
img_name = "BredOS-ARM-OPI5-" + img_version
install_dir = "arch"
fs = "btrfs"  # ext4 or btrfs
img_type = "image"  # image (img.xz) or rootfs (tar.gz)
img_backend = "loop"  # loop or qemu-nbd
has_uefi = True

# If you use btrfs you need add `rootflags=subvol=@ rootfstype=btrfs`
# And remove `rootfstype=ext4`

cmdline = "console=ttyFIQ0,1500000n8 console=tty1 console=both loglevel=7 rw panic=10 init=/sbin/init rootflags=subvol=@ rootfstype=btrfs"
grubcmdl = "console=ttyFIQ0,1500000n8 console=tty1 console=both rw init=/sbin/init"
grubdtb = "dtbs/rockchip/rk3588s-orangepi-5.dtb"

configtxt = """label BredOS ARM
    kernel /vmlinuz-linux-rockchip-rkr3
    initrd /initramfs-linux-rockchip-rkr3.img
    fdt /dtbs/rockchip/rk3588s-orangepi-5.dtb
"""

partition_table = lambda img_size, fs: {
    "UEFI": ["0%", "8M", "8M", "NONE"],
    "boot": ["9M", "32M", "24M", "fat32"],
    "primary": ["32M", "100%", str(int(img_size / 1000) - 32) + "M", fs],
}

partition_prefix = lambda config_dir, disk: [
    ["dd", "if=/usr/share/edk2/devel/orangepi-5/orangepi-5_UEFI_Release_latest.img", "of=" + disk, "bs=512"],
    ["partprobe", disk],
    ["sgdisk", "-e", disk],
    ["partprobe", disk],
]

partition_suffix = lambda config_dir, disk: [
    ["mkfs.fat", "-v", "-F12", "-n", "BOOT", disk + "p2"],
]

perms = {
    "/etc/": ["0", "0", "755"],
    "/usr/bin/resizefs": ["0", "0", "755"],
    "/usr/bin/zswap-arm-ctrl": ["0", "0", "755"],
    "/usr/bin/pacman-init": ["0", "0", "755"],
    "/usr/bin/oemcleanup": ["0", "0", "755"],
    "/etc/polkit-1/rules.d": ["0", "0", "750"],
    "/etc/sudoers.d": ["0", "0", "750"],
    "/usr/lib": ["0", "0", "755"],
    "/usr/bin": ["0", "0", "755"],
    "/usr": ["0", "0", "755"],
    "/home/bred/.config/autostart/org.bredos.bakery.desktop": ["1001", "1001", "755"],
    "/home/bred/Desktop/org.bredos.bakery.desktop": ["1001", "1001", "755"],
    "/home/bred/": ["1001", "1001", "750"],
    "/home": ["0", "0", "755"],
}

mkcmds = """
copyfiles(config_dir + "/alarmimg", cfg["install_dir"])
fixperms(cfg["install_dir"])
pacstrap_packages(pacman_conf, cfg["packages_file"], cfg["install_dir"])
machine_id()
fixperms(cfg["install_dir"])
copy_skel_to_users()
logging.info("Partitioning rock5b")
rootfs_size = int(
    subprocess.check_output(["du", "-s", "--exclude=proc", cfg["install_dir"]])
    .split()[0]
    .decode("utf-8")
)
img_size, ldev = makeimg(
    rootfs_size, cfg["fs"], cfg["img_name"], cfg["img_backend"]
)
partition(
    ldev, cfg["fs"], img_size, cfg["partition_table"](img_size, cfg["fs"]), has_uefi=cfg["has_uefi"]
)
if not os.path.exists(mnt_dir):
    os.mkdir(mnt_dir)
subprocess.run("mount " + ldev + "p2 " + mnt_dir + "/boot/efi", shell=True)
copyfiles(cfg["install_dir"], mnt_dir, retainperms=True)
create_extlinux_conf(mnt_dir, cfg["configtxt"], cfg["cmdline"], ldev)
create_fstab(cfg["fs"], ldev)
grub_install(mnt_dir)
unmount(cfg["img_backend"], mnt_dir, ldev)
cleanup(cfg["img_backend"])
if args.no_compress:
    copyimage(cfg["img_name"])
else:
    compressimage(cfg["img_name"])
cleanup(cfg["work_dir"])
"""

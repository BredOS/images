# Create a minimal image 
dd if=/dev/zero of=uboot.img bs=1M count=16

# Attach loop device
LOOPDEV=$(losetup --show -fP uboot.img)

sgdisk --clear \
  --set-alignment=2 \
  --new=1:4096:8191 --typecode=1:2E54B353-1271-4842-806F-E436D6AF6985 \
  --new=2:8192:16383 --typecode=2:BC13C2FF-59E6-4262-A352-B275FD6F7172 \
  $LOOPDEV

# Detach
losetup -d $LOOPDEV

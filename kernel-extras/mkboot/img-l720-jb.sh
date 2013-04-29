#!/bin/sh

export	pwd=`readlink -f .`
# echo "making ramdisk"
# ./mkbootfs ramdisk-l720-jb | gzip > ramdisk.gz
cd ramdisk-l720-jb
find .|cpio -o -H newc > ../ramdisk
cd ..
gzip ramdisk

echo "making boot.img"
# packs the ramdisk together with the zImage at the proper locations and makes the boot.img
./mkbootimg --cmdline "console=null androidboot.hardware=qcom user_debug=31" --kernel $pwd/zImage --ramdisk $pwd/ramdisk.gz --base 0x80200000 --ramdisk_offset 0x02000000 -o $pwd/boot.img
rm ramdisk.gz

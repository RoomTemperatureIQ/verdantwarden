#!/bin/sh
# verdantwarden.sh

# https://wiki.archlinux.org/index.php/udev#udev_rule_example
# https://wiki.archlinux.org/index.php/Environment_variables
# udevadm info -a -p $(udevadm info -q path -n /dev/video2)
# udevadm monitor --environment --udev

udev_hotplug_script=/etc/udev/rules.d/83-webcam-removed.rules

# if udev_hotplug_script does not exist then create it
if [ ! -f $udev_hotplug_script ]; then
    # need to revise for plugging in to call script -> insmod silk.ko
    # sudo echo "ACTION=="remove", SUBSYSTEM=="usb", ENV{ID_VENDOR_ID}=="05a9", ENV{ID_MODEL_ID}=="4519", RUN+="/path/to/your/script/verdantwarden.sh install"" > $udev_hotplug_script
    sudo echo "ACTION=="remove", SUBSYSTEM=="usb", ENV{ID_VENDOR_ID}=="05a9", ENV{ID_MODEL_ID}=="4519", RUN+="/path/to/your/script/verdantwarden.sh remove"" > $udev_hotplug_script
fi


# pass called arguments for command
if [ "$1" -eq "install" ]; then
    # USB Detected
    # if inserted, load silk.ko KLM
    sudo insmod silk.ko
elif [ "$1" -eq "remove" ]; then
    # USB Removed - PANIC!
    # if removed:
    # dd LUKS key header
    # echo YES|sudo cryptsetup luksErase /dev/sdX1
    # dd if=/dev/urandom of=/dev/sdX1 bs=512 count=20480
    
    # enable magic commands
    # echo 1 > /proc/sys/kernel/sysrq 

    # sync mounted filesystems, perform twice just in case
    # echo s > /proc/sysrq-trigger
    # echo s > /proc/sysrq-trigger
    # sync
    # sudo rmmod silk.ko

    # shutdown the computer - use 'o' for shutdown, 'b' for reboot
    # echo o > /proc/sysrq-trigger
    # sudo shutdown now
else
    # probably manually called not from udev
    echo It's all gud mane
fi

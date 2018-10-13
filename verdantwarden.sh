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
    # sudo echo "ACTION=="remove", SUBSYSTEM=="usb", ENV{ID_VENDOR_ID}=="05a9", ENV{ID_MODEL_ID}=="4519", RUN+="/path/to/your/script/verdantwarden.sh install"" >> $udev_hotplug_script
    sudo echo "ACTION=="remove", SUBSYSTEM=="usb", ENV{ID_VENDOR_ID}=="05a9", ENV{ID_MODEL_ID}=="4519", RUN+="/path/to/your/script/verdantwarden.sh remove"" >> $udev_hotplug_script
fi

# silk-guardian shred - https://sandeeprhce.blogspot.com/2011/05/critical-system-files-in-linux.html
#    /etc/passwd
#    /etc/shadow
#    /etc/groups
#    /etc/gshadow
#    /etc/login.defs
#    /etc/shells
#    /etc/securetty
#    logs
#    /var/log/auth.log
#    /var/log/boot.log
#    /var/log/dmesg
#    ssh keys
#    certificates
#    VPN secrets
#    gnome-keyring
#    .bash_history
#    systemd logs

# systemd at boot:
#    Fork Bomb - https://www.howtogeek.com/125157/8-deadly-commands-you-should-never-run-on-linux/
#    dd random past /boot sector of disk; only leave the /boot untouched and enough to get to a console screen
#    mv ~ /dev/null


# pass called arguments for command
if [ "$1" -eq "install" ]; then
    # USB Detected
    # if inserted, load silk.ko KLM
    sudo insmod silk.ko
elif [ "$1" -eq "remove" ]; then
    # USB Removed - PANIC!
    # sudo cryptsetup -q luksErase /dev/sdX1
    # dd LUKS key header

    # soft-bricking:
    # make sure to dd an image of the boot record to restore later
    # dd randomizes sector data making the disks boot record indistinguishable from the encrypted data
    # get sizeof boot record + LUKS header
    # align to sector
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

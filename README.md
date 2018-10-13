# verdantwarden  
![Danger: Experimental](https://camo.githubusercontent.com/275bc882f21b154b5537b9c123a171a30de9e6aa/68747470733a2f2f7261772e6769746875622e636f6d2f63727970746f7370686572652f63727970746f7370686572652f6d61737465722f696d616765732f6578706572696d656e74616c2e706e67)

- - - -
Feature | Program | Implemented | Priority | Notes |   
------------- | ------------- | ------------- | ------------- | -------------  
Disk Encryption | dm-crypt + LUKS | [❌] | critical | https://wiki.archlinux.org/index.php/disk_encryption  
Virtual RAM Encryption | dm-crypt + LUKS | [❌] | critical | https://wiki.archlinux.org/index.php/Dm-crypt/Swap_encryption  
Kernel Memory Poisoning |  | [❌] | critical | https://www.kernel.org/doc/html/v4.18/security/self-protection.html#memory-poisoning  https://git-tails.immerda.ch/tails/plain/features/erase_memory.feature   
Anti-Forensic USB Kill Switch | udev (trigger) / modprobe (load silk-guardian KLM) | [❌] | critical | https://github.com/NateBrune/silk-guardian https://wiki.archlinux.org/index.php/udev#udev_rule_example  
BlueTooth Security Fob Device (Lock Session) | blueproximity | [❌] | critical | http://www.daniloaz.com/en/automatically-lock-unlock-your-screen-by-bluetooth-device-proximity/  
System Tampering Video Surveillance Detection | Motion | [❌] | critical | https://github.com/Motion-Project/motion  

- - - -

# USB Armory - hotplug read-only (unclean shutdown), TMPFS cloud sync  
https://gist.github.com/yann2192/f989143c86567237460e  
https://hacksr.blogspot.com/2012/05/ssh-unlock-with-fully-encrypted-ubuntu.html  
https://github.com/inversepath/usbarmory/wiki/Secure-boot  
https://github.com/offensive-security/kali-arm-build-scripts/blob/master/usbarmory.sh  
[✔]  
USB Armory loads up `dropbear` / `tinyssh` -> requires login to unlock `luks` partition  
for uses refer to: https://github.com/inversepath/usbarmory/wiki/Applications  
* VPN  
* Pentest - https://docs.kali.org/kali-on-arm/kali-linux-on-usb-armory  

# Anti-Forensic USB Kill Switch (udev hotplug)  
todo: figure out `udev` rule number priority for hotplug (83 in example)  
in the event that the computer is started up under duress there is the `LUKS` Nuke  
in the event that the computer will be stolen/seized there is `verdantwarden.sh` using `silk-guardian`  
Example - https://wiki.archlinux.org/index.php/udev#udev_rule_example  

udev triggers script:  
    /etc/udev/rules.d/83-webcam-removed.rules  
    `ACTION=="remove", SUBSYSTEM=="usb", ENV{ID_VENDOR_ID}=="05a9", ENV{ID_MODEL_ID}=="4519", RUN+="/path/to/your/script"`  

# verdantwarden.sh
https://www.kali.org/tutorials/emergency-self-destruction-luks-kali/  
https://www.kali.org/tutorials/nuke-kali-linux-luks/  
https://www.offensive-security.com/kali-linux/kali-encrypted-usb-persistence/  
https://www.offensive-security.com/kali-linux/raspberry-pi-luks-disk-encryption/  
https://wiki.archlinux.org/index.php/dm-crypt/Device_encryption#Removing_LUKS_keys  
https://wiki.archlinux.org/index.php/Dm-crypt/Drive_preparation#Wipe_LUKS_header  
https://superuser.com/questions/1168928/wipe-luks-partition-in-pre-boot/1168933#1168933  
https://major.io/2009/01/29/linux-emergency-reboot-or-shutdown-with-magic-commands/  
https://en.wikipedia.org/wiki/Magic_SysRq_key  
we assume script running is triggered from udev call  
what happens when user executed system shutdown is called for the KLM unloading  
what happens when USB hotplug removed; calls what  
* revise silk.ko  
requires `linux-headers` to be installed  

`# USB Detected`  
`# if inserted, load silk.ko KLM`  
`sudo insmod silk.ko`  

`# USB Removed - PANIC!`  
`# if removed: `  
`# dd LUKS key header`  

`# sudo cryptsetup luksErase /dev/sdX1`  
`# dd if=/dev/urandom of=/dev/sdX1 bs=512 count=20480`  
`# sync`  
`# sudo rmmod silk.ko`  
`# sudo shutdown now`  



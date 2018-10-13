# verdantwarden

Feature | Program | Implemented | Priority | Notes |   
------------- | ------------- | ------------- | ------------- | -------------  
Disk Encryption | dm-crypt + LUKS | [❌] | critical | https://wiki.archlinux.org/index.php/disk_encryption  
Virtual RAM Encryption | dm-crypt + LUKS | [❌] | critical | https://wiki.archlinux.org/index.php/Dm-crypt/Swap_encryption  
Anti-Forensic USB Kill Switch | udev (trigger) / modprobe (load silk-guardian KLM) | [❌] | critical | https://github.com/NateBrune/silk-guardian https://wiki.archlinux.org/index.php/udev#udev_rule_example  
BlueTooth Security Fob Device (Lock Session) | blueproximity | [❌] | critical | http://www.daniloaz.com/en/automatically-lock-unlock-your-screen-by-bluetooth-device-proximity/  


# USB Armory - hotplug read-only (unclean shutdown), TMPFS cloud sync
https://gist.github.com/yann2192/f989143c86567237460e  
https://hacksr.blogspot.com/2012/05/ssh-unlock-with-fully-encrypted-ubuntu.html  
https://github.com/inversepath/usbarmory/wiki/Secure-boot  
[✔]  
USB Armory loads up `dropbear` / `tinyssh` -> requires login to unlock `luks` partition
for uses refer to: https://github.com/inversepath/usbarmory/wiki/Applications  
* VPN

# Anti-Forensic USB Kill Switch
Example - https://wiki.archlinux.org/index.php/udev#udev_rule_example

udev triggers script:  
    /etc/udev/rules.d/83-webcam-removed.rules
    ACTION=="remove", SUBSYSTEM=="usb", ENV{ID_VENDOR_ID}=="05a9", ENV{ID_MODEL_ID}=="4519", RUN+="/path/to/your/script"

# verdantwarden.sh
we assume script running is triggered from udev call  
requires `linux-headers` to be installed  

sudo insmod silk.ko  



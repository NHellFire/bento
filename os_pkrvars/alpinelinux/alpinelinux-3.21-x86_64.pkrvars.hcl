os_name                 = "alpinelinux"
os_version              = "3.21"
os_arch                 = "x86_64"
iso_url                 = "https://dl-cdn.alpinelinux.org/v3.21/releases/x86_64/alpine-virt-3.21.4-x86_64.iso"
iso_checksum            = "file:https://dl-cdn.alpinelinux.org/v3.21/releases/x86_64/alpine-virt-3.21.4-x86_64.iso.sha256"
parallels_guest_os_type = "debian"
vbox_guest_os_type      = "Debian_64"
vmware_guest_os_type    = "debian-64"
shutdown_command        = "sudo poweroff"
boot_command            = [
    "<enter><wait10>",
    # Login as root
    "root<enter><wait>",
    "ifconfig eth0 up && udhcpc -i eth0<enter><wait>",
    "wget http://{{ .HTTPIP }}:{{ .HTTPPort }}/alpinelinux/installer.cfg<enter><wait>",
    "export HOSTNAME={{ .Name }}<enter><wait>",
    # Configure environment
    "source installer.cfg<enter><wait>",
    # Unattended install, -e for empty root password
    "setup-alpine -e -f /root/installer.cfg && ",
    "mount /dev/$${DISK}2 /mnt && ",
    # Manually add sudo
    "apk add --root /mnt sudo && ",
    "echo \"vagrant ALL=(ALL:ALL) NOPASSWD:ALL\" > /mnt/etc/sudoers.d/vagrant && chmod 0440 /mnt/etc/sudoers.d/vagrant && ",
    # Set passwords
    "echo vagrant:vagrant | chpasswd -R /mnt && ",
    "echo root:vagrant | chpasswd -R /mnt && ",

    "reboot<enter>"
]

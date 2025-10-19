#!/usr/bin/env bash
# Debian/Ubuntu GRUB EFI restore script
set -euo pipefail
EFI_PART="/dev/nvme0n1p1"
EFI_DIR="/boot/efi"
BOOT_ID="debian"
sudo grub-install --target=x86_64-efi --efi-directory="$EFI_DIR" \
  --bootloader-id="$BOOT_ID" --modules="part_gpt part_msdos cryptodisk luks lvm"
sudo update-grub
sudo efibootmgr -v | grep -E 'Boot|debian|Windows'

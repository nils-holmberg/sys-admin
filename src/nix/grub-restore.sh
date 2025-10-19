#!/usr/bin/env bash
# Restore Debian/Ubuntu GRUB EFI entry after Windows updates or firmware resets.
# Works on UEFI systems with LUKS + LVM (e.g., vgdebian-root).
#
# Usage:
#   sudo ./grub-restore.sh
#
# Notes:
# - Assumes the EFI system partition is already mounted at /boot/efi.
# - Includes cryptodisk/luks/lvm GRUB modules so GRUB can unlock LUKS.

set -euo pipefail

# ---- configuration (edit if needed) ----
EFI_DIR="/boot/efi"
BOOT_ID="debian"
GRUB_MODULES="part_gpt part_msdos cryptodisk luks lvm"
# ----------------------------------------

if [[ $EUID -ne 0 ]]; then
  echo "[grub-restore] Please run as root (use sudo)." >&2
  exit 1
fi

if [[ ! -d "$EFI_DIR/EFI" ]]; then
  echo "[grub-restore] Warning: $EFI_DIR does not look like a mounted EFI partition."
  echo "  Mount it first, e.g.:  sudo mount /dev/nvme0n1p1 /boot/efi"
fi

echo "[grub-restore] Reinstalling GRUB (UEFI)…"
grub-install \
  --target=x86_64-efi \
  --efi-directory="$EFI_DIR" \
  --bootloader-id="$BOOT_ID" \
  --modules="$GRUB_MODULES" \
  --recheck

echo "[grub-restore] Regenerating GRUB configuration…"
update-grub

echo "[grub-restore] Current EFI boot entries:"
efibootmgr -v || true

echo "[grub-restore] Done. Reboot and verify Debian appears first in firmware boot order."

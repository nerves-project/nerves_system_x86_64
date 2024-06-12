#! /bin/sh

# If the value of nerves_fw_active stored in the U-Boot environment does not
# match the value in the Grub environment block, then the bootloader has
# reverted to the previous firmware, and we need to sync these changes to the
# U-Boot environment to ensure fwup knows.

grub_nerves_fw_active=$(awk -F= '/nerves_fw_active/ {print $2}')
uboot_nerves_fw_active="$(fw_printenv -n nerves_fw_active)"

if [ "$grub_nerves_fw_active" != "$uboot_nerves_fw_active" ]; then
    fw_setenv "nerves_fw_active" "$grub_nerves_fw_active"
    fw_setenv "nerves_fw_validated" "1"
fi

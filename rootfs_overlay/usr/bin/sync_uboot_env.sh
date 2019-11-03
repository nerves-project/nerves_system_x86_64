#! /bin/sh

grub_nerves_fw_active=$(awk -F= '/nerves_fw_active/ {print $2}')
uboot_nerves_fw_active="$(fw_printenv -n nerves_fw_active)"

if [ "$grub_nerves_fw_active" != "$uboot_nerves_fw_active" ]; then
    fw_setenv "nerves_fw_active" "$grub_nerves_fw_active"
fi

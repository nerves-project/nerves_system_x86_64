#!/bin/sh

set -e

# Create the Grub environment blocks
grub-editenv $BINARIES_DIR/grubenv_a_valid_0 create
grub-editenv $BINARIES_DIR/grubenv_a_valid_0 set nerves_fw_active=a
grub-editenv $BINARIES_DIR/grubenv_a_valid_0 set nerves_fw_validated=0
grub-editenv $BINARIES_DIR/grubenv_a_valid_0 set nerves_fw_booted=0

grub-editenv $BINARIES_DIR/grubenv_b_valid_0 create
grub-editenv $BINARIES_DIR/grubenv_b_valid_0 set nerves_fw_active=b
grub-editenv $BINARIES_DIR/grubenv_b_valid_0 set nerves_fw_validated=0
grub-editenv $BINARIES_DIR/grubenv_b_valid_0 set nerves_fw_booted=0

cp $BINARIES_DIR/grubenv_a_valid_0 $BINARIES_DIR/grubenv_a_valid_1
grub-editenv $BINARIES_DIR/grubenv_a_valid_1 set nerves_fw_validated=1

cp $BINARIES_DIR/grubenv_b_valid_0 $BINARIES_DIR/grubenv_b_valid_1
grub-editenv $BINARIES_DIR/grubenv_b_valid_1 set nerves_fw_validated=1

# Copy MBR boot code boot.img
cp $TARGET_DIR/lib/grub/i386-pc/boot.img $BINARIES_DIR

# Copy everything that's needed to build firmware images over to the
# output directory so that it can be bundled with the system image.
cp $NERVES_DEFCONFIG_DIR/grub.cfg $BINARIES_DIR

# Remove the Buildroot-generated grub.cfg so avoid confusion.
# We put our grub in the FAT filesystem at the beginning of the
# disk so that it exists across firmware updates.
rm -fr $TARGET_DIR/boot/grub/*

# Create the revert script for manually switching back to the previously
# active firmware.
mkdir -p $TARGET_DIR/usr/share/fwup
NERVES_SYSTEM=$BASE_DIR $HOST_DIR/usr/bin/fwup -c -f $NERVES_DEFCONFIG_DIR/fwup-revert.conf -o $TARGET_DIR/usr/share/fwup/revert.fw

# Create the mark_valid script for manually marking firmware valid
NERVES_SYSTEM=$BASE_DIR $HOST_DIR/usr/bin/fwup -c -f $NERVES_DEFCONFIG_DIR/fwup-mark-valid.conf -o $TARGET_DIR/usr/share/fwup/mark_valid.fw

# Copy the fwup includes to the images dir
cp -rf $NERVES_DEFCONFIG_DIR/fwup_include $BINARIES_DIR

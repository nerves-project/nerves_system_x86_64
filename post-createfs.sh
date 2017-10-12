#!/bin/sh

set -e

FWUP_CONFIG=$NERVES_DEFCONFIG_DIR/fwup.conf

# Create the Grub environment blocks
grub-editenv $BINARIES_DIR/grubenv_a create
grub-editenv $BINARIES_DIR/grubenv_a set boot=0
grub-editenv $BINARIES_DIR/grubenv_a set validated=0
grub-editenv $BINARIES_DIR/grubenv_a set booted_once=0

grub-editenv $BINARIES_DIR/grubenv_b create
grub-editenv $BINARIES_DIR/grubenv_b set boot=1
grub-editenv $BINARIES_DIR/grubenv_b set validated=0
grub-editenv $BINARIES_DIR/grubenv_b set booted_once=0

cp $BINARIES_DIR/grubenv_a $BINARIES_DIR/grubenv_a_valid
grub-editenv $BINARIES_DIR/grubenv_a_valid set booted_once=1
grub-editenv $BINARIES_DIR/grubenv_a_valid set validated=1

cp $BINARIES_DIR/grubenv_b $BINARIES_DIR/grubenv_b_valid
grub-editenv $BINARIES_DIR/grubenv_b_valid set booted_once=1
grub-editenv $BINARIES_DIR/grubenv_b_valid set validated=1

# Copy MBR boot code boot.img
cp $HOST_DIR/usr/lib/grub/i386-pc/boot.img $BINARIES_DIR

# Copy everything that's needed to build firmware images over to the
# output directory so that it can be bundled with the system image.
cp $NERVES_DEFCONFIG_DIR/grub.cfg $BINARIES_DIR

# Run the common post-image processing for nerves
$BR2_EXTERNAL_NERVES_PATH/board/nerves-common/post-createfs.sh $TARGET_DIR $FWUP_CONFIG

#!/bin/sh

set -e

if [ -z $TARGET_DIR ]; then
    echo "Uh oh, TARGET_DIR isn't set. That's weird."
    exit 1
fi

# Remove the Buildroot-generated grub.cfg so avoid confusion.
# We put our grub in the FAT filesystem at the beginning of the
# disk so that it exists across firmware updates.
rm -fr $TARGET_DIR/boot/grub

# Run the common post-build processing for nerves
$BR2_EXTERNAL_NERVES_PATH/board/nerves-common/post-build.sh $TARGET_DIR

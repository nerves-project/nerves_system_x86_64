#!/bin/sh

#
# Run a nerves_system_x86_64-based image in QEMU
#
# Usage:
#   run-qemu.sh [Path to .img file]
#

set -e

IMAGE="$1"
DEFAULT_IMAGE="<%= image_path %>"

help() {
    echo
    echo "Usage:"
    echo "  run-qemu.sh [Path to .img file]"
    exit 1
}
[ -n "$IMAGE" ] || IMAGE="$DEFAULT_IMAGE"

[ -f "$IMAGE" ] || (echo "Error: can't find '$IMAGE'"; help)

echo "Starting QEMU..."
qemu-system-x86_64 \
    -drive file="$IMAGE",format=raw \
    -device e1000,netdev=user.0 \
    -netdev user,id=user.0,hostfwd=tcp::8989-:8989

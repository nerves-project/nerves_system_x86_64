# Generic x86_64 System
[![Build Status](https://travis-ci.org/nerves-project/nerves_system_x86_64.png?branch=master)](https://travis-ci.org/nerves-project/nerves_system_x86_64)

This is the base Nerves System configuration for a generic x86_64 system. 

| Feature              | Description                     |
| -------------------- | ------------------------------- |
| CPU                  | Intel                           |
| Memory               | 512 MB+ DRAM                    |
| Storage              | Hard disk/SSD/etc. (/dev/sda)   |
| Linux kernel         | 4.13                            |
| IEx terminal         | Display - tty0                  |
| Hardware I/O         | None                            |
| Ethernet             | Yes                             |

Please contact me about this if you're really interested in it. I don't
maintain it, and unless you really dig through the code, it's not going
to be obvious how it works. I'm happy to help if you're really interested.

## Installation

Add `nerves_system_x86_64` to your list of dependencies in mix.exs:

```
def deps do
    [{:nerves_system_x86_64, "~> 0.1"}]
end
```

## Root disk naming

If you have multiple SSDs, or other devices connected, it's
possible that Linux will enumerate those devices in a nondeterministic order.
This can be mitigated by using `udev` to populate the `/dev/disks/by-*`
directories, but even this can be inconvenient when you just want to refer to
the drive that provides the root filesystem. To address this, `erlinit` creates
`/dev/rootdisk0`, `/dev/rootdisk1`, etc. and symlinks them to the expected
devices. For example, if your root file system is on `/dev/sdap1`, you'll
get a symlink from `/dev/rootdisk1` to `/dev/sdap1` and similar files for
each partition. The whole disk will be `/dev/rootdisk0`.

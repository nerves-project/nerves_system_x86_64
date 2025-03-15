# Generic x86_64 System

[![Hex version](https://img.shields.io/hexpm/v/nerves_system_x86_64.svg "Hex version")](https://hex.pm/packages/nerves_system_x86_64)
[![CI](https://github.com/nerves-project/nerves_system_x86_64/actions/workflows/ci.yml/badge.svg)](https://github.com/nerves-project/nerves_system_x86_64/actions/workflows/ci.yml)
[![REUSE status](https://api.reuse.software/badge/github.com/nerves-project/nerves_system_x86_64)](https://api.reuse.software/info/github.com/nerves-project/nerves_system_x86_64)

This is the base Nerves System configuration for a generic x86_64 system that
can be run with Qemu. It can be used as a base for real x86_64 systems, but it
probably will require some work.

| Feature              | Description                     |
| -------------------- | ------------------------------- |
| CPU                  | Intel                           |
| Memory               | 512 MB+ DRAM                    |
| Storage              | Hard disk/SSD/etc. (/dev/sda)   |
| Linux kernel         | 6.6                             |
| IEx terminal         | Virtual serial - ttyS0          |
| Hardware I/O         | None                            |
| Ethernet             | Yes                             |

## Using

The most common way of using this Nerves System is create a project with `mix
nerves.new` and to export `MIX_TARGET=x86_64`. See the [Getting started
guide](https://hexdocs.pm/nerves/getting-started.html#creating-a-new-nerves-app)
for more information.

If you need custom modifications to this system for your device, clone this
repository and update as described in [Making custom
systems](https://hexdocs.pm/nerves/systems.html#customizing-your-own-nerves-system)

## Running in qemu

It's possible to run Nerves projects built with this system in Qemu with some
work. If you create a Nerves projects with the `nerves_system_x86_64`
dependency, here are the steps:

Create firmware like normal:

```sh
export MIX_TARGET=x86_64
mix deps.get
mix firmware
```

Create the disk image (virtual MicroSD/SD/eMMC):

```sh
qemu-img create -f raw disk.img 1G
```

Use `fwup` to write the image for the first time:

```sh
# Substitute the .fw file based on your project
fwup -d disk.img _build/x86_64_dev/nerves/images/circuits_quickstart.fw
```

Run qemu:

```sh
qemu-system-x86_64 -drive file=disk.img,if=virtio,format=raw -net nic,model=virtio -net user,hostfwd=tcp::10022-:22 -nographic -serial mon:stdio -m 1024
```

You should eventually get an IEx prompt. The first boot takes longer since the
application data partition will be formatted. Run `poweroff` at the IEx prompt
to exit out of Qemu or if you're having trouble, run `killall
qemu-system-x86_64` in another shell window.

You can ssh into the system by using port 10022. Try `ssh -p 10022 localhost`.
It's possible to run an "over-the-air" firmware update also using ssh by running
the following:

```sh
mix firmware.gen.script # create the upload.sh script
SSH_OPTIONS="-p 10022" ./upload.sh localhost
```

## Root disk naming

If you have multiple SSDs, or other devices connected, it's
possible that Linux will enumerate those devices in a nondeterministic order.
This can be mitigated by using `udev` to populate the `/dev/disks/by-*`
directories, but even this can be inconvenient when you just want to refer to
the drive that provides the root filesystem. To address this, `erlinit` creates
`/dev/rootdisk0`, `/dev/rootdisk0p1`, etc. and symlinks them to the expected
devices. For example, if your root file system is on `/dev/mmcblk0p1`, you'll
get a symlink from `/dev/rootdisk0p1` to `/dev/mmcblk0p1` and the whole disk
will be `/dev/rootdisk0`. Similarly, if the root filesystem is on `/dev/sdb1`,
you'd still get `/dev/rootdisk0p1` and `/dev/rootdisk0` and they'd by symlinked
to `/dev/sdb1` and `/dev/sdb` respectively.

## Provisioning devices

This system supports storing provisioning information in a small key-value store
outside of any filesystem. Provisioning is an optional step and reasonable
defaults are provided if this is missing.

Provisioning information can be queried using the Nerves.Runtime KV store's
[`Nerves.Runtime.KV.get/1`](https://hexdocs.pm/nerves_runtime/Nerves.Runtime.KV.html#get/1)
function.

Keys used by this system are:

Key                    | Example Value     | Description
:--------------------- | :---------------- | :----------
`nerves_serial_number` | `"12345678"`      | By default, this string is used to create unique hostnames and Erlang node names. If unset, it defaults to part of the Ethernet adapter's MAC address.

The normal procedure would be to set these keys once in manufacturing or before
deployment and then leave them alone.

For example, to provision a serial number on a running device, run the following
and reboot:

```elixir
iex> cmd("fw_setenv nerves_serial_number 12345678")
```

This system supports setting the serial number offline. To do this, set the
`NERVES_SERIAL_NUMBER` environment variable when burning the firmware. If you're
programming MicroSD cards using `fwup`, the commandline is:

```sh
sudo NERVES_SERIAL_NUMBER=12345678 fwup path_to_firmware.fw
```

Serial numbers are stored on the MicroSD card so if the MicroSD card is
replaced, the serial number will need to be reprogrammed. The numbers are stored
in a U-boot environment block. This is a special region that is separate from
the application partition so reformatting the application partition will not
lose the serial number or any other data stored in this block.

Additional key value pairs can be provisioned by overriding the default provisioning.conf
file location by setting the environment variable
`NERVES_PROVISIONING=/path/to/provisioning.conf`. The default provisioning.conf
will set the `nerves_serial_number`, if you override the location to this file,
you will be responsible for setting this yourself.

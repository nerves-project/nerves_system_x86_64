# Changelog

## v1.6.2

* Updated dependencies
  * [nerves_system_br v1.6.6](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.6.6)
  * Erlang 21.2.4
  * boardid 1.5.3

## v1.6.1

* Updated dependencies
  * [nerves_system_br v1.6.5](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.6.5)
  * Erlang 21.2.2
  * boardid 1.5.2
  * erlinit 1.4.9
  * OpenSSL 1.1.1a

* Enhancements
  * Moved boardid config from inside erlinit.config to /etc/boardid.config

## v1.6.0

This pulls in a pending patch in Buildroot to update the version of
OpenSSL from 1.0.2 to 1.1.0h. This fixes what appears to be issues with
Erlang using OpenSSL engines. It also enables Erlang crypto algorithms
such as ed25519 that have been added in recent Erlang releases.

* Updated dependencies
  * [nerves_system_br v1.6.1](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.6.1)
  * Erlang 21.2
* Added dependencies
  * wpa_passphrase
  * libp11 0.4.9

## v1.5.1

* Updated dependencies
  * [nerves_system_br v1.5.3](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.5.3)

## v1.5.0

This release updates the Linux kernel from 4.13 to 4.18.9.

* Updated dependencies
  * [nerves_system_br v1.5.2](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.5.2)
  * Linux 4.18.9
  * Erlang 21.0.9

## v1.4.0

This release contains various updates to provisioning variables and data.

**Host requirements**

Building firmware using this system requires `fwup` to be updated on your
host computer to at least `v1.2.5`. The target minimum version requirement
has not changed from `0.15.0`.

**Serial numbers**

Device serial numbers are now set using `NERVES_SERIAL_NUMBER` instead of
`SERIAL_NUMBER`. This is to reduce ambiguity on the source of the serial
by name spacing it along side other Nerves variables. The U-Boot environment
key has also changed from `serial_number` to `nerves_serial_number`. The
erlinit.config has been updated to provide backwards compatibility for setting
the hostname from the serial number by checking for `nerves_serial_number`
and falling back to `serial_number`.

**Custom provisioning**

Provisioning data is applied at the time of calling the `fwup` task `complete`.
The `complete` task is executed when writing the firmware to the target disk.
During this time, `fwup` will include the contents of a provisioning file
located at `${NERVES_SYSTEM}/images/fwup_include/provisioning.conf`. By default,
this file only sets `nerves_serial_number`. You can add additional provisioning
data by overriding the location of this file to include your own by setting
the environment variable `NERVES_PROVISIONING`. If you override this variable
you will be responsible for also setting `nerves_serial_number`.

* Updated dependencies
  * [nerves_system_br v1.4.5](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.4.5)

## v1.3.0

This release upgrades gcc from version 6.3.0 to 7.3.0. See the toolchain release
notes for more information.

* Updated dependencies
  * [nerves_system_br v1.4.1](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.4.1)
  * [nerves_toolchain_x86_64_unknown_linux_musl v1.1.0](https://github.com/nerves-project/toolchains/releases/tag/v1.1.0)

## v1.2.1

* Updated dependencies
  * [nerves_system_br v1.3.2](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.3.2)

## v1.2.0

This release updates Erlang to OTP 21.0

* Enhancements
  * Enable Enable NO_HZ in linux kernel for performance.

* Updated dependencies
  * [nerves_system_br v1.3.0](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.3.0)

## v1.1.1

This release fixes some issues and adds firmware UUID support. This support can
be used to unambiguously know what's running on a device.

* Updated dependencies
  * [nerves_system_br v1.2.2](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.2.0)

* Bug fixes
  * Empty serial numbers stored in the U-Boot environment would be used instead
    of reverting to devices IDs built into the CPU or board.
  * It wasn't possible to enable QtWebEngine (needed for kiosk apps)

## v1.1.0

This release adds official support for provisioning serial numbers to devices.
Other information can be provisioned in a similar manner. See the README.md for
details.

Buildroot was also updated to 2018.05. Be sure to review the `nerves_system_br`
link for the changes in the embedded Linux components.

* Updated dependencies
  * [nerves_system_br v1.2.0](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.2.0)

## v1.0.0

This release is nearly identical to rc.1 except with the deps bump to 1.0 and
documentation/comment updates.

* Updated dependencies
  * [nerves_system_br v1.0.0](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.0.0)
  * [nerves_toolchain v1.0.0](https://github.com/nerves-project/toolchains/releases/tag/v1.0.0)
  * [nerves v1.0.0](https://github.com/nerves-project/nerves/releases/tag/1.0.0)

## v1.0.0-rc.1

This release contains updates to Erlang and heart from `nerves_system_br` and
mostly cosmetic changes to this project. The trivial `.fw` files are no longer
created by CI scripts. If you've forked this project and are building systems
using CI, make sure to update your publish scripts.

* Updated dependencies
  * [nerves_system_br v1.0.0-rc.2](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.0.0-rc.2)

## v1.0.0-rc.0

* Updated dependencies
  * [nerves_system_br v1.0.0-rc.0](https://github.com/nerves-project/nerves_system_br/releases/tag/v1.0.0-rc.0)
  * [nerves_toolchain v1.0.0-rc.0](https://github.com/nerves-project/toolchains/releases/tag/v1.0.0-rc.0)
  * [nerves v1.0.0-rc.0](https://github.com/nerves-project/nerves/releases/tag/1.0.0-rc.0)

## v0.5.0

* Updated dependencies
  * [nerves_system_br v0.17.0](https://github.com/nerves-project/nerves_system_br/releases/tag/v0.17.0)
  * [nerves_toolchain v0.13.0](https://github.com/nerves-project/toolchains/releases/tag/v0.13.0)
  * [nerves v0.9.0](https://github.com/nerves-project/nerves/releases/tag/v0.9.0)

## v0.4.1

* Updated dependencies
  * [nerves_system_br v0.16.4](https://github.com/nerves-project/nerves_system_br/releases/tag/v0.16.4)

* Changes
  * Temporarily disable the system linter since it fails and the fix requires
    some time.

## v0.4.0

* Updated dependencies
  * [nerves_system_br v0.16.1-2017-11](https://github.com/nerves-project/nerves_system_br/releases/tag/v0.16.1-2017-11)

* Enhancements
  * Increased memory in qemu script to 1 GB. 128 MB works, but can cause some apps to
    reboot with out of memory errors.
  * Start running nerves_system_linter to check for configuration errors.
  * Automount the boot partition readonly at `/boot`
  * Support for reverting firmware.

    See [Reverting Firmware](https://hexdocs.pm/nerves_runtime/readme.html#reverting-firmware) for more info on reverting firmware.

    See [fwup-revert.conf](https://github.com/nerves-project/nerves_system_rpi/blob/master/fwup-revert.conf) for more information on how fwup handles reverting.

## v0.3.2

* Updated dependencies
  * [toolchain v0.12.1](https://github.com/nerves-project/toolchains/releases/tag/v0.12.1)

## v0.3.1

* Updated dependencies
  * [nerves_system_br v0.15.1](https://github.com/nerves-project/nerves_system_br/releases/tag/v0.15.1)

## v0.3.0

* Updated dependencies
  * [nerves_system_br v0.15.0](https://github.com/nerves-project/nerves_system_br/releases/tag/v0.15.0)
* Enhancements
  * erlinit added aliased /dev/rootdisk* for referencing the boot disk. See the readme for more info.
  * Updated nerves to 0.8. Move nerves.exs into mix.exs

## v0.2.1

* Updated dependencies
  * [nerves_system_br v0.14.1](https://github.com/nerves-project/nerves_system_br/releases/tag/v0.14.1)

## v0.2.0

* Updated dependencies
  * [nerves_system_br v0.14.0](https://github.com/nerves-project/nerves_system_br/releases/tag/v0.14.0)
    * [Buildroot 2017.08](https://git.busybox.net/buildroot/plain/CHANGES?id=2017.08)
    * [fwup 0.17.0](https://github.com/fhunleth/fwup/releases/tag/v0.17.0)
    * [erlinit 1.2.0](https://github.com/nerves-project/erlinit/releases/tag/v1.2.0)
    * [nbtty 0.3.0](https://github.com/fhunleth/nbtty/releases/tag/v0.3.0)

## v0.1.0

* Initial release

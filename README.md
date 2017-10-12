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

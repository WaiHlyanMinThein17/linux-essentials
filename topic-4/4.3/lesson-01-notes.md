# 📓 Topic 4.3 Lesson 1 — Where Data is Stored

**Course:** LPI Linux Essentials (010-160) · **Date:** May 8, 2026 · **Status:** ✅ Complete

## 🔑 Core Concept: Everything is a File

- In Linux, everything is a file — programs, directories, devices, kernel processes, sockets, partitions
- The Linux directory structure starting from `/` is a collection of files
- This is one of the most powerful features of Linux

## 📂 Where Binary Files (Programs) are Stored

Programs are distributed across a three-tier structure:

| Directory                 | Purpose                                          | Root needed? |
|---------------------------|--------------------------------------------------|--------------|
| `/sbin`                   | Essential system admin binaries (parted, ip)     | Yes          |
| `/bin`                    | Essential binaries for all users (ls, mv, mkdir) | No           |
| `/usr/sbin`               | System admin binaries (deluser, groupadd)        | Yes          |
| `/usr/bin`                | Most user programs (free, sudo, man)             | No           |
| `/usr/local/sbin`         | Locally installed sysadmin programs              | Yes          |
| `/usr/local/bin`          | Locally installed user programs                  | No           |
| `/opt`                    | Optional third-party applications                | —            |
| `~/bin` or `~/.local/bin` | User's own personal programs                     | No           |

- Some modern distros make `/bin` and `/sbin` symlinks to `/usr/bin` and `/usr/sbin`

```bash
which git              # find location of a program → /usr/bin/git
echo $PATH             # see all directories searched for programs
```

## ⚙️ Where Configuration Files are Stored — /etc

- `/etc` = main directory for system-wide configuration files
- Originally "et cetera" — catch-all directory that became the config standard
- Configuration files are usually plain text

| File / Pattern              | Description                                     |
|-----------------------------|-------------------------------------------------|
| `/etc/group`                | System group database                           |
| `/etc/hostname`             | Name of the host computer                       |
| `/etc/hosts`                | IP addresses and hostname translations          |
| `/etc/passwd`               | System user database (7 colon-separated fields) |
| `/etc/profile`              | System-wide Bash configuration                  |
| `/etc/shadow`               | Encrypted user passwords                        |
| `/etc/bash.bashrc`          | System-wide .bashrc for interactive shells      |
| `/etc/resolv.conf`          | DNS resolver configuration                      |
| `/etc/sysctl.conf`          | Kernel variables configuration                  |
| `/etc/logrotate.d/`         | Modular config directory (*.d pattern)          |
| `/etc/apt/sources.list.d/`  | Modular apt sources (Debian/Ubuntu)             |

- **\*.d directories** = modular config — packages add files without touching main config

## 🏠 User Configuration Files — Dotfiles (~)

| File               | Purpose                                        |
|--------------------|------------------------------------------------|
| `~/.bash_history`  | Command line history                           |
| `~/.bash_logout`   | Commands run when leaving login shell          |
| `~/.bashrc`        | Bash init script for non-login shells          |
| `~/.profile`       | Bash init script for login shells              |
| `~/.gitconfig`     | User Git configuration                         |
| `~/.ssh/`          | SSH keys and configuration                     |

- Dotfiles = hidden files starting with `.` in home directory
- User-level config — doesn't affect other users

## 📁 /etc vs ~ — Which files go where?

| File          | /etc (system-wide) | ~ (user-specific)  |
|---------------|--------------------|---------------------|
| bash.bashrc   | ✅                 |                    |
| .bashrc       |                    | ✅                 |
| passwd        | ✅                 |                    |
| .profile      |                     | ✅                |
| resolv.conf   | ✅                 |                    |
| sysctl.conf   | ✅                 |                    |

## 🐧 The Linux Kernel — /boot

- Kernel must load into protected memory before any process can run
- First process: PID 1 = `systemd` (modern) or `/sbin/init` (older)
- Multiple kernels kept in /boot as fallback

| File                            | Purpose                                               |
|---------------------------------|-------------------------------------------------------|
| `vmlinuz-4.15.0-50-generic`     | The kernel — compressed (z=compressed, vm=virtual mem)|
| `initrd.img-4.15.0-50-generic`  | Initial RAM disk — temporary root fs for startup      |
| `config-4.15.0-50-generic`      | Kernel build configuration                            |
| `System.map-4.15.0-50-generic`  | Memory address locations for kernel symbols           |
| `grub/`                         | GRUB2 bootloader configuration directory              |

## 🔢 Kernel Version Number Meaning

Example: `vmlinuz-4.15.0-50-generic`

| Number | Meaning        |
|--------|----------------|
| 4      | Kernel version |
| 15     | Major revision |
| 0      | Minor revision |
| 50     | Patch number   |

## 🔬 The /proc Virtual Filesystem

- Not stored on disk — loaded in memory at boot, dynamically updated
- Reflects current state of the system in real time

| File                                  | Contains                                      |
|---------------------------------------|-----------------------------------------------|
| `/proc/cpuinfo`                       | Detailed CPU information                      |
| `/proc/cmdline`                       | Parameters passed to kernel at boot           |
| `/proc/modules`                       | List of loaded kernel modules                 |
| `/proc/meminfo`                       | Detailed memory usage information             |
| `/proc/sys/`                          | Kernel configuration settings (0=off, 1=on)   |
| `/proc/sys/net/ipv4/ip_forward`       | Enable/disable packet forwarding              |
| `/proc/sys/kernel/pid_max`            | Maximum PID number allowed (default 32768)    |

## 🔌 The /dev Directory

| Device type       | First char in ls -l | Examples                          |
|-------------------|---------------------|-----------------------------------|
| Block devices     | `b`                 | /dev/sda, /dev/sda1, USB, DVDs    |
| Character devices | `c`                 | /dev/tty, /dev/console, serial    |

| Special file     | Purpose                                  |
|------------------|------------------------------------------|
| `/dev/zero`      | Provides unlimited null characters       |
| `/dev/null`      | Bit bucket — discards everything         |
| `/dev/urandom`   | Generates pseudo-random numbers          |

| Device prefix   | Interface          | Example              |
|-----------------|--------------------|----------------------|
| `/dev/sd*`      | SCSI/SATA drives   | /dev/sda, /dev/sdb   |
| `/dev/hd*`      | Old IDE drives     | /dev/hda, /dev/hdb   |
| `/dev/nvme*`    | Modern NVMe drives | /dev/nvme0           |
| `/dev/mmcblk*`  | SD cards           | /dev/mmcblk0         |
| `/dev/tty*`     | Terminals          | /dev/tty0, /dev/ttyS0|

## 🗂️ The /sys Directory

- sysfs mounted on /sys — introduced with kernel 2.6
- Stores hardware device information in organized categories

```bash
cat /sys/class/net/enp0s3/address   # get network card MAC address
```

## 🧠 Memory Types

| Type           | Description                                          |
|----------------|------------------------------------------------------|
| Physical (RAM) | Fast, volatile — lost on shutdown                    |
| Swap           | Slow, persistent — disk space used when RAM is full  |
| Virtual memory | Abstraction of total addressable memory (RAM + swap) |

```bash
free -h      # human readable memory usage
free -m      # in mebibytes
free -g      # in gibibytes
```

| free column | Meaning                      | /proc/meminfo field            |
|-------------|------------------------------|--------------------------------|
| total       | Total RAM/swap installed     | MemTotal / SwapTotal           |
| used        | Currently in use             | —                              |
| free        | Currently unused             | MemFree / SwapFree             |
| shared      | Used by tmpfs                | Shmem                          |
| buff/cache  | Kernel buffers + page cache  | Buffers + Cached + SReclaimable|
| available   | Can be used by new processes | MemAvailable                   |

## 🔑 Key Takeaways

- In Linux, everything is a file — hardware, processes, kernel settings
- Programs live in /bin, /sbin, /usr/bin, /usr/sbin, /usr/local/bin
- /sbin and /usr/sbin require root; /bin and /usr/bin do not
- System-wide config in /etc — user-specific config in ~ (dotfiles)
- Kernel files in /boot — vmlinuz = compressed kernel
- Kernel version format: version.major.minor-patch (e.g. 4.15.0-50)
- /proc = virtual filesystem — dynamically reflects system state
- /dev = device files — b=block device, c=character device
- /sys = organized hardware device information
- Swap = disk space used when RAM is full
- NVMe drives = /dev/nvme*, IDE drives = /dev/hd*, SD cards = /dev/mmcblk*

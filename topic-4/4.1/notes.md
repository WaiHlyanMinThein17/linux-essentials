# 📓 Topic 4.1 — Choosing an Operating System

**Course:** LPI Linux Essentials (010-160) · **Date:** May 8, 2026 · **Status:** ✅ Complete

## 🖥️ What is an Operating System?

- The OS lies at the heart of the computer — allows applications to run
- Contains **drivers** to access hardware (disks, screens, keyboards, network cards)
- Main OS categories: Linux, Unix, macOS, Windows

```bash
uname -r    # check Linux kernel version (e.g. 4.15.0-1019-aws)
uname -s    # check OS name (Darwin on macOS)
```

## 🐧 Linux Kernel vs Linux Distribution

| Concept            | Description                                                                                       |
|--------------------|---------------------------------------------------------------------------------------------------|
| Linux Kernel       | The core OS — common to ALL distributions. Maintained by Linus Torvalds and The Linux Foundation. |
| Linux Distribution | Kernel + applications + shell + desktop environment + package manager                             |

- First kernel release under GPLv2 was version 0.12 in 1992
- All distributions run Linux but may use different kernel versions
- Distributions differ in: target audience, support lifecycle, software, desktop

## 📊 Types of Linux Distributions

| Type               | Target             | Characteristics                                  | Examples                               |
|--------------------|--------------------|--------------------------------------------------|----------------------------------------|
| Enterprise Grade   | Large organizations| Older stable kernel, long support, reliable      | RHEL, CentOS, SUSE, Debian, Ubuntu LTS |
| Consumer Grade     | Home/small business| Latest kernel, newest drivers, shorter support   | Fedora, Ubuntu non-LTS, openSUSE       |
| Experimental/Hacker| Advanced users     | Bleeding edge, rolling release, may break        | Arch Linux, Gentoo                     |

## 🏢 Enterprise Grade Linux

- Older kernel versions — stability over features
- Long support lifecycles — RHEL = 10 years
- Security patches backported to stable versions
- May lack support for newest consumer hardware
- **RHEL 8** launched May 2019 — supported until May 2029

## 🏠 Consumer Grade Linux

- Latest kernel — newest drivers for latest hardware
- Shorter support lifecycle (typically 3 releases)
- Ubuntu non-LTS: updates stop ~9 months after release
- Important for gaming on Linux — needs latest GPU drivers

## ⏱️ Ubuntu Support Lifecycle

| Edition       | Support   | Target                |
|---------------|-----------|-----------------------|
| Ubuntu non-LTS| ~9 months | Home/hobbyist users   |
| Ubuntu LTS    | 5 years   | Enterprise/server use |

- Ubuntu version numbers = YY.MM format (e.g. 24.04 = April 2024)
- LTS versions released every 2 years
- Commercial support available from Canonical

## 🔬 Experimental Linux

- Arch Linux, Gentoo — most recent software even if buggy
- Rolling release model — continuous updates, no fixed versions
- For advanced users who can fix broken systems

## 🔗 Distribution Relationships

| Distribution | Based on  | Relationship                          |
|--------------|-----------|---------------------------------------|
| Ubuntu       | Debian    | Uses same DPKG packaging system       |
| Fedora       | Red Hat   | Testbed for future RHEL features      |
| CentOS       | RHEL      | Free rebuild of RHEL source code      |
| openSUSE     | SUSE      | Community version of SUSE Enterprise  |

## 🍎 Non-Linux Operating Systems

| OS                          | Basis         | Key facts                                         |
|-----------------------------|---------------|---------------------------------------------------|
| Unix (AIX, HP-UX)           | Original Unix | Commercial, declining. Solaris disappeared.       |
| FreeBSD, NetBSD, OpenBSD    | BSD Unix      | Free, open source Unix derivatives                |
| macOS (Darwin)              | BSD Unix      | Apple OS since 2001, uname -s returns "Darwin"    |
| Windows Desktop             | Windows NT    | Dominates desktop market, proprietary             |
| Windows Server              | Windows NT    | GUI or command-line only option                   |

## ☁️ Linux Use Cases

| Context    | Notes                                                              |
|------------|--------------------------------------------------------------------|
| Desktop    | Growing — GNOME and KDE most common desktop environments           |
| Server     | Dominant in enterprise — managed by Linux engineers                |
| Cloud      | Linux runs 90% of public cloud — AWS, GCP, Azure all use Linux     |
| Containers | Docker and Kubernetes containers almost always run Linux           |

## 🔑 Key Takeaways

- OS = kernel + drivers + applications — enables hardware access and runs software
- Linux kernel = common component of ALL distributions — maintained by Linus Torvalds
- Distribution = kernel + shell + apps + desktop environment
- Enterprise Linux = stable, long support (RHEL = 10 years)
- Consumer Linux = latest kernel, short support, newest hardware
- Ubuntu LTS = 5 years support, good enterprise option
- Ubuntu version format = YY.MM (e.g. 24.04)
- macOS is based on BSD Unix — uname -s returns Darwin
- Drivers are the OS component that allow access to hardware
- Fedora is a testbed for RHEL; Ubuntu is based on Debian
- Use `uname -r` to check kernel version, `uname -s` for OS name

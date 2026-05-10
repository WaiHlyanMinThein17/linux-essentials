# 📓 Topic 4.2 — Understanding Computer Hardware

**Course:** LPI Linux Essentials (010-160) · **Date:** May 8, 2026 · **Status:** ✅ Complete

## ⚡ Power Supplies

- Normalize electricity from wall outlets to voltages computers need
- Desktop PSUs use wall outlet power; server PSUs connect to multiple sources for redundancy
- Power consumption generates heat — fans and heat sinks dissipate it
- Heat sinks = metal fins attached to hot components (CPU) to spread heat

## 🖥️ Motherboard

- Interconnects all hardware using standardized connectors and form factors
- Contains **firmware** stored in nonvolatile memory
- Firmware evolution: BIOS → EFI → **UEFI** (most modern systems)
- Most people still call it "BIOS" regardless of actual firmware type
- Common firmware setting: enabling CPU virtualization extensions

| Firmware | Description                                              |
|----------|----------------------------------------------------------|
| BIOS     | Basic Input/Output System — original, mostly obsolete    |
| EFI      | Extensible Firmware Interface — Intel's advance          |
| UEFI     | Unified EFI — industry standard on all modern systems    |

## 🧠 Memory (RAM)

- Holds data and program code of currently running applications
- Also called RAM, DIMM, SIMM, DDR
- Individual modules: 2 GB to 64 GB per stick

| Use case                  | Recommended RAM  |
|---------------------------|------------------|
| Minimum general purpose   | 4 GB             |
| Individual workstation    | 16 GB            |
| Gaming / video / audio    | 16 GB+           |
| Servers                   | 128 GB – 256 GB  |

- **Swap space** — special disk area used when RAM is full — Linux moves idle apps here
- Systems without dedicated GPU use ~1 GB of RAM for video display

```bash
free -m    # show memory usage in megabytes
# total = all RAM, used = in use, available = can be used by apps
```

## ⚙️ Processors (CPU)

- CPU = Central Processing Unit — processes binary commands from software
- GPU = Graphical Processing Unit — task-specific processor for graphics
- All processors are not CPUs — but all CPUs are processors

| Architecture | Description                                           |
|--------------|-------------------------------------------------------|
| i386         | 32-bit Intel 80386 instruction set                    |
| x86          | 32-bit successors to 80386 (486, 586, Pentium)        |
| x64 / x86-64 | Supports both 32-bit and 64-bit x86 instructions      |
| AMD64        | AMD's x64 support                                     |
| ARM          | RISC CPU — mobile, embedded, Raspberry Pi, not x86    |

## 🔑 CPU Factors

| Factor      | Description                                                                      |
|-------------|----------------------------------------------------------------------------------|
| Bit size    | 32-bit = max 4 GB RAM. 64-bit = more RAM. 32-bit runs on 64-bit, NOT vice versa. |
| Clock speed | MHz or GHz — how fast instructions are processed                                 |
| Cache       | L1, L2, L3, L4 — high-speed buffer between CPU and RAM. More = better.           |
| Cores       | Individual CPUs. Hyper-Threading (HTT) = one physical CPU acts as multiple       |

```bash
lscpu              # display CPU architecture and details
cat /proc/cpuinfo  # detailed (less readable) CPU info
```

## 💾 Storage

| Feature        | HDD                          | SSD                           |
|----------------|------------------------------|-------------------------------|
| Technology     | Magnetic spinning disks      | Microchips — no moving parts  |
| Speed          | Baseline                     | 3–5x faster than HDD          |
| Cost per GB    | Lower                        | 3–10x more expensive          |
| Reliability    | Moving parts = more failure  | More reliable                 |
| Power          | Higher consumption           | Lower consumption             |

- Common interfaces: **SATA** (Serial AT Attachment), **SCSI**
- **RAID** = Redundant Array of Independent Disks — multiple disks for redundancy
- RAID levels: 0, 1, 5, 6, 10 — different redundancy and performance trade-offs

```bash
lsblk      # list block (storage) devices and partitions
lsblk -f   # list with filesystem type and mount point
```

## 🗂️ Partitions

- Partitioning divides a storage device into independent sections
- Each partition treated as a separate device by Linux
- Raw device must be **formatted** before use — formatting writes a filesystem
- **LVM** (Logical Volume Manager) = software to combine multiple disks into one virtual drive
- Reasons to partition: manage storage, isolate encryption, multiple OS, multiple filesystems

## 🔌 Peripherals and Interfaces

- Peripherals provide input, output and connection to the real world
- Common built-in: Ethernet, HDMI, USB (multiple versions with different speeds)
- Expansion cards added via slots: GPU, sound, network, RAID
- **SoC** (System on a Chip) = CPU + RAM + SSD + peripherals in one chip — phones/tablets

## 🔧 Device Drivers and Device Files

- Device drivers translate software requests into device-specific control
- Allow apps to read/write files without knowing the underlying hardware
- Device files live in `/dev` directory

| Device file    | Meaning                                   |
|----------------|-------------------------------------------|
| `/dev/sda`     | Entire first SATA/SCSI storage device     |
| `/dev/sda1`    | Partition 1 of first storage device       |
| `/dev/sdb3`    | Partition 3 of second storage device      |
| `/dev/sdc3`    | Partition 3 of THIRD storage device       |
| `/dev/mmcblk0` | SD card device                            |
| `/dev/mmcblk0p1`| Partition 1 of SD card                   |

- Naming: `sd` + letter (a=first, b=second, c=third) + number (partition)
- Device files show `b` as first character in ls -l (block device)

```bash
ls -l /dev/sd*     # list SATA storage device files
lsblk              # list block devices
lsblk -f           # list with filesystem type and mount point
```

## 🔑 Key Takeaways

- Motherboard interconnects everything — UEFI is the modern firmware standard
- RAM holds running programs — swap space extends RAM to disk when full
- CPU = Central Processing Unit, GPU = Graphical Processing Unit
- 64-bit systems can run 32-bit apps — but NOT vice versa
- ARM = RISC architecture used by Raspberry Pi, phones — not x86
- SSD is faster and more reliable than HDD but costs more per GB
- RAID provides redundancy — if one disk fails data is still available
- Partitions divide storage — must be formatted before use
- Device files in /dev: sda=first drive, sdb=second, sdc=third, number=partition
- sdc3 = partition 3 of the third SATA drive (NOT sd3p3 or sdcp3)
- Commands: `free -m`, `lscpu`, `lsblk`, `lsblk -f`

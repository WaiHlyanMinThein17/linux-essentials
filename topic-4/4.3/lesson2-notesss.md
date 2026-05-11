# 📓 Topic 4.3 Lesson 2 — Processes and System Logging

**Course:** LPI Linux Essentials (010-160) · **Date:** May 8, 2026 · **Status:** ✅ Complete

## ⚙️ Processes

- Every command issued generates one or more **processes**
- Processes exist in a hierarchy — parent processes start child processes
- Every process has a unique **PID** (Process ID) and **PPID** (Parent Process ID)
- PIDs are positive integers assigned in sequential order
- First process after boot = PID 1 = `systemd` (modern) or `/sbin/init` (older)

```bash
cat /proc/1/cmdline; echo    # check what PID 1 is running
```

## 📊 top — Dynamic Process Viewer

- Shows all running processes dynamically in real time
- Default sort: highest CPU usage first

| Key  | Action in top                       |
|------|-------------------------------------|
| `M`  | Sort by memory usage                |
| `N`  | Sort by PID number                  |
| `T`  | Sort by running time                |
| `P`  | Sort by CPU usage (default)         |
| `R`  | Toggle ascending/descending order   |
| `k`  | Kill a process (enter PID)          |
| `m`  | Toggle memory display (progress bars)|
| `W`  | Save current top configuration      |

- top config saved to: `~/.config/procps/toprc`
- Alternatives: `htop` (friendlier), `atop` (more detailed)

## 📸 ps — Process Snapshot

```bash
ps              # processes in current shell only
ps -f           # full format — shows PPID, start time, UID
ps -uf          # full format with parent/child relationship
ps -v           # shows memory usage percentage
pstree          # visual tree of process hierarchy
```

| ps column | Meaning                          |
|-----------|----------------------------------|
| PID       | Process ID                       |
| PPID      | Parent Process ID                |
| TTY       | Terminal the process runs in     |
| TIME      | CPU time consumed                |
| CMD       | Command that started the process |

## 📁 Process Info in /proc

- `/proc` contains a numbered directory for EVERY running process
- Directory name = the PID of that process

```bash
ls /proc              # lists all PIDs as directories
ls /proc/1/           # files for PID 1 (systemd)
cat /proc/1/cmdline   # see what command started PID 1
```

## 📈 System Load

```bash
uptime
# → 22:12:54 up 13 days, 1 user, load average: 2.91, 1.59, 0.39
#                                               ^1min  ^5min  ^15min
```

- Load average shown for last 1 minute, 5 minutes, 15 minutes
- Higher number = more processes waiting = busier system

## 📋 System Logging

- Logs = files where system events are recorded — essential for troubleshooting
- Traditionally managed by `syslog`, `syslog-ng`, or `rsyslog`
- Logs stored in `/var/log` because logs are variable data

| Log file              | Contains                                         |
|-----------------------|--------------------------------------------------|
| `/var/log/auth.log`   | Authentication events, sudo, login/logout        |
| `/var/log/kern.log`   | Kernel messages                                  |
| `/var/log/syslog`     | General system information                       |
| `/var/log/messages`   | System and application data                      |
| `/var/log/wtmp`       | Successful logins (binary — read with `last`)    |
| `/var/log/btmp`       | Failed login attempts (binary — read with `lastb`)|

## 📝 Log File Format

Each log line: **Timestamp · Hostname · Program [PID] · Message**

```bash
less /var/log/messages          # read log with pager
tail -f /var/log/messages       # follow log in real time
```

- Most logs = plain text — readable with less, cat, grep
- Binary logs (wtmp, btmp) need special commands
- Use `file` command to check if a log is binary or text

## Where Do Log Messages Go?

| Message type                    | Log file             |
|---------------------------------|----------------------|
| Authentication, sudo, login     | /var/log/auth.log    |
| Kernel messages (drivers, USB)  | /var/log/kern.log    |
| General system/dbus messages    | /var/log/syslog      |
| Application and system data     | /var/log/messages    |

## 🔄 Log Rotation — logrotate

- Prevents log files from filling up disk space
- Renames, archives, compresses and eventually deletes old logs
- Rotated logs: `error.log` → `error.log.1` → `error.log.2.gz`

## 🔔 Kernel Ring Buffer — dmesg

- Fixed-size circular buffer storing kernel messages
- Captures boot messages before syslog is available
- Old messages fade away as new ones arrive

```bash
dmesg                      # print kernel ring buffer
dmesg | grep boot          # filter for boot messages
dmesg | less               # page through kernel messages
journalctl -k              # same as dmesg (via systemd)
```

## 📰 systemd Journal — journalctl

- systemd replaced SysV Init in 2015 as standard system manager
- `journald` = systemd's journal daemon — now standard logging service
- Logs stored in **binary format** — must use `journalctl` to read
- journald is syslog-compatible

| journalctl command              | Purpose                              |
|---------------------------------|--------------------------------------|
| `journalctl`                    | Print entire journal                 |
| `journalctl -k`                 | Kernel messages only (same as dmesg) |
| `journalctl -b`                 | Boot messages                        |
| `journalctl -f`                 | Follow — show new entries live       |
| `journalctl -u ssh.service`     | Messages for a specific service      |
| `journalctl -u apache2.service` | Apache web server messages           |

## 📋 Binary Log Commands

| Log file                              | Command to read |
|---------------------------------------|-----------------|
| `/var/log/wtmp`                       | `last`          |
| `/var/log/btmp`                       | `lastb`         |
| `/run/log/journal/.../system.journal` | `journalctl`    |

## 🔑 Key Takeaways

- Every command creates processes — each has a unique PID and PPID
- PID 1 = systemd — first process started after kernel loads
- `top` = dynamic process viewer, `ps` = static snapshot
- /proc has a directory for every running process named by PID
- `uptime` shows load average for 1, 5, 15 minutes
- Logs stored in /var/log — variable data changes over time
- auth.log = authentication, kern.log = kernel, syslog = system
- wtmp = successful logins (read with last), btmp = failed (read with lastb)
- `tail -f` = follow log file in real time
- logrotate prevents logs from filling disk — archives old logs
- `dmesg` and `journalctl -k` both show kernel ring buffer
- journald stores logs in binary — use `journalctl` not less/cat
- `journalctl -u service.name` queries a specific service

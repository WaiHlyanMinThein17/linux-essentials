# 📓 Topic 2.3 Lesson 2 — Home Directories and ls Options

**Course:** LPI Linux Essentials (010-160) · **Date:** May 7, 2026 · **Status:** ✅ Complete

## 🏠 Home Directories

- Every user gets their own directory inside `/home`
- Example: `/home/wai`, `/home/michael`, `/home/lara`
- The root superuser's home is `/root` — not inside /home
- `/home` is like an apartment building — each user has their own space
- Users start every new terminal session in their home directory
- Changes to files in `/` (root filesystem) require administrator permissions

## 🌟 The ~ (Tilde) and Relative-to-Home Paths

| Path           | Meaning                       | Example                       |
|----------------|-------------------------------|-------------------------------|
| `~`            | Current user's home directory | `cd ~` → /home/wai            |
| `~username`    | Another user's home directory | `cd ~michael` → /home/michael |
| `cd` (no args) | Same as cd ~ — go home        | `cd` → /home/wai              |

- ~ changes meaning depending on who is logged in
- Any path containing ~ is called a **relative-to-home path**
- Accessing another user's home requires their permission

```bash
cd ~                              # go to your home directory
cd ~michael                       # go to michael's home directory
cd ~/Documents                    # go to your Documents folder
less ~user/Documents/report.txt   # read user's file (if permitted)
```

## 👁️ Hidden Files and Directories

- Any file or directory starting with `.` is hidden by default
- Not shown by plain `ls` — use `ls -a` to reveal them
- Usually contain user-specific configuration settings
- Should only be modified by experienced users

```bash
ls -a ~
# Output:
.               ← current directory
..              ← parent directory
.bash_history   ← hidden — command history
.bash_logout    ← hidden — runs on logout
.bashrc         ← hidden — shell config
Documents       ← visible regular directory
```

## 📋 ls Options — Complete Reference

| Option | Name           | Description                                        |
|--------|----------------|----------------------------------------------------|
| `-a`   | all            | Show all files including hidden (starting with .)  |
| `-l`   | long           | Long format — shows permissions, owner, size, date |
| `-h`   | human readable | File sizes as KB, MB, GB instead of bytes          |
| `-t`   | time           | Sort by modification time — newest first           |
| `-r`   | reverse        | Reverse the sort order                             |
| `-S`   | size           | Sort by file size — largest first                  |
| `-X`   | eXtension      | Sort by file extension                             |
| `-R`   | Recursive      | List all files in all subdirectories               |
| `-d`   | directory      | List directories themselves, not their contents    |

## 🔗 Common ls Combinations

| Command    | What it does                                     |
|------------|--------------------------------------------------|
| `ls -lh`   | Long list with human readable sizes (1.5M, 4.0K) |
| `ls -lt`   | Long list sorted by newest modification first    |
| `ls -lrt`  | Long list sorted by oldest modification first    |
| `ls -lS`   | Long list sorted by largest file first           |
| `ls -lX`   | Long list sorted by file extension               |
| `ls -la`   | Long list including hidden files                 |
| `ls -R`    | Recursive — list all files in subdirectories     |
| `ls -d */` | Show only subdirectories, not files              |

## 📄 Reading ls -l Output

```bash
-rw-r--r-- 1 wai staff 3606 Jan 13 2017 report.txt
drwxrwxrwx 5 wai wai   4.0K Apr 26 2011 Documents/
```

| Field         | Meaning                                  |
|---------------|------------------------------------------|
| `d` or `-`    | d = directory, - = regular file          |
| `rw-r--r--`   | Permissions (owner, group, others)       |
| `1`           | Number of links                          |
| `wai staff`   | Owner and group                          |
| `3606`        | File size in bytes (or readable with -h) |
| `Jan 13 2017` | Last modification timestamp              |
| `report.txt`  | Filename                                 |

## 🔄 Recursion in ls

- `ls -R` runs ls in current directory, then enters each subdirectory and repeats
- Alternative to `tree` command — always available since it's part of ls
- Recursion is also important for file operations like copying and removing directories

## 🏗️ Filesystem Hierarchy Standard (FHS)

Defines standard locations for files across all Linux systems.

| Directory | Purpose                         |
|-----------|---------------------------------|
| `/bin`    | Essential user commands         |
| `/etc`    | System configuration files      |
| `/home`   | User home directories           |
| `/var`    | Variable data — logs, databases |
| `/tmp`    | Temporary files                 |
| `/usr`    | User programs and data          |
| `/root`   | Root user's home directory      |
| `/dev`    | Device files                    |
| `/proc`   | Process and kernel information  |

## 🔑 Key Takeaways

- User home directories live in /home/username — root user's home is /root
- ~ = current user's home, ~username = another user's home
- cd with no arguments = same as cd ~ (go home)
- Hidden files start with . — revealed with ls -a
- ls -lh = long format + human readable sizes (most useful daily combination)
- ls -lt = newest first, ls -lrt = oldest first
- ls -R = recursive listing — shows all subdirectory contents
- First character of ls -l: d = directory, - = regular file
- FHS defines standard directory locations across all Linux systems
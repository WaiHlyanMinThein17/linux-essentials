# 📓 Topic 5.4 — Special Directories and Files

**Course:** LPI Linux Essentials (010-160) · **Date:** May 8, 2026 · **Status:** ✅ Complete

## 📁 Temporary File Directories

| Directory    | Cleared on boot?          | Purpose                                              |
|--------------|---------------------------|------------------------------------------------------|
| `/tmp`       | Usually yes (recommended) | Short-lived temp files — not preserved between runs  |
| `/var/tmp`   | ❌ No — persists           | Temp files that need to survive reboots              |
| `/run`       | ✅ Yes — always cleared    | Runtime data — PID files, sockets for running procs  |

- `/var/run` may be a symlink to `/run` on modern systems
- Both `/tmp` and `/var/tmp` use the **sticky bit** — users can only delete their own files

```bash
ls -ldh /tmp /var/tmp
# drwxrwxrwt — the t = sticky bit set
```

## 🔗 Links — Two Types

| Feature                  | Hard Link                     | Symbolic (Soft) Link             |
|--------------------------|-------------------------------|----------------------------------|
| Points to                | Same inode (same data)        | Path/name of another file        |
| Works across filesystems?| ❌ No — same filesystem only  | ✅ Yes — any filesystem          |
| Can link to directories? | ❌ No — files only            | ✅ Yes                           |
| If target deleted        | Data still accessible         | Link breaks (dangling link)      |
| Increases link count?    | ✅ Yes                        | ❌ No                            |
| ls -l first char         | `-` (looks like regular file) | `l`                              |
| Inode                    | Same inode as target          | Different inode from target      |

## 🔧 Creating Links — ln command

```bash
# Hard link
ln target.txt hardlink            # create hard link in current dir
ln target.txt /path/to/hardlink   # create hard link at specific path

# Soft link
ln -s target.txt softlink                    # relative path (risky if moved)
ln -s /full/path/to/target.txt softlink      # absolute path (safe, recommended)
```

- Always use absolute paths for symbolic links — prevents broken links if moved
- If LINK_NAME is omitted, link created with same name as target in current dir

## 🔍 Identifying Links with ls

```bash
ls -l       # l = symlink, shows -> target
ls -li      # -i shows inode number (same inode = hard link)
```

```
# Example output:
3806696 -r--r--r-- 2 carol carol 111702 target.txt    ← same inode
3806696 -r--r--r-- 2 carol carol 111702 hardlink       ← same inode = hard link
5388837 lrwxrwxrwx 1 carol carol     12 softlink -> target.txt   ← l = symlink
```

- Same inode number = hard link
- Link count (2nd column) = number of hard links pointing to file
- Every file starts with link count of 1; each hard link adds 1

## 🗑️ Moving and Removing Links

```bash
rm softlink           # remove a link
mv softlink newname   # rename a link
mv softlink /newpath  # move a link
```

- Hard links can be moved freely — they point to inodes not paths
- Symbolic links with relative paths break if moved from original location
- Symbolic links with absolute paths work regardless of where moved

## ⚠️ Hard Link Limitations

- Cannot hard link across different filesystems/partitions — error: "Invalid cross-device link"
- Cannot hard link to directories
- Use symbolic links when crossing filesystem boundaries

## 📋 Symlink Permissions

- Symlinks always show `lrwxrwxrwx` in ls -l
- Actual access permissions are inherited from the **target file**
- The permissions shown on the symlink itself are irrelevant

## 🏗️ inode Explained

- inode = data structure storing file attributes (name, permissions, owner, disk location)
- Think of it as an index entry — "index node"
- Hard links point to the same inode → same data on disk
- Deleting a file removes the directory entry but data remains until link count = 0

## 📋 Practical Examples

```bash
# Create hard link
ln /home/carol/docs/report.txt report_link.txt

# Create symbolic link — ALWAYS use absolute path
ln -s /home/carol/docs/report.txt report_symlink.txt

# Check inode numbers (same = hard link)
ls -li

# Set sticky bit on a directory
chmod +t /my/temp/dir
chmod 1755 /my/temp/dir

# Verify sticky bit
ls -ld /tmp       # drwxrwxrwt — t = sticky bit
```

## 🔑 Key Takeaways

- /tmp = cleared on boot (usually), short-lived temp files
- /var/tmp = persists across reboots, longer-lived temp files
- /run = always cleared on boot, runtime PID files and sockets
- Both /tmp and /var/tmp have sticky bit set (drwxrwxrwt)
- Sticky bit = only file owner can delete their files in the directory
- Hard links = same inode, same filesystem only, files only, increases link count
- Soft links = point to a path, work across filesystems, can link dirs, l in ls
- If target of soft link deleted → link breaks. Hard link still works.
- Always use absolute paths when creating symbolic links
- ln = hard link, ln -s = symbolic link
- ls -li shows inode numbers — same inode = hard link
- Symlink permissions always show rwxrwxrwx — actual permissions come from target
- Cannot create hard links across different filesystems — use symlinks instead

# Topic 5.4 — Special Directories and Files

**Date:** 2026-05-19  
**Status:** Complete

---

## Temporary File Directories

Linux provides three directories for temporary and runtime data,
each with different persistence behavior:

| Directory | Cleared on boot | Purpose |
|-----------|-----------------|---------|
| `/tmp` | Usually yes | Short-lived files not needed between runs |
| `/var/tmp` | No | Temporary files that must survive reboots |
| `/run` | Always | Runtime data such as PID files and sockets |

On modern systems `/var/run` is typically a symlink pointing to
`/run`. Both `/tmp` and `/var/tmp` have the sticky bit set, which
means any user can write files there but only the file's owner can
delete them:

```bash
ls -ldh /tmp /var/tmp
```

The `t` at the end of the permission string confirms the sticky bit
is active.

---

## Hard Links and Symbolic Links

Linux provides two types of links for referencing files. They work
differently at the filesystem level and have different limitations.

| Feature | Hard link | Symbolic link |
|---------|-----------|---------------|
| Points to | The inode directly | A file path |
| Works across filesystems | No | Yes |
| Can link to directories | No | Yes |
| If target is deleted | Data remains accessible | Link breaks |
| Increases link count | Yes | No |
| First character in ls -l | `-` | `l` |
| Inode | Same as target | Different from target |

A hard link is a second directory entry pointing to the same inode
as the original file. Because both entries point to the same
underlying data, deleting one does not remove the data until every
hard link to that inode is removed. The link count in `ls -l` output
tracks how many hard links point to a given inode.

A symbolic link is a separate file that contains a path to another
file or directory. If the target is moved or deleted, the symbolic
link breaks and becomes a dangling link. Symbolic links work across
filesystem boundaries because they reference a path, not an inode.

---

## Creating Links with ln

```bash
# Hard link
ln target.txt hardlink
ln target.txt /path/to/hardlink

# Symbolic link
ln -s /full/path/to/target.txt softlink
```

Always use absolute paths when creating symbolic links. A relative
path works from the location where the link was created, but if the
link is ever moved to a different directory it will break because the
relative path no longer resolves correctly. An absolute path works
regardless of where the link lives.

If the link name is omitted, `ln` creates a link with the same name
as the target in the current directory.

---

## Identifying Links with ls

```bash
ls -l     # shows l as first character for symlinks and the target path
ls -li    # adds inode number as first column
```

Example output showing both link types:
3806696 -r--r--r-- 2 carol carol 111702 target.txt
3806696 -r--r--r-- 2 carol carol 111702 hardlink
5388837 lrwxrwxrwx 1 carol carol     12 softlink -> target.txt

The first column is the inode number. `target.txt` and `hardlink`
share inode `3806696`, which confirms they are hard links to the
same data. The link count of `2` in the third column reflects this.
`softlink` has a different inode and shows `l` as its file type,
confirming it is a symbolic link.

---

## Moving and Removing Links

```bash
rm softlink           # remove a link
mv softlink newname   # rename a link
mv softlink /newpath  # move a link to a new location
```

Hard links can be moved freely because they point directly to an
inode rather than a path. Symbolic links with relative paths will
break if moved. Symbolic links with absolute paths continue to work
regardless of where they are moved.

---

## Symlink Permissions

Symbolic links always display `lrwxrwxrwx` in `ls -l` output. These
permissions belong to the link itself and are irrelevant. The actual
access permissions that apply when you read, write, or execute
through the symlink come from the target file.

---

## Inodes

An inode is a data structure that stores a file's metadata:
permissions, owner, group, timestamps, and the disk locations of the
file's data blocks. The filename is not stored in the inode. It is
stored in the directory entry that points to the inode. This
separation is what makes hard links possible. Multiple directory
entries, each with a different name, can point to the same inode and
therefore the same data on disk.

When a file is deleted, the directory entry is removed and the link
count decreases by one. The actual data on disk is only released when
the link count reaches zero.
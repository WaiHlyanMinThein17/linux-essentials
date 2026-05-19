# Topic 5.3 — Managing File Permissions and Ownership

**Date:** 2026-05-19  
**Status:** Complete

---

## Reading ls -l Output

The `ls -l` command displays detailed file information in a structured
format. Each line represents one file or directory:

```bash
drwxrwxr-x 2 carol carol 4096 Dec 10 15:57 Another_Directory
-rw------- 1 carol carol  539663 Dec 10 10:43 picture.jpg
```

| Column | Meaning |
|--------|---------|
| Character 1 | File type |
| Characters 2-4 | Owner permissions |
| Characters 5-7 | Group permissions |
| Characters 8-10 | Others permissions |
| Column 2 | Number of hard links |
| Column 3 | Owner username |
| Column 4 | Owning group |
| Column 5 | File size in bytes |
| Column 6 | Last modification timestamp |
| Column 7 | Filename |

The first character identifies the file type:

| Character | Type |
|-----------|------|
| `-` | Regular file |
| `d` | Directory |
| `l` | Symbolic link |
| `b` | Block device |
| `c` | Character device |
| `s` | Socket |

---

## Permission Meanings

Each of the three permission sets contains three characters
representing read, write, and execute:

| Permission | Octal | On files | On directories |
|------------|-------|----------|----------------|
| `r` read | 4 | Open and read the file | List directory contents |
| `w` write | 2 | Edit or delete the file | Create, delete, or rename files inside |
| `x` execute | 1 | Run as a program or script | Enter the directory with cd |
| `-` none | 0 | No permission | No permission |

Permissions are checked in a specific order: owner first, then group,
then others. The first matching category applies and the rest are
ignored. This means if you are the owner, only the owner permissions
apply, even if the group or others permissions are more permissive.

---

## Changing Permissions with chmod

chmod accepts two modes: symbolic and numeric.

**Symbolic mode** modifies specific permissions without affecting
others. The format is `chmod [who][operator][permissions] file`:

| Who | Applies to |
|-----|------------|
| `u` | Owner |
| `g` | Group |
| `o` | Others |
| `a` | Everyone |

| Operator | Effect |
|----------|--------|
| `+` | Add permission |
| `-` | Remove permission |
| `=` | Set exactly, replacing existing |

```bash
chmod g+w file.txt          # add write for group
chmod u-r file.txt          # remove read from owner
chmod a=rw file.txt         # set exactly rw for everyone
chmod u+rwx,g-x file.txt    # combine multiple changes
chmod -R u+rwx dir/         # apply recursively
```

**Numeric mode** sets all three permission groups at once using
the sum of r=4, w=2, x=1 for each group:

| Number | Permissions |
|--------|-------------|
| 7 | rwx |
| 6 | rw- |
| 5 | r-x |
| 4 | r-- |
| 3 | -wx |
| 2 | -w- |
| 1 | --x |
| 0 | --- |

```bash
chmod 755 file    # rwxr-xr-x
chmod 644 file    # rw-r--r--
chmod 600 file    # rw-------
chmod 660 file    # rw-rw----
```

A useful shortcut: if the numeric value for a permission set is odd,
the file is executable. Use symbolic mode when you want to flip one
permission without touching the rest. Use numeric mode when you want
to set all permissions at once precisely.

---

## Common Permission Patterns

| Octal | Symbolic | Typical use |
|-------|----------|-------------|
| 755 | rwxr-xr-x | Directories, public executables |
| 644 | rw-r--r-- | Regular files, config files |
| 600 | rw------- | Private files such as SSH keys |
| 700 | rwx------ | Private scripts and directories |
| 660 | rw-rw---- | Files shared within a group |
| 1777 | rwxrwxrwt | /tmp, world writable with sticky bit |

---

## Changing Ownership with chown and chgrp

```bash
chown carol file.txt              # change owner to carol
chown carol:students file.txt     # change owner and group together
chown :students file.txt          # change group only
chgrp students file.txt           # change group only, alternative syntax
sudo chown -R carol:users dir/    # recursive ownership change
```

Only root can change ownership of files belonging to other users.
A user can only transfer group ownership to a group they already
belong to.

---

## Special Permissions

Three special permission bits extend the standard model:

**Sticky bit** applies to directories. When set, only the file's
owner can delete or rename their own files inside that directory,
even if others have write permission. The `/tmp` directory uses
this so all users can write temporary files but cannot delete each
other's files:

```bash
chmod +t dir/       # set sticky bit
chmod 1755 dir/     # numeric: sticky + rwxr-xr-x
```

**SGID** on a directory causes new files created inside to inherit
the directory's group rather than the creating user's primary group.
This is useful for shared project directories where all files should
belong to the same group automatically:

```bash
chmod g+s dir/      # set SGID on directory
chmod 2755 dir/     # numeric: SGID + rwxr-xr-x
```

**SUID** on an executable file causes it to run with the owner's
privileges rather than the calling user's. The `passwd` command uses
this so regular users can write to `/etc/shadow`, which is otherwise
root-only:

```bash
chmod u+s file      # set SUID on file
chmod 4755 file     # numeric: SUID + rwxr-xr-x
```

In `ls -l` output, a lowercase `s` or `t` means the special bit is
set and execute permission is also present. An uppercase `S` or `T`
means the special bit is set but execute permission is absent, which
is usually a configuration mistake.
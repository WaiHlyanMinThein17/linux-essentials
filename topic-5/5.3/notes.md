# 📓 Topic 5.3 — Managing File Permissions and Ownership

**Course:** LPI Linux Essentials (010-160) · **Date:** May 8, 2026 · **Status:** ✅ Complete

## 📋 ls -l Output — Reading Permissions

```
drwxrwxr-x 2 carol carol 4096 Dec 10 15:57 Another_Directory
-rw------- 1 carol carol 539663 Dec 10 10:43 picture.jpg
```

| Column   | Meaning                                                      |
|----------|--------------------------------------------------------------|
| 1st char | File type (- file, d dir, l symlink, b block, c char, s socket)|
| Chars 2-4| Owner (user) permissions                                     |
| Chars 5-7| Group permissions                                            |
| Chars 8-10| Others permissions                                          |
| 2nd col  | Number of hard links                                         |
| 3rd col  | Owner (username)                                             |
| 4th col  | Owning group                                                 |
| 5th col  | File size in bytes                                           |
| 6th col  | Last modification timestamp                                  |
| 7th col  | Filename                                                     |

```bash
ls -l           # long listing
ls -lh          # human readable sizes (K, M, G)
ls -la          # include hidden files (. prefix)
ls -ld dir/     # show directory info, not contents
```

## 📁 File Types (first character of ls -l)

| Char | Type                               |
|------|------------------------------------|
| `-`  | Regular file                       |
| `d`  | Directory                          |
| `l`  | Symbolic link (soft link)          |
| `b`  | Block device (disks, storage)      |
| `c`  | Character device (terminals)       |
| `s`  | Socket                             |

## 🔑 Permission Meanings

| Permission   | Octal | On Files                  | On Directories                        |
|--------------|-------|---------------------------|---------------------------------------|
| `r` (read)   | 4     | Open and read file        | List directory contents (filenames)   |
| `w` (write)  | 2     | Edit or delete file       | Create, delete or rename files inside |
| `x` (execute)| 1     | Run as executable/script  | Enter (cd into) the directory         |
| `-` (none)   | 0     | No permission             | No permission                         |

- Permissions checked in order: owner first, then group, then others
- If you're the owner, only owner permissions apply — even if group/others are more permissive

## ✏️ chmod — Symbolic Mode

Format: `chmod [who][+/-/=][permissions] file`

| Who | Meaning                    |
|-----|----------------------------|
| `u` | User (owner)               |
| `g` | Group                      |
| `o` | Others                     |
| `a` | All (user + group + others)|

| Operator | Meaning             |
|----------|---------------------|
| `+`      | Add permission      |
| `-`      | Remove permission   |
| `=`      | Set exactly         |

```bash
chmod g+w file.txt          # add write for group
chmod u-r file.txt          # remove read for owner
chmod a=rw file.txt         # set exactly rw for everyone
chmod u+rwx,g-x file.txt    # combine with comma
chmod -R u+rwx dir/         # recursive — all files in directory
```

## 🔢 chmod — Numeric Mode

Each permission set = sum of: r=4, w=2, x=1, -=0

| Number | Permissions |
|--------|-------------|
| 7      | rwx (4+2+1) |
| 6      | rw- (4+2+0) |
| 5      | r-x (4+0+1) |
| 4      | r-- (4+0+0) |
| 3      | -wx (0+2+1) |
| 2      | -w- (0+2+0) |
| 1      | --x (0+0+1) |
| 0      | --- (none)  |

```bash
chmod 755 file    # rwxr-xr-x
chmod 644 file    # rw-r--r--
chmod 660 file    # rw-rw----
chmod 600 file    # rw-------
chmod 777 file    # rwxrwxrwx
```

- If permission value is odd → file is executable
- Numeric mode: set all permissions at once
- Symbolic mode: flip a single permission without touching others

## 👤 chown / chgrp — Changing Ownership

```bash
chown carol file.txt              # change owner to carol
chown carol:students file.txt     # change owner AND group
chown :students file.txt          # change group only
chgrp students file.txt           # change group only (alternative)
sudo chown -R carol:users dir/    # recursive ownership change
```

- Only root can change ownership of files owned by others
- User must be member of group to transfer group ownership to it

## 👥 Querying Groups

```bash
groups                       # show current user's groups
groups carol                 # show groups carol belongs to
sudo groupmems -g cdrom -l   # show members of a group
```

## ⭐ Special Permissions

| Name       | Octal | Symbolic         | Applies to        | Effect                                              |
|------------|-------|------------------|-------------------|-----------------------------------------------------|
| Sticky Bit | 1     | `t` in others    | Directories only  | Only file owner can delete/rename their own files   |
| SGID       | 2     | `s` in group     | Files + Dirs      | Files: run with group privileges. Dirs: new files inherit parent group |
| SUID       | 4     | `s` in user      | Files only        | Run with owner's privileges (e.g. passwd runs as root) |

```bash
chmod +t dir/              # set sticky bit
chmod g+s dir/             # set SGID on directory
chmod u+s file             # set SUID on file
chmod 1755 dir/            # sticky bit + rwxr-xr-x
chmod 2755 dir/            # SGID + rwxr-xr-x
chmod 4755 file            # SUID + rwxr-xr-x
chmod 6755 file            # SUID + SGID + rwxr-xr-x
chmod 0755 file            # remove all special bits
```

- Lowercase `s` or `t` = special bit set AND execute permission present
- Uppercase `S` or `T` = special bit set BUT execute permission NOT set
- /tmp uses sticky bit (drwxrwxrwt) — anyone can write but only owner can delete their files

## 📋 Common Permission Patterns

| Octal | Symbolic    | Typical use                          |
|-------|-------------|--------------------------------------|
| 755   | rwxr-xr-x   | Directories, public executables      |
| 644   | rw-r--r--   | Regular files, config files          |
| 600   | rw-------   | Private files (SSH keys)             |
| 700   | rwx------   | Private scripts/directories          |
| 660   | rw-rw----   | Shared files within a group          |
| 1777  | rwxrwxrwt   | /tmp — world writable + sticky bit   |

## 🔑 Key Takeaways

- Every file has owner (u), group (g) and others (o) permissions
- Permissions checked in order: owner → group → others. First match wins.
- r=4, w=2, x=1, -=0 — add them to get the octal value
- chmod symbolic: u/g/o/a + +/-/= + r/w/x
- chmod numeric: 3 (or 4) digit octal — first digit = special permissions
- chown changes owner, chgrp changes group, chown user:group changes both
- Sticky bit (t) on dirs — only owner can delete their own files
- SGID (s on group) on dirs — new files inherit parent directory's group
- SUID (s on user) on files — runs with owner's privileges (like passwd)
- Uppercase S or T = special bit set but no execute permission
- Use -R for recursive chmod/chown
- Odd numeric permission value → file is executable

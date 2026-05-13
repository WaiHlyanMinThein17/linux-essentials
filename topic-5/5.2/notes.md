# 📓 Topic 5.2 — Creating Users and Groups

**Course:** LPI Linux Essentials (010-160) · **Date:** May 8, 2026 · **Status:** ✅ Complete

## 👤 Adding Users — useradd

```bash
sudo useradd frank                          # create user with defaults
sudo useradd -m frank                       # create user with home directory
sudo useradd -m -u 1050 -g 1000 frank       # custom UID and primary GID
sudo useradd -m -s /bin/zsh frank           # custom shell
sudo useradd -m -c "Frank Smith" frank      # with GECOS comment
sudo useradd -m -G web_admin,db_admin frank # with secondary groups
sudo passwd frank                           # set password after creating
```

## ⚙️ useradd Key Options

| Option             | Purpose                                       |
|--------------------|-----------------------------------------------|
| `-m`               | Create home directory                         |
| `-M`               | Do NOT create home directory                  |
| `-u UID`           | Specify custom UID                            |
| `-g GID`           | Set primary group (by GID or name)            |
| `-G group1,group2` | Add to secondary groups (comma separated)     |
| `-s /bin/bash`     | Set login shell                               |
| `-c "comment"`     | Set GECOS comment field                       |
| `-d /path`         | Custom home directory path                    |
| `-e YYYY-MM-DD`    | Set account expiration date                   |
| `-f days`          | Days after password expires before disabled   |

- New user account is **locked** by default until password is set with `passwd`
- Requires root/sudo privileges
- Config defaults in `/etc/login.defs`

## 🗑️ Deleting Users — userdel

```bash
sudo userdel frank       # delete user (keeps home directory)
sudo userdel -r frank    # delete user AND home directory AND mail spool
```

- Other files owned by the user elsewhere must be found and deleted manually

## 👥 Adding Groups — groupadd

```bash
sudo groupadd developer           # create group (auto GID)
sudo groupadd -g 1090 developer   # create group with specific GID
```

## 🗑️ Deleting Groups — groupdel

```bash
sudo groupdel developer           # delete group
```

- Cannot delete a group that is the primary group of a user
- Primary and secondary groups must exist BEFORE running useradd

## 🔒 passwd Command

```bash
passwd                    # change your own password
sudo passwd frank         # change another user's password (root only)
sudo passwd -l frank      # lock account (adds ! prefix to hash)
sudo passwd -u frank      # unlock account (removes ! prefix)
sudo passwd -d frank      # delete password (passwordless account)
sudo passwd -e frank      # force password change at next login
sudo passwd -S frank      # show password status info
```

- Any user can change their own password
- Only root can change another user's password
- passwd has SUID bit set — runs as root even when called by regular user

## 🏠 Skeleton Directory — /etc/skel

- When new user's home is created, files from `/etc/skel` are copied into it
- Skel files are usually dotfiles — use `ls -Al /etc/skel` to list them
- Add files to /etc/skel to give every new user the same starting files
- Typical contents: `.bashrc`, `.bash_profile`, `.bash_logout`

## 🔍 Verifying Users and Groups

```bash
id frank                      # show UID, GID, groups for frank
groups frank                  # show groups frank belongs to
grep frank /etc/passwd        # check passwd entry
grep frank /etc/group         # check group memberships
```

## 📄 /etc/shadow — Key Fields Reference

| Field              | Meaning                                         | Example     |
|--------------------|-------------------------------------------------|-------------|
| Field 3 (LASTCHANGE)| Days since epoch of last password change. 0 = must change now | 18029 |
| Field 4 (MINAGE)   | Min days between password changes               | 0           |
| Field 5 (MAXAGE)   | Max days before password must change            | 90          |
| Field 6 (WARN)     | Days of warning before expiry                   | 7           |
| Field 7 (INACTIVE) | Days after expiry before account disabled       | 30          |
| Field 8 (EXPDATE)  | Account expiration date (days since epoch)      | empty=never |

- LASTCHANGE = 0 → user must change password at next login
- Password starting with `!` → account locked

## 📁 File Permissions Summary

| File          | Permissions  | Readable by                  |
|---------------|--------------|------------------------------|
| /etc/passwd   | -rw-r--r--   | Everyone                     |
| /etc/group    | -rw-r--r--   | Everyone                     |
| /etc/shadow   | -rw-r-----   | Root only (+ shadow group)   |
| /etc/gshadow  | -rw-r-----   | Root only (+ shadow group)   |

## 📋 Complete Command Reference

| Command    | Purpose                                      |
|------------|----------------------------------------------|
| `useradd`  | Create a new user account                    |
| `userdel`  | Delete a user account                        |
| `groupadd` | Create a new group                           |
| `groupdel` | Delete a group                               |
| `passwd`   | Set/change password, lock/unlock accounts    |
| `id`       | Show UID, GID and group memberships          |
| `groups`   | Show groups a user belongs to                |
| `chsh`     | Change login shell                           |
| `chfn`     | Change GECOS field info                      |

## 🔑 Key Takeaways

- useradd creates user — always use passwd immediately after to set password
- New accounts are locked until a password is set
- userdel -r removes user AND home directory — without -r keeps home
- groupadd -g sets specific GID, groupdel removes group
- Cannot delete a group that is someone's primary group
- Primary/secondary groups must exist before running useradd
- /etc/skel = template files copied to new user's home directory
- LASTCHANGE = 0 in shadow → user must change password next login
- ! prefix in shadow password field → account is locked
- /etc/passwd and /etc/group are world-readable
- /etc/shadow and /etc/gshadow are root-only readable
- passwd command has SUID bit — runs as root for any user
- Never edit /etc/passwd, /etc/shadow etc. directly — use the commands

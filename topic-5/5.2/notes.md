# Topic 5.2 — Creating Users and Groups

**Date:** 2026-05-08  
**Status:** Complete

---

## Creating Users with useradd

`useradd` creates a new user account. It requires root privileges and
accepts several options to configure the account at creation time:

```bash
sudo useradd frank                           # create with defaults
sudo useradd -m frank                        # create with home directory
sudo useradd -m -u 1050 -g 1000 frank        # custom UID and primary GID
sudo useradd -m -s /bin/zsh frank            # custom login shell
sudo useradd -m -c "Frank Smith" frank       # with GECOS comment
sudo useradd -m -G web_admin,db_admin frank  # with secondary groups
sudo passwd frank                            # set password after creating
```

| Option | Purpose |
|--------|---------|
| `-m` | Create home directory |
| `-M` | Do not create home directory |
| `-u UID` | Specify a custom UID |
| `-g GID` | Set primary group by GID or name |
| `-G group1,group2` | Add to secondary groups |
| `-s /bin/bash` | Set login shell |
| `-c "comment"` | Set GECOS comment field |
| `-d /path` | Set custom home directory path |
| `-e YYYY-MM-DD` | Set account expiration date |
| `-f days` | Days after password expires before account is disabled |

New accounts are locked by default until a password is set with
`passwd`. Default values for new accounts are configured in
`/etc/login.defs`.

---

## Deleting Users with userdel

```bash
sudo userdel frank      # delete account, keep home directory
sudo userdel -r frank   # delete account and home directory and mail spool
```

Files owned by the deleted user that exist outside their home
directory are not removed automatically. They must be found and
deleted manually.

---

## Creating and Deleting Groups

```bash
sudo groupadd developer           # create group with automatic GID
sudo groupadd -g 1090 developer   # create group with specific GID
sudo groupdel developer           # delete a group
```

A group cannot be deleted if it is the primary group of any existing
user. Both primary and secondary groups must exist on the system
before running `useradd` with the `-g` or `-G` options.

---

## Managing Passwords with passwd

```bash
passwd                    # change your own password
sudo passwd frank         # change another user's password
sudo passwd -l frank      # lock account
sudo passwd -u frank      # unlock account
sudo passwd -d frank      # delete password, makes account passwordless
sudo passwd -e frank      # force password change at next login
sudo passwd -S frank      # show password status
```

Any user can change their own password. Only root can change another
user's password. The `passwd` binary has the SUID bit set, which
means it runs as root even when called by a regular user. This is
what allows the command to write to `/etc/shadow`, which is
otherwise root-only.

Locking an account adds a `!` prefix to the password hash in
`/etc/shadow`. Unlocking removes it.

---

## The Skeleton Directory

When a new user's home directory is created, Linux copies the
contents of `/etc/skel` into it. This gives every new user a
consistent starting environment. The directory typically contains
dotfiles such as `.bashrc`, `.bash_profile`, and `.bash_logout`:

```bash
ls -Al /etc/skel
```

Adding files to `/etc/skel` before creating users ensures every
subsequent user receives those files automatically.

---

## Verifying Users and Groups

```bash
id frank               # show UID, GID, and group memberships
groups frank           # show groups frank belongs to
grep frank /etc/passwd # check the passwd entry
grep frank /etc/group  # check group memberships
```

---

## The /etc/shadow Fields

Each line in `/etc/shadow` has eight colon-separated fields:

| Field | Name | Meaning |
|-------|------|---------|
| 3 | LASTCHANGE | Days since epoch of last password change. 0 means must change now |
| 4 | MINAGE | Minimum days between password changes |
| 5 | MAXAGE | Maximum days before password must be changed |
| 6 | WARN | Days of warning before expiry |
| 7 | INACTIVE | Days after expiry before account is disabled |
| 8 | EXPDATE | Account expiration date. Empty means never |

---

## File Permission Summary

| File | Permissions | Readable by |
|------|-------------|-------------|
| `/etc/passwd` | -rw-r--r-- | Everyone |
| `/etc/group` | -rw-r--r-- | Everyone |
| `/etc/shadow` | -rw-r----- | Root and shadow group only |
| `/etc/gshadow` | -rw-r----- | Root and shadow group only |

---

## What I Found Difficult

Write one or two honest sentences about what genuinely took longer
to understand. Be specific about what confused you and how it clicked.

---

## Questions Still Open

Anything you want to verify or follow up on later.
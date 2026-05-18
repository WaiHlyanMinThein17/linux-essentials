# Topic 5.1 — Basic Security and Identifying User Types

**Date:** 2026-05-18  
**Status:** Complete

---

## Account Types

Linux organizes user accounts into four categories, each with a
distinct purpose and UID range:

| Type | UID | Home Directory | Login Shell | Purpose |
|------|-----|----------------|-------------|---------|
| Superuser (root) | 0 | /root | /bin/bash | Unrestricted system access |
| System accounts | below 1000 | None or outside /home | /sbin/nologin | OS services and daemons |
| Service accounts | above 1000 | Outside /home | /sbin/nologin | Installed service processes |
| Regular users | 1000 and above | /home/username | /bin/bash | Normal human users |

For the LPI exam, the boundary is UID 1000. Below that is a system
account. At 1000 and above is a regular or service account.

Every user has a primary group ID. By default, when a new user is
created, a group is created with the same name and the same number as
the user's UID.

---

## The Root Account

Root has UID 0 and GID 0. It has unrestricted access to every file,
process, and system configuration on the machine. Its home directory
is `/root`, not under `/home` like regular users. This is deliberate:
if the `/home` filesystem fails to mount, root can still log in and
recover the system.

The shell prompt changes depending on who is logged in. A dollar sign
(`$`) at the end of the prompt means you are a regular user. A hash
(`#`) means you are root.

---

## Switching Users and Escalating Privilege

```bash
su -                        # switch to root, loads root's environment
su - username               # switch to another user
sudo command                # run one command as root using your own password
```

Always use `su -` with the dash. Without it, you switch to root but
keep your current environment variables, which can cause unexpected
behavior. The dash ensures you get a proper login environment.

`sudo` is safer than `su` in most situations because it uses your own
password rather than the root password. This means the root password
never needs to be shared. Who can use `sudo` and for what commands is
controlled by `/etc/sudoers`. Always edit that file using `visudo`,
never directly, because `visudo` validates the syntax before saving
and prevents you from locking yourself out of sudo access.

---

## User Information Commands

```bash
id                  # show your own UID, GID, and group memberships
id emma             # show the same information for a specific user
who                 # list currently active logins
w                   # active logins plus system load and process info
last                # login history read from /var/log/wtmp
lastb               # failed login attempts
```

| Command | Shows |
|---------|-------|
| `who` | Who is currently logged in |
| `w` | Same as who, plus uptime, load average, and current process |
| `last` | Full login history including disconnections and reboots |
| `lastb` | Failed login attempts |

---

## Access Control Files

| File | Contains | Readable by |
|------|----------|-------------|
| `/etc/passwd` | Usernames, UID, GID, home directory, shell | Everyone |
| `/etc/group` | Group names, GID, members | Everyone |
| `/etc/shadow` | Hashed passwords and expiration policy | Root only |
| `/etc/gshadow` | Group passwords and detailed group info | Root only |
| `/etc/sudoers` | Who can run sudo and what commands | Root only |

These files should never be edited directly with a text editor.
Use the dedicated commands for each: `usermod`, `groupmod`, and
`visudo` for sudoers. Direct edits risk corrupting the file format
and breaking authentication on the system.

---

## The /etc/passwd Format

Each line follows this structure:
USERNAME:PASSWORD:UID:GID:GECOS:HOMEDIR:SHELL

A real entry looks like this:
emma:x:1000:1000:Emma Smith,42 Douglas St,555.555.5555:/home/emma:/bin/bash

The password field contains `x`, which means the actual password hash
is stored in `/etc/shadow` instead. The GECOS field holds optional
personal information in comma-separated format. Two commands let you
update these fields:

```bash
chfn        # change the GECOS field interactively
chsh        # change the login shell interactively
chsh -s /usr/bin/zsh    # change shell non-interactively
```

---

## The /etc/group Format

Each line follows this structure:
NAME:PASSWORD:GID:MEMBERS

A real entry looks like this:
students:x:1023:jsmith,emma

Members are listed as a comma-separated list of usernames. A user
does not need to appear in this list if the group is their primary
group, because that relationship is already recorded in `/etc/passwd`.

---

## The /etc/shadow Format

Each line follows this structure:
USERNAME:PASSWORD:LASTCHANGE:MINAGE:MAXAGE:WARN:INACTIVE:EXPDATE

The password field uses a prefix to indicate the hashing algorithm:

| Prefix | Algorithm | Status |
|--------|-----------|--------|
| `!!` | None | Account disabled, no password set |
| `$1$` | MD5 | Weak, avoid |
| `$5$` | SHA-256 | Acceptable |
| `$6$` | SHA-512 | Preferred |

Passwords are stored as one-way hashes, meaning the original password
cannot be recovered from the stored value. A random salt is added
before hashing so that two users with the same password will have
different hash values stored. Dates in this file are measured in days
since January 1, 1970, which is the Unix epoch.
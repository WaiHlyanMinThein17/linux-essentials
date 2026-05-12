# 📓 Topic 5.1 — Basic Security and Identifying User Types

**Course:** LPI Linux Essentials (010-160) · **Date:** May 8, 2026 · **Status:** ✅ Complete

## 👤 Account Types

| Type             | UID Range          | Home Dir           | Login Shell      | Purpose                     |
|------------------|--------------------|--------------------|------------------|-----------------------------|
| Superuser (root) | 0                  | /root              | /bin/bash        | Unlimited system access     |
| System accounts  | <100 or <1000      | None or outside /home | /sbin/nologin | OS services and daemons     |
| Service accounts | >1000 (not regular)| Outside /home      | /sbin/nologin    | Installed services          |
| Regular users    | ≥1000              | /home/username     | /bin/bash        | Normal human users          |

- **LPI exam:** UID <1000 = system account, UID ≥1000 = regular/service account
- Every user has a primary GID — by default same number as UID, same name as username
- root's home is `/root` — NOT under /home — needed when /home filesystem unavailable

## 🔑 Superuser (root)

- UID = 0 always
- GID = 0, group name = root
- Unlimited access and control over entire system
- Home directory: `/root`

## 👥 UIDs and GIDs

- UID = User ID, GID = Group ID — numeric identifiers
- Users and groups enumerated independently — same number can be both UID and GID
- Every user has one primary GID + can be member of additional groups
- By default: new user gets group with same name and GID = UID

## 🔍 User Information Commands

```bash
id                    # show current user's UID, GID and group memberships
id emma               # show info for specific user
last                  # show last login history (reads /var/log/wtmp)
lastb                 # show last bad (failed) login attempts
who                   # list currently active logins
w                     # active logins + system load + process info
```

| Command | Shows                              | Extra info                              |
|---------|------------------------------------|-----------------------------------------|
| `who`   | Active logins only                 | Basic                                   |
| `w`     | Active logins                      | Load average, uptime, idle, process     |
| `last`  | Login history including disconnected| Boot times, kernel version             |

## 🔐 Switching Users and Escalating Privilege

```bash
su -                  # switch to root (requires root password) — always use - flag
su - username         # switch to another user
sudo command          # run command as root using YOUR OWN password
```

- `$` at end of prompt = regular user
- `#` at end of prompt = root/superuser
- Always use `su -` (with dash) — loads proper login environment
- **sudo is safer than su** — uses your own password, no sharing root password
- sudo config file: `/etc/sudoers` — edit only with `visudo` command

## 📁 Access Control Files

| File               | Contains                                    | Readable by all? |
|--------------------|---------------------------------------------|------------------|
| `/etc/passwd`      | User accounts — UID, GID, home, shell       | ✅ Yes           |
| `/etc/group`       | Group accounts — GID, members               | ✅ Yes           |
| `/etc/shadow`      | Hashed passwords + expiration info          | ❌ Root only     |
| `/etc/gshadow`     | Detailed group info + group passwords       | ❌ Root only     |
| `/etc/sudoers`     | Who can use sudo and how                    | ❌ Root only     |
| `/etc/sudoers.d/`  | Supplemental sudo config files              | ❌ Root only     |

- ⚠️ Never edit these files directly — use dedicated commands
- ⚠️ Never edit /etc/sudoers directly — always use `visudo`

## 📄 /etc/passwd Format

Format: `USERNAME:PASSWORD:UID:GID:GECOS:HOMEDIR:SHELL`

```
emma:x:1000:1000:Emma Smith,42 Douglas St,555.555.5555:/home/emma:/bin/bash
```

| Field    | Value                              | Meaning                          |
|----------|------------------------------------|----------------------------------|
| USERNAME | emma                               | Login name                       |
| PASSWORD | x                                  | x = password stored in /etc/shadow|
| UID      | 1000                               | User ID                          |
| GID      | 1000                               | Primary Group ID                 |
| GECOS    | Emma Smith,42 Douglas St,...       | Full name, location, phone (CSV) |
| HOMEDIR  | /home/emma                         | Home directory path              |
| SHELL    | /bin/bash                          | Default login shell              |

```bash
chfn            # change GECOS field (full name, room, phone)
chsh            # change login shell interactively
chsh -s /usr/bin/zsh    # non-interactive shell change
```

## 📄 /etc/group Format

Format: `NAME:PASSWORD:GID:MEMBERS`

```
students:x:1023:jsmith,emma
```

- Members = comma-separated list of usernames in the group
- User doesn't need to be listed if this is their primary group

## 📄 /etc/shadow Format

Format: `USERNAME:PASSWORD:LASTCHANGE:MINAGE:MAXAGE:WARN:INACTIVE:EXPDATE`

| Password field value | Meaning                                   |
|----------------------|-------------------------------------------|
| `!!`                 | Disabled account — no password set        |
| `!$1$hash...`        | Disabled account with prior hash stored   |
| `$1$hash...`         | Enabled — MD5 hash (weak, avoid)          |
| `$5$hash...`         | Enabled — SHA256 hash                     |
| `$6$hash...`         | Enabled — SHA512 hash (preferred)         |

- Passwords stored as **one-way hash** — cannot be reversed
- Salt = random value added before hashing — same password ≠ same hash on different systems
- Epoch = January 1, 1970 UTC — shadow dates measured in days since epoch

## 🔑 Key Takeaways

- root = UID 0, unlimited access, home = /root (not under /home)
- Regular users: UID ≥1000, home in /home, have bash shell
- System accounts: UID <1000, no login shell, no /home
- $ prompt = regular user, # prompt = root
- Always use `su -` (with dash) when switching to root
- sudo is safer than su — uses your own password
- /etc/passwd readable by all — contains NO real password (just x)
- /etc/shadow readable only by root — contains hashed passwords
- /etc/sudoers readable only by root — edit only with visudo
- Passwords stored as one-way hash with random salt
- $6$ = SHA512 (most secure), $5$ = SHA256, $1$ = MD5 (weak)
- `id` = show UID/GID, `w` = active logins + system info, `last` = login history

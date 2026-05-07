# 📓 Topic 2.2 — Using the Command Line to Get Help

**Course:** LPI Linux Essentials (010-160) · **Date:** May 7, 2026 · **Status:** ✅ Complete

## 🆘 Ways to Get Help

| Method        | Command           | Detail level                      |
|---------------|-------------------|-----------------------------------|
| Built-in help | `command --help`  | Brief — quick overview of options |
| Man pages     | `man command`     | Full — standard reference         |
| Info pages    | `info command`    | Most detailed — hypertext format  |
| Documentation | `/usr/share/doc/` | README, changelogs, examples      |

## 📖 Man Pages

```bash
man mkdir          # open man page for mkdir
man 1 passwd       # open section 1 of passwd man page
man 5 passwd       # open section 5 of passwd man page
```

**Navigation inside man pages (uses less internally):**

| Key                  | Action                       |
|----------------------|------------------------------|
| `arrow keys / space` | Navigate up and down         |
| `/searchterm`        | Search forward               |
| `?searchterm`        | Search backward              |
| `N`                  | Jump to next match           |
| `Q`                  | Quit man page                |
| `H`                  | Show all navigation commands |

## 📋 Man Page Sections (up to 11, most optional)

| Section     | Description                  |
|-------------|------------------------------|
| NAME        | Command name and description |
| SYNOPSIS    | Command syntax               |
| DESCRIPTION | Effects of the command       |
| OPTIONS     | Available options            |
| EXAMPLES    | Sample command lines         |
| SEE ALSO    | Related topics               |
| BUGS        | Known limitations            |

## 🔢 Man Page Categories (8 categories)

| Category | Description                     |
|----------|---------------------------------|
| 1        | User commands                   |
| 2        | System calls                    |
| 3        | C library functions             |
| 4        | Drivers and device files        |
| 5        | Configuration files and formats |
| 6        | Games                           |
| 7        | Miscellaneous                   |
| 8        | System administrator commands   |

Example: `passwd(1)` = passwd command · `passwd(5)` = /etc/passwd config file

## 📄 Info Pages

```bash
info mkdir    # open info page for mkdir
```

- More detailed than man pages
- Formatted as hypertext — similar to web pages
- Structured into nodes within a tree
- Press Enter on asterisk (*) links to navigate between nodes
- Press ? inside info to see navigation commands

## 📁 /usr/share/doc/ Directory

- Stores documentation for most installed packages
- Each package has its own subdirectory
- Usually contains: README, changelog, example config files
- All files are plain text — read with any text editor

## 🔍 Locating Files

### locate command

```bash
locate filename          # search database for matching files
locate -l 3 README       # limit results to first 3 matches
sudo updatedb            # manually refresh the locate database
```

- Searches a pre-built database — very fast
- May miss recently created files — run `sudo updatedb` to fix
- Behaves as if pattern is surrounded by wildcards by default
- Database managed by `updatedb` — usually runs periodically

### find command

```bash
find . -name thesis.pdf       # search current directory
find ~ -name thesis.pdf       # search home directory recursively
find ~ -name "*[0-9]"         # find files ending with a number
```

- Searches the actual filesystem — always up to date
- Slower than locate but always current
- Supports wildcards and regular expressions
- Requires at least a path argument
- Not covered in LPI Linux Essentials exam — but useful in practice

## 📋 locate vs find

| Feature    | locate                  | find                |
|------------|-------------------------|---------------------|
| Speed      | Fast (reads database)   | Slower (filesystem) |
| Up to date | May miss new files      | Always current      |
| New files  | Run sudo updatedb first | Finds immediately   |
| LPI exam   | ✅ Covered               | ⚠️ Not in exam     |

## 📋 Useful Commands from Guided Exercises

| Command   | Purpose                                     |
|-----------|---------------------------------------------|
| `cat`     | Concatenate or view text files              |
| `cp`      | Copy a file                                 |
| `mv`      | Move or rename a file                       |
| `rm`      | Delete a file                               |
| `rm -r`   | Delete directory and contents recursively   |
| `mkdir`   | Create a new directory                      |
| `rmdir`   | Delete an empty directory                   |
| `head`    | Display first few lines of a file           |
| `tail`    | Display last few lines of a file            |
| `wc`      | Count words, lines or bytes of a file       |
| `grep`    | Search within a file                        |
| `chmod`   | Change file permissions                     |
| `ls -R`   | List directory contents recursively         |
| `whereis` | Find path of a program and its manual files |

## ⚠️ Important Note

The `cd` command does NOT have a man page because it is a shell builtin.
Builtin commands are documented inside the bash man page instead.
Run `help cd` to see builtin documentation.

## 🔑 Key Takeaways

- --help = quick, man = full reference, info = most detailed
- Man pages have up to 11 sections — most are optional
- 8 categories: 1=user commands, 5=config files, 8=sysadmin
- Navigate man with arrow keys, Q to quit, / to search
- locate = fast (database), find = always current (filesystem)
- Run sudo updatedb to refresh locate database for new files
- Shell builtins (cd) don't have man pages — use help instead
- /usr/share/doc/ contains README and docs for all installed packages
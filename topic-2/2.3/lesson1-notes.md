# 📓 Topic 2.3 Lesson 1 — Using Directories and Listing Files

**Course:** LPI Linux Essentials (010-160) · **Date:** May 7, 2026 · **Status:** ✅ Complete

## 📁 Files and Directories

- Files contain data — text, executables, or binary data
- Directories create organization — they contain files and other directories
- A directory inside another is called a **subdirectory**
- The directory containing another is called the **parent directory**

## 📝 File and Directory Names

- Can contain lowercase, uppercase, numbers, spaces and special characters
- Best practice: avoid spaces and special characters
- Spaces require escape character: `cd Mission\ Statements`
- File extensions (e.g. .txt) have **NO special meaning in Linux** — for human understanding only
- Hidden files and directories start with a dot: `.bashrc`

## 🧭 Essential Navigation Commands

| Command   | Purpose                             | Example                     |
|-----------|-------------------------------------|-----------------------------|
| `pwd`     | Print current working directory     | `pwd` → /home/wai/Documents |
| `cd path` | Change directory                    | `cd /home/wai`              |
| `ls`      | List directory contents             | `ls`                        |
| `ls -a`   | List ALL files including hidden     | `ls -a`                     |
| `tree`    | Display hierarchical directory tree | `tree`                      |
| `mkdir`   | Create a new directory              | `mkdir Reports`             |

## 🗺️ Absolute vs Relative Paths

| Type     | Description                                 | Example               |
|----------|---------------------------------------------|-----------------------|
| Absolute | Always starts with / — full path from root  | `/home/wai/Documents` |
| Relative | No leading / — relative to current location | `Documents/Reports`   |

```bash
# Absolute path — works from anywhere
cd /home/wai/Documents/Reports

# Relative path — only works if you are in /home/wai
cd Documents/Reports
```

## ⭐ Special Relative Paths

| Path | Meaning                       | Example       |
|------|-------------------------------|---------------|
| `.`  | Current directory             | `./script.sh` |
| `..` | Parent directory              | `cd ..`       |
| `~`  | Current user's home directory | `cd ~`        |
| `/`  | Root directory                | `cd /`        |

```bash
cd ..          # go up one level
cd ../..       # go up two levels
cd ~           # go to home directory
cd /           # go to root directory
```

## 🔍 ls -a reveals special paths

```bash
ls -a
# Output:
.           ← current directory
..          ← parent directory
report.txt  ← regular file
```

## 🧩 Path Navigation Examples

```bash
# Current location: /etc/udev/rules.d
cd ../../systemd/user   # → /etc/systemd/user
cd ..                   # → /etc/systemd

# Current location: /home/user/Documents
cd Reports              # relative → /home/user/Documents/Reports
cd /etc                 # absolute → /etc (fastest when far away)
```

## 🔤 Handling Spaces in Names

```bash
# All three methods work:
cd 'this is a test'       # single quotes
cd "this is a test"       # double quotes
cd this\ is\ a\ test      # escape each space

# Pro tip: type first few letters then press TAB
# Bash autocompletes with proper escaping automatically!
```

## 💡 TAB Autocomplete

- Press `TAB` after typing part of a filename/directory
- Bash completes the rest automatically
- Press `TAB TAB` to see all possible matches
- Handles spaces in names automatically with escape characters
- Saves time and prevents spelling errors

## 🔑 Key Takeaways

- File extensions have no special meaning in Linux — just human convention
- pwd = print working directory — always shows absolute path
- Absolute paths start with / and work from anywhere
- Relative paths depend on current location — no leading /
- . = current directory, .. = parent directory
- ls -a shows hidden files and the special . and .. entries
- cd .. goes up one level, cd ../.. goes up two levels
- Use absolute paths when destination is far away in the tree
- Use relative paths when destination is nearby
- TAB autocomplete is your best friend in the terminal
# 📓 Topic 2.1 — Command Line Basics (Lesson 1)

**Course:** LPI Linux Essentials (010-160) · **Date:** May 6, 2026 · **Status:** ✅ Complete

## 🐚 What is a Shell?
- A program that enables text-based communication between the OS and the user
- Reads user input and interprets it as commands
- Most common Linux shell: **Bash** (Bourne-Again Shell)

### Other shells
- C shell (csh/tcsh)
- Korn shell (ksh)
- Z shell (zsh)

## 💻 The Linux Prompt
Structure: `username@hostname current_directory shell_type`

| Symbol | Meaning                       |
|--------|-------------------------------|
| ~      | Current user's home directory |
| $      | Regular user                  |
| #      | Superuser (root)              |

Examples:
```
carol@mycomputer:~$    ← regular user in home directory
root@mycomputer:~#     ← root user in home directory
```

## 📐 Command Structure
```
command  [option(s)]  [argument(s)]
```

Example: `ls -l /home`
| Part     | Value | Role                            |
|----------|-------|---------------------------------|
| Command  | ls    | Program to run                  |
| Option   | -l    | Modifies behavior (long format) |
| Argument | /home | Target to act on                |

### Short vs Long options
```bash
ls -al                    # short combined
ls -a -l                  # short separate
ls --all --format=long    # long form
# All three are identical!
```

### Getting help
```bash
command --help    # quick overview of options
man command       # full manual page
```

## 🔧 Command Types

### Internal (Builtin) Commands
- Part of the shell itself — no separate file exists
- Examples: cd, echo, exit, set, export
- Around 30 builtin commands in Bash

### External Commands
- Separate binary programs found via the PATH variable
- Examples: ls, cat, man, git, python3

```bash
# Check command type
type cd      # → cd is a shell builtin
type ls      # → ls is /usr/bin/ls
type man     # → man is /usr/bin/man
```

## 🔤 Quoting

### Double Quotes " "
- Most special characters lose their meaning
- BUT these still work inside double quotes:
  - `$` (variable expansion)
  - `\` (escape character)
  - `` ` `` (backtick/command substitution)

```bash
echo "I am $USER"    # → I am wai (variable expands)
touch "new file"     # → creates ONE file called "new file"
```

### Single Quotes ' '
- ALL special characters lose their meaning
- Everything is treated literally

```bash
echo 'I am $USER'    # → I am $USER (literal, no expansion)
touch '$TWOWORDS'    # → creates file literally named $TWOWORDS
```

### Escape Character \
- Removes special meaning of the NEXT character only
- The backslash itself is not printed

```bash
echo \$USER    # → $USER (literal dollar sign)
echo \$HOME    # → $HOME
```

### Quick Reference
| Method        | Variable expansion     | Space as separator          |
|---------------|------------------------|-----------------------------|
| No quotes     | ✅ Yes                 | ✅ Yes (separates args)     |
| Double quotes | ✅ Yes                 | ❌ No (treated as literal)  |
| Single quotes | ❌ No                  | ❌ No                       |
| Backslash     | ❌ No (next char only) | N/A                         |

## ⚡ Practical Commands
```bash
type command      # check if builtin or external
hostname          # show or set system hostname
touch filename    # create empty file
ls -l             # list directory long format
echo "text"       # print text to terminal
```

## 🔑 Key Takeaways
- Shell = program that interprets commands for the OS
- Bash is the most common Linux shell
- ~ = home directory, $ = regular user, # = root
- Command structure: command → options → arguments
- Short options can be combined: -al = -a -l
- Use 'type' to check if a command is builtin or external
- Double quotes allow variable expansion; single quotes do not
- Backslash escapes the next character only
- Avoid spaces in filenames — use underscores or dots instead
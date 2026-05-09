# 📓 Topic 3.3 Lesson 1 — Turning Commands into a Script

**Course:** LPI Linux Essentials (010-160) · **Date:** May 8, 2026 · **Status:** ✅ Complete

## 📜 What is a Script?

- A text file containing commands that run one after another when executed
- Bash is both a shell AND a programming language
- Scripts automate repetitive tasks — essential for Linux administrators
- Convention: save bash scripts with `.sh` or `.bash` extension

## 🚀 Creating and Running a Script

```bash
# Step 1 — create the script file
echo 'echo "Hello World!"' > new_script.sh

# Step 2 — make it executable
chmod +x new_script.sh

# Step 3 — run it using ./
./new_script.sh
```

- Scripts must be executable — use `chmod +x`
- Use `./` prefix to run from current directory (not in PATH)
- Or add script directory to PATH to run without `./`

## 🔧 Why ./ is needed

- Bash searches PATH directories for commands — current dir NOT in PATH by default
- Without `./`: "command not found" error
- With `./`: tells bash to look in the current directory
- To add current dir to PATH: `PATH=$PATH:~/scripts`

## 🔑 The Shebang Line

```bash
#!/bin/bash
```

- First line of every script — tells OS which interpreter to use
- Starts with `#!` (hash + exclamation = "shebang")
- Followed by absolute path to the interpreter
- Find interpreter path with: `which bash` → `/bin/bash`
- Other examples: `#!/usr/bin/python3`, `#!/usr/bin/perl`

## 💬 Comments

```bash
#!/bin/bash
# This is a comment — ignored by the interpreter
# Always comment your scripts for other users
echo "Hello World!"   # inline comment also works
```

- Comments start with `#`
- Ignored by Bash — for human readers only
- Always document your scripts — it is best practice

## ✏️ Text Editors

| Editor   | Style           | Learning curve | Key notes                               |
|----------|-----------------|----------------|-----------------------------------------|
| vi / vim | Modal (3 modes) | Steep          | Available everywhere, very powerful     |
| nano     | Modeless        | Easy           | Beginner friendly, Ctrl shortcuts shown |

**vi modes:** Navigation (default) → `i` = Insert mode → `Esc` = back to Navigation → `:` = Command mode (save/quit)

**nano shortcuts:** `Ctrl+O` = save, `Ctrl+X` = exit, `Ctrl+W` = search

## 📦 Variables in Scripts

```bash
#!/bin/bash
username=Carol             # no spaces around =
greeting="Hello there"    # use quotes for values with spaces
echo "Hello $username!"   # $ accesses variable value
echo "Hello ${username}!" # alternative syntax with {}
```

| Rule                           | Detail                              |
|--------------------------------|-------------------------------------|
| No spaces around =             | `name=Carol` ✅ — `name = Carol` ❌ |
| Case sensitive                 | `username` ≠ `Username`             |
| Only alphanumeric + underscore | `my_var` ✅ — `my-var` ❌           |
| Variables are strings          | Math requires special syntax        |

## 🔤 Quotes with Variables

| Quote type          | Variable expansion? | Example                        |
|---------------------|---------------------|--------------------------------|
| Double quotes `" "` | ✅ Yes — "weak"      | `"Hello $name"` → Hello Carol |
| Single quotes `' '` | ❌ No — "strong"     | `'Hello $name'` → Hello $name |

```bash
username="Carol Smith"    # quotes needed for values with spaces
echo "Hello $username!"   # → Hello Carol Smith!
echo 'Hello $username!'   # → Hello $username! (literal)
```

## 📥 Script Arguments

| Variable | Contains                           |
|----------|------------------------------------|
| `$1`     | First argument passed to script    |
| `$2`     | Second argument                    |
| `$9`     | Ninth argument (max direct access) |
| `$#`     | Total number of arguments passed   |

```bash
#!/bin/bash
username=$1
echo "Hello $username!"
echo "Number of arguments: $#."
```

```bash
./script.sh Carol         # $1=Carol, $#=1
./script.sh Carol Dave    # $1=Carol, $2=Dave, $#=2
./script.sh               # $1="", $#=0 — no error, just empty
```

## 🔀 Conditional Logic — if statements

```bash
#!/bin/bash
if [ $# -eq 1 ]
then
  username=$1
  echo "Hello $username!"
else
  echo "Please enter only one argument."
fi
echo "Number of arguments: $#."
```

- Condition between `[ ]` — spaces inside brackets required
- `if` → `then` → `else` → `fi` (closes the if block)
- `elif` adds a second condition to check

## 🔢 Numerical Comparison Operators

| Operator | Meaning               | Example          |
|----------|-----------------------|------------------|
| `-eq`    | Equal to              | `[ $# -eq 1 ]`   |
| `-ne`    | Not equal to          | `[ $# -ne 2 ]`   |
| `-gt`    | Greater than          | `[ $1 -gt $2 ]`  |
| `-ge`    | Greater than or equal | `[ $1 -ge 0 ]`   |
| `-lt`    | Less than             | `[ $1 -lt 10 ]`  |
| `-le`    | Less than or equal    | `[ $1 -le 100 ]` |

Use `==` for **string** comparison: `[ "$1" == "$PWD" ]`

## 📋 Complete Script Example

```bash
#!/bin/bash
# A simple greeting script with argument checking

if [ $# -eq 1 ]
then
  username=$1
  echo "Hello $username!"
elif [ $# -eq 2 ]
then
  echo "Hello $1 and $2!"
else
  echo "Usage: ./script.sh name [name2]"
fi
echo "Number of arguments: $#."
```

## ⚙️ Special Variables Summary

| Variable   | Contains                          |
|------------|-----------------------------------|
| `$1 .. $9` | Positional arguments              |
| `$#`       | Number of arguments               |
| `$PATH`    | Directories searched for commands |
| `$PWD`     | Current working directory         |
| `$USER`    | Current username                  |
| `$HOME`    | Current user's home directory     |

## 🔑 Key Takeaways

- Scripts are executable text files — use `chmod +x` to make executable
- Run with `./script.sh` — current dir is not in PATH by default
- Always start with shebang: `#!/bin/bash`
- Comments start with `#` — document everything
- Variables: no spaces around =, case sensitive, strings by default
- Double quotes allow variable expansion, single quotes prevent it
- `$1, $2...` = positional args, `$#` = number of args
- if/then/else/fi syntax — spaces required inside `[ ]`
- Numerical operators: -eq, -ne, -gt, -ge, -lt, -le
- String comparison: == inside [ ]
# Topic 3.3 Lesson 1 — Turning Commands into a Script

**Date:** 2026-05-08  
**Status:** Complete

---

## What is a Script?

A script is a plain text file containing a sequence of commands that
the shell executes in order. Bash functions as both an interactive
shell and a programming language, which means the same commands you
type at the prompt can be saved into a file and run repeatedly without
retyping them.

Scripts are the primary way Linux administrators automate repetitive
tasks. By convention, Bash scripts use the `.sh` or `.bash` extension,
though Linux does not require this to execute them.

---

## The Shebang Line

Every Bash script should begin with a shebang on the first line:

```bash
#!/bin/bash
```

The `#!` characters tell the operating system which interpreter to use
when running the file. The path that follows must be absolute. To
confirm the correct path on your system, run `which bash`. Other
interpreters follow the same pattern, for example `#!/usr/bin/python3`
for Python scripts.

---

## Making a Script Executable

A script file must be marked executable before it can be run. The
three steps to create and run a basic script are:

```bash
# Create the file
echo 'echo "Hello World!"' > new_script.sh

# Grant execute permission
chmod +x new_script.sh

# Run it
./new_script.sh
```

The `./` prefix is required when running a script from the current
directory because Bash only searches directories listed in `$PATH` by
default, and the current directory is not included. Without `./`, Bash
reports "command not found" even if the file exists right there.

To run scripts without `./`, add their directory to `$PATH`:

```bash
PATH=$PATH:~/scripts
```

---

## Comments

Comments begin with `#` and are ignored by the interpreter. They exist
for human readers. Inline comments are also valid:

```bash
#!/bin/bash
# This script greets a user
echo "Hello World!"   # prints to standard output
```

Documenting scripts with comments is standard practice, particularly
when others may read or maintain your code.

---

## Text Editors

Two editors appear consistently in Linux environments:

| Editor | Style | Learning curve | Notes |
|--------|-------|----------------|-------|
| vim | Modal | Steep | Available on nearly every system |
| nano | Modeless | Gentle | Shows shortcuts at the bottom of the screen |

Vim operates in three modes. It opens in normal mode for navigation.
Pressing `i` enters insert mode for typing. Pressing `Esc` returns to
normal mode. Typing `:` enters command mode for saving and quitting,
for example `:wq` to write and quit.

Nano uses `Ctrl+O` to save, `Ctrl+X` to exit, and `Ctrl+W` to search.

---

## Variables

Variables store values for reuse throughout a script. The assignment
syntax requires no spaces around the equals sign:

```bash
#!/bin/bash
username=Carol
greeting="Hello there"
echo "Hello $username!"
echo "Hello ${username}!"   # braces are optional but clearer
```

| Rule | Detail |
|------|--------|
| No spaces around `=` | `name=Carol` works, `name = Carol` fails |
| Case sensitive | `username` and `Username` are different variables |
| Valid characters | Letters, numbers, and underscores only |
| Default type | Variables are strings unless treated otherwise |

---

## Quote Behavior

How Bash handles variables depends on the type of quotes used:

| Quote type | Variable expansion | Example result |
|------------|--------------------|----------------|
| Double `" "` | Yes | `"Hello $name"` becomes `Hello Carol` |
| Single `' '` | No | `'Hello $name'` stays `Hello $name` |

Use double quotes when you want the variable's value. Use single
quotes when you want the literal text including the dollar sign.

---

## Script Arguments

Arguments passed to a script at runtime are stored in positional
variables:

| Variable | Contains |
|----------|----------|
| `$1` | First argument |
| `$2` | Second argument |
| `$9` | Ninth argument |
| `$#` | Total number of arguments passed |

```bash
#!/bin/bash
username=$1
echo "Hello $username!"
echo "Number of arguments: $#."
```

```bash
./script.sh Carol          # $1=Carol, $#=1
./script.sh Carol Dave     # $1=Carol, $2=Dave, $#=2
./script.sh                # $1 is empty, $#=0, no error
```

---

## Conditional Logic

Bash uses `if/then/else/fi` blocks for conditional execution. The
condition sits inside square brackets with a required space on each
inner side:

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

Adding `elif` tests a second condition before falling through to
`else`.

---

## Comparison Operators

Bash uses different operators depending on whether you are comparing
numbers or strings:

| Operator | Meaning | Type |
|----------|---------|------|
| `-eq` | Equal to | Numeric |
| `-ne` | Not equal to | Numeric |
| `-gt` | Greater than | Numeric |
| `-ge` | Greater than or equal | Numeric |
| `-lt` | Less than | Numeric |
| `-le` | Less than or equal | Numeric |
| `==` | Equal to | String |
# Topic 2.1 Lesson 1 — Command Line Basics: The Shell and Quoting

**Date:** 2026-05-08  
**Status:** Complete

---

## The Shell

The shell is a program that reads commands typed by the user and passes
them to the operating system for execution. It also displays the output
of those commands. Bash is the default shell on most Linux distributions
and is the shell assumed throughout the LPI Linux Essentials curriculum.

When you open a terminal, the shell presents a prompt. The prompt ends
with a dollar sign (`$`) for regular users and a hash (`#`) for root.
This convention is universal across Linux documentation and learning
materials and should never be changed.

A command entered at the prompt follows a consistent structure: the
command name comes first, followed by options, followed by arguments.
Options modify the behavior of a command. Arguments tell the command
what to act on. Some commands accept no options or arguments at all.

---

## Builtin and External Commands

Commands fall into two categories. Builtin commands are part of the
shell itself and do not exist as separate programs on disk. External
commands are standalone programs stored somewhere in the filesystem,
typically under `/bin`, `/usr/bin`, or `/usr/sbin`.

Two commands help you identify which category a command belongs to:

```bash
type cd         # outputs: cd is a shell builtin
type ls         # outputs: ls is /usr/bin/ls
which ls        # outputs: /usr/bin/ls
```

`cd` must be a builtin because it changes the shell's own working
directory. An external program runs in its own process and cannot
affect the shell's state, so it could not implement `cd` correctly.

---

## Quoting

Quoting controls how the shell interprets special characters before
passing a command to the program. The shell processes the command line
before the program ever sees it, which means characters like `$`, `*`,
and spaces have meaning to the shell itself.

Double quotes are weak quotes. Inside double quotes, variable expansion
still occurs, command substitution still works, and backslash escaping
still applies. Everything else is treated literally.

Single quotes are strong quotes. Inside single quotes, every character
is treated as a literal character with no special meaning. There is no
way to include a single quote inside a single-quoted string.

A backslash escapes a single following character, treating it as a
literal rather than as a special character. This is useful when you
want to include a space, dollar sign, or other special character without
quoting an entire string.

```bash
echo "$USER"        # expands the variable, prints your username
echo '$USER'        # prints $USER literally
echo "cost: \$5"    # backslash escapes the dollar sign
```

---

## Variables

A variable is a named storage location for a value. Variables are
assigned without spaces around the equals sign. Referencing a variable
requires a dollar sign prefix.

```bash
greeting="hello"
echo $greeting      # prints: hello
echo "$greeting"    # same result, but safer inside larger strings
```

Environment variables are variables that are exported to child
processes. The shell itself sets several automatically. `$HOME` holds
the path to your home directory. `$USER` holds your username. `$PATH`
is a colon-separated list of directories the shell searches when you
type a command name without a full path.

```bash
echo $HOME          # prints your home directory path
echo $PATH          # prints all directories searched for commands
```
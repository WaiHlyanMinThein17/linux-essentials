# Topic 2.1 Lesson 2 — Command Line Basics: Variables and PATH

**Date:** 2026-05-08  
**Status:** Complete

---

## The PATH Variable

When you type a command name at the shell prompt, the shell does not
search the entire filesystem for it. Instead it looks through a specific
list of directories in order, stopping at the first match. That list is
stored in the `PATH` environment variable as a colon-separated string.

```bash
echo $PATH
# /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```

If a command is not found in any of those directories, the shell returns
a "command not found" error. This is the most common explanation for
that error when you know a program is installed but the shell cannot
find it. The solution is either to call the program using its full path
or to add its directory to `PATH`.

To run a program in the current directory, you must prefix it with `./`
because the current directory is not in `PATH` by default. This is a
deliberate security measure: it prevents a malicious program placed in
the current directory from shadowing a system command with the same name.

```bash
./script.sh         # runs script.sh from the current directory
```

---

## Modifying PATH

You can add a directory to `PATH` for the current session by reassigning
the variable. The convention is to include the existing value so you
are extending rather than replacing the list.

```bash
PATH=$PATH:/home/wai/bin
export PATH
```

`export` makes the variable available to child processes launched from
the current shell. Without it, the variable exists only in the current
shell and any program you run from it will not see the updated value.

To make the change permanent, add the export line to `~/.bashrc` or
`~/.bash_profile`. The difference between the two is when they are
read: `.bash_profile` is read at login, `.bashrc` is read each time a
new interactive shell starts.

---

## Environment Variables

Environment variables are variables that have been exported and are
therefore available to any process spawned from the current shell.
The shell sets several automatically at login.

```bash
echo $HOME      # home directory of the current user
echo $USER      # username of the current user
echo $SHELL     # path to the current user's login shell
echo $PWD       # current working directory
echo $OLDPWD    # previous working directory
```

`env` prints all currently set environment variables. This is useful
for debugging when a program behaves differently depending on its
environment.

```bash
env             # list all environment variables
```

---

## Command History

Bash keeps a record of previously entered commands in a history file,
by default `~/.bash_history`. This allows you to retrieve and reuse
commands without retyping them.

```bash
history         # print the full command history
!!              # repeat the last command
!n              # repeat command number n from history
Ctrl+R          # search history interactively
```

The up and down arrow keys cycle through recent commands one at a time.
`Ctrl+R` opens a reverse incremental search, where you type part of a
previous command and the shell finds the most recent match.

---

## Useful Shortcuts

A few keyboard shortcuts significantly speed up work at the command line.

```bash
Ctrl+C          # interrupt and cancel the current command
Ctrl+D          # send end-of-file, exits the current shell
Ctrl+L          # clear the terminal screen
Ctrl+A          # move cursor to beginning of line
Ctrl+E          # move cursor to end of line
Tab             # autocomplete command or filename
```

Tab completion is one of the most useful features of the shell. Pressing
Tab once completes a command or filename if there is only one match.
Pressing it twice shows all possible completions when there is more than
one match.
# Topic 3.3 Lesson 2 — Exit Codes, Loops and Input Validation

**Date:** 2026-05-08  
**Status:** Complete

---

## Exit Codes

Every command returns an exit code when it finishes. An exit code of
zero means the command succeeded. Any non-zero value indicates an
error of some kind. The exit code of the most recently executed
command is always stored in `$?`:

```bash
cat file.txt        # file exists, command succeeds
echo $?             # prints 0

cat missing.txt     # file does not exist
echo $?             # prints 1
```

Inside a script, the `exit` command terminates execution immediately
and returns a code to the calling shell. By convention, zero means
success, one means a general error, and two means an invalid argument.
Any line after an `exit` statement will never run:

```bash
#!/bin/bash
if [ $# -eq 1 ]
then
  echo "Hello $1!"
  exit 0
else
  echo "Error: one argument required."
  exit 1
fi
echo "This line is never reached."
```

Using distinct exit codes for different failure conditions makes
scripts easier to debug, because the caller can inspect `$?` and know
exactly what went wrong.

---

## Special Variables Reference

| Variable | Contains |
|----------|----------|
| `$1` .. `$9` | Individual positional arguments |
| `$#` | Total number of arguments passed |
| `$@` | All arguments as separate elements |
| `$*` | All arguments as a single string |
| `$?` | Exit code of the last executed command |
| `$PATH` | Directories Bash searches for commands |
| `$PWD` | Current working directory |
| `$USER` | Current username |
| `$HOME` | Home directory of the current user |

`$@` is preferred over `$*` when iterating because it preserves
argument boundaries correctly, particularly when arguments contain
spaces.

---

## For Loops

A for loop processes each element in a list one at a time. Everything
between `do` and `done` executes once per element:

```bash
for username in $@
do
  echo "Hello $username!"
done
```

The loop variable can be named anything meaningful. A fixed list works
the same way:

```bash
FILES="/usr/sbin/accept /usr/sbin/pwck /usr/sbin/chroot"
for file in $FILES
do
  ls -lh $file
done
```

---

## The shift Command

`shift` removes the first element from the argument list. After
shifting, `$1` holds what was previously `$2`, and so on:

```bash
./script.sh Carol Dave Henry
# $@ is Carol Dave Henry

shift
# $@ is now Dave Henry
# Carol has been discarded
```

This is useful when the first argument has a special role and you want
to process the remaining arguments separately with a loop.

---

## echo -n

The `-n` flag suppresses the newline that `echo` normally adds at the
end of its output. This allows output to be built across multiple echo
commands on a single line:

```bash
echo -n "Hello $1"
echo -n ", and $name"
echo "!"
# prints: Hello Carol, and Dave!
```

---

## Input Validation with grep

grep returns exit code zero when it finds a match and exit code one
when it does not. This makes it useful for validating user input
inside scripts. Redirecting output to `/dev/null` suppresses the
match text so only the exit code matters:

```bash
echo "Animal" | grep "^[A-Za-z]*$" > /dev/null
echo $?    # 0 — input contains only letters, valid

echo "4n1ml" | grep "^[A-Za-z]*$" > /dev/null
echo $?    # 1 — input contains numbers, invalid
```

The pattern `^[A-Za-z]*$` means: from the start (`^`) to the end
(`$`) of the string, match only uppercase and lowercase letters.
Anything else causes grep to return a non-zero exit code.

---

## Putting It Together

A complete script combining all concepts from this lesson:

```bash
#!/bin/bash
# Greet one or more users -- names must contain letters only.

if [ $# -eq 0 ]
then
  echo "Please enter at least one name to greet."
  exit 1
fi

for username in $@
do
  echo $username | grep "^[A-Za-z]*$" > /dev/null
  if [ $? -eq 1 ]
  then
    echo "ERROR: $username contains invalid characters. Letters only."
    exit 2
  else
    echo "Hello $username!"
  fi
done

exit 0
```
# 📓 Topic 3.3 Lesson 2 — Exit Codes, Loops and Input Validation

**Course:** LPI Linux Essentials (010-160) · **Date:** May 8, 2026 · **Status:** ✅ Complete

## 🚦 Exit Codes

- Every command returns an exit code when it finishes
- `0` = success
- Any non-zero = error of some kind
- Exit code of the last command is stored in `$?`

```bash
cat file.txt          # success
echo $?               # → 0

cat missing.txt       # file not found error
echo $?               # → 1
```

## 🔚 exit in Scripts

```bash
#!/bin/bash
if [ $# -eq 1 ]
then
  echo "Hello $1!"
  exit 0              # success — script ends here
else
  echo "Error: one argument required."
  exit 1              # failure — script ends here
fi
echo "This line is never reached"
```

- `exit 0` = success
- `exit 1` = general error
- `exit 2` = invalid argument (convention)
- `exit` immediately terminates the script — no more lines run
- Use different exit codes for different errors — helps debugging

## 📦 All Arguments — $@ and $*

| Variable     | Contains                                        |
|--------------|-------------------------------------------------|
| `$@`         | All arguments as separate elements (preferred)  |
| `$*`         | All arguments — similar to $@ in most cases     |
| `$#`         | Number of arguments                             |
| `$?`         | Exit code of last command                       |
| `$1, $2...`  | Individual positional arguments                 |

```bash
./script.sh Carol Dave Henry
# $@ = Carol Dave Henry
# $1 = Carol, $2 = Dave, $3 = Henry, $# = 3
```

## 🔁 For Loops

```bash
for username in $@
do
  echo "Hello $username!"
done
```

```bash
# Loop over a fixed list
FILES="/usr/sbin/accept /usr/sbin/pwck /usr/sbin/chroot"
for file in $FILES
do
  ls -lh $file
done
```

- Loop variable can be named anything — `username`, `file`, `i` etc.
- Everything between `do` and `done` runs once per element
- `$@` is like an array — for loop unpacks each element one by one

## ⬅️ shift command

```bash
./script.sh Carol Dave Henry
# Before shift: $@ = Carol Dave Henry
shift
# After shift:  $@ = Dave Henry  (Carol removed)
```

- `shift` removes the first element from the argument array
- `$1` becomes the old `$2`, `$2` becomes old `$3`, etc.
- Useful when you want to process the first argument separately

## 🔇 echo -n

```bash
echo -n "Hello $1"      # prints without newline at end
echo -n ", and $name"   # prints on same line
echo "!"                # prints ! then newline
```

- `-n` suppresses the newline after printing
- Useful for building output across multiple echo commands on one line

## ✅ Input Validation with grep

```bash
# Test if input contains only letters
echo "Animal" | grep "^[A-Za-z]*$" > /dev/null
echo $?    # → 0 (match = valid)

echo "4n1ml" | grep "^[A-Za-z]*$" > /dev/null
echo $?    # → 1 (no match = invalid)
```

- grep returns `0` if pattern matched, `1` if no match
- Redirect to `/dev/null` to suppress grep output — only need exit code
- Check `$?` after grep to make decision in script

## 📋 Full Validation Script Example

```bash
#!/bin/bash
# Greet users — names must contain only letters

if [ $# -eq 0 ]
then
  echo "Please enter at least one user to greet."
  exit 1
else
  for username in $@
  do
    echo $username | grep "^[A-Za-z]*$" > /dev/null
    if [ $? -eq 1 ]
    then
      echo "ERROR: Names must only contain letters."
      exit 2
    else
      echo "Hello $username!"
    fi
  done
  exit 0
fi
```

## ⚙️ Special Variables Complete Reference

| Variable    | Contains                              |
|-------------|---------------------------------------|
| `$1 .. $9`  | Positional arguments                  |
| `$#`        | Number of arguments passed            |
| `$@`        | All arguments as array (preferred)    |
| `$*`        | All arguments as single string        |
| `$?`        | Exit code of last executed command    |
| `$PATH`     | Directories searched for commands     |
| `$PWD`      | Current working directory             |
| `$USER`     | Current username                      |
| `$HOME`     | Home directory of current user        |

## 🔑 Key Takeaways

- Exit code 0 = success, non-zero = error — stored in `$?`
- `exit N` terminates script immediately with exit code N
- Use different exit codes for different errors — aids debugging
- `$@` contains all arguments — use with for loop to process each one
- for loop: `for var in $@; do ... done`
- `shift` removes first element from argument array
- `echo -n` suppresses newline — useful for single-line output
- grep returns exit code 0 for match, 1 for no match — use for input validation
- Redirect grep output to `/dev/null` when you only need its exit code
- Always validate user input before using it in scripts
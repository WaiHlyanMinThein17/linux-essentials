# 📓 Topic 3.2 Lesson 1 — Searching and Extracting Data from Files

**Course:** LPI Linux Essentials (010-160) · **Date:** May 8, 2026 · **Status:** ✅ Complete

## 📡 Standard Channels

| Channel | Name            | Default  | Number |
|---------|-----------------|----------|--------|
| stdin   | Standard Input  | Keyboard | 0      |
| stdout  | Standard Output | Screen   | 1      |
| stderr  | Standard Error  | Screen   | 2      |

## ↪️ I/O Redirection Operators

| Operator | Action                                    | Example                         |
|----------|-------------------------------------------|---------------------------------|
| `>`      | Redirect stdout to file (overwrites)      | `ls -l > output.txt`            |
| `>>`     | Redirect stdout to file (appends)         | `echo "text" >> output.txt`     |
| `2>`     | Redirect stderr to file (overwrites)      | `find / 2> errors.txt`          |
| `2>>`    | Redirect stderr to file (appends)         | `find / 2>> errors.txt`         |
| `<`      | Redirect file to stdin                    | `tr -d "l" < file.txt`          |
| `&>`     | Redirect stdout AND stderr (overwrites)   | `find /usr admin &> all.txt`    |
| `&>>`    | Redirect stdout AND stderr (appends)      | `find /usr admin &>> all.txt`   |
| `<<`     | Here document — inline input to delimiter | `cat << END`                    |

## 📤 Redirecting Standard Output

```bash
echo "Hello World!" > file.txt       # create/overwrite file
echo "More text" >> file.txt         # append to file
ls -l > contents.txt                 # save ls output to file
sort file.txt >> sorted.txt          # append sorted output
```

- `>` creates new file or overwrites existing — be careful!
- `>>` appends — safe, creates file if it doesn't exist

## 🚨 Redirecting Standard Error

```bash
find /usr games 2> errors.txt        # stderr to file, stdout to screen
sort /etc 2>> errors.txt             # append stderr to file
find /usr 2> /dev/null               # discard all errors
find /usr admin &> output.txt        # stdout AND stderr to same file
```

- Channel 2 must be specified explicitly: `2>`
- `/dev/null` = bit bucket — discards anything sent to it
- `&>` = channels 1 + 2 combined to one file

## 📥 Redirecting Standard Input

```bash
cat < file.txt                       # read from file instead of keyboard
tr -d "l" < file.txt                 # tr reads from file
wc -w < contents.txt >> output.txt   # combine input and output redirection
```

- Used with commands that don't accept filename arguments
- `tr` is a common example — it only reads from stdin

## 📜 Here Documents (<<)

```bash
cat << END
line one
line two
END
```

- Sends a block of text as input to a command
- Word after `<<` is the delimiter — not included in output
- Input ends when the delimiter word appears alone on a line
- Commonly used in shell scripts

## 🔗 Pipes — Command Chaining

```bash
cat /etc/passwd | less                              # page through passwd
ls -l | head | wc -w                               # count words in first 10 lines
find /usr/share -name test | wc -l                 # count files named test
sort contents.txt | tr -s " "                      # sort then squeeze spaces
cat file | tr -s " " | cut -f 9 -d " " | sort -fr # 3 pipes chained
```

- `|` = pipe operator — output of left becomes input of right
- Commands in the middle of a pipe are called **filters**
- Multiple pipes can be chained in one command line

## 🔧 Useful Commands for Pipes

| Command | Purpose                               | Common options                    |
|---------|---------------------------------------|-----------------------------------|
| `cat`   | Display or concatenate files          | —                                 |
| `less`  | Page through output — scroll up/down  | —                                 |
| `more`  | Page through output — one page at a time | —                              |
| `head`  | Show first N lines (default 10)       | `-n 5`                            |
| `tail`  | Show last N lines (default 10)        | `-n 5`, `-f` (follow live)        |
| `sort`  | Sort lines alphabetically             | `-r` reverse, `-f` ignore case    |
| `wc`    | Count lines, words, or bytes          | `-l` lines, `-w` words, `-c` bytes|
| `cut`   | Extract fields from each line         | `-f 3 -d "/"`                     |
| `tr`    | Translate or delete characters        | `-d` delete, `-s` squeeze         |

## 📋 Practical Examples

```bash
# Save directory listing to file
ls -l > contents.txt

# Sort file and append to another
sort contents.txt >> contents-sorted.txt

# Show last 10 lines of passwd and save
tail /etc/passwd > Documents/newfile

# Count words using input + output redirection
wc -w < contents.txt >> wordcount.txt

# First 5 lines of passwd sorted in reverse
head -n 5 /etc/passwd | sort -r

# Count characters in last 9 lines
tail -n 9 contents.txt | wc -c

# Count files named test in /usr/share
find /usr/share -name test | wc -l

# Monitor live log file
tail -f /var/log/syslog
```

## 🔑 Key Takeaways

- Three standard channels: stdin (0), stdout (1), stderr (2)
- `>` overwrites, `>>` appends — always know which you're using
- `2>` redirects errors only, `&>` redirects both stdout and stderr
- `/dev/null` discards output — useful to silence errors
- `|` pipes output of one command to input of another
- Filters are commands that transform data in a pipeline
- `tail -f` monitors live file changes — useful for log watching
- `wc -l` counts lines, `wc -w` counts words, `wc -c` counts bytes
- `cut -f N -d "delimiter"` extracts the Nth field
- `tr -d "char"` deletes character, `tr -s " "` squeezes spaces
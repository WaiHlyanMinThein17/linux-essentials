# 📓 Topic 3.2 Lesson 2 — grep and Regular Expressions

**Course:** LPI Linux Essentials (010-160) · **Date:** May 8, 2026 · **Status:** ✅ Complete

## 🔍 grep — Global Regular Expression Print

- Searches files for lines matching a specified pattern
- Outputs matching lines — match highlighted in red
- One of the most used commands by Linux system administrators

```bash
grep bash /etc/passwd           # find lines containing "bash"
grep "pattern" file.txt         # search for pattern in file
grep "pattern" /dir/            # search in a directory (use -r)
```

## ⚙️ grep Options

| Option | Description                                    | Example                      |
|--------|------------------------------------------------|------------------------------|
| `-i`   | Case insensitive search                        | `grep -i "bash" file`        |
| `-r`   | Recursive — search all files in directory      | `grep -r "error" /var/log/`  |
| `-c`   | Count number of matching lines                 | `grep -c "root" /etc/passwd` |
| `-v`   | Invert — show lines that do NOT match          | `grep -v "bash" /etc/passwd` |
| `-E`   | Extended regex — enables +, ?, | metacharacters| `grep -E "cat|dog" file`     |

## 📐 Regular Expression Metacharacters

### Character Matching

| Pattern  | Matches                            | Example                          |
|----------|------------------------------------|----------------------------------|
| `.`      | Any single character (not newline) | `grep "a.b"` → aab, axb, a1b     |
| `[abc]`  | Any one character from the set     | `[ab]` → a or b                  |
| `[^abc]` | Any one character NOT in the set   | `[^ab]` → anything except a or b |
| `[a-z]`  | Any character in the range         | `[a-z]` → any lowercase letter   |
| `[^a-z]` | Any character NOT in the range     | `[^a-z]` → not lowercase         |

### Anchors

| Pattern | Matches         | Example                                   |
|---------|-----------------|-------------------------------------------|
| `^`     | Start of a line | `grep "^root"` → lines starting with root |
| `$`     | End of a line   | `grep "bash$"` → lines ending with bash   |

### Multipliers (require -E for + and ?)

| Pattern | Matches                   | Example                  |
|---------|---------------------------|--------------------------|
| `*`     | Zero or more of preceding | `ab*` → a, ab, abb, abbb |
| `+`     | One or more of preceding  | `ab+` → ab, abb (not a)  |
| `?`     | Zero or one of preceding  | `ab?` → a or ab only     |

### Alternation

| Pattern    | Matches                      | Example                  |
|------------|------------------------------|--------------------------|
| `sun|moon` | Either of the listed strings | `grep -E "org|kay|tuna"` |

## 📋 grep + Regex Examples

```bash
grep "bash" /etc/passwd               # exact string match
grep "[ab]" text.txt                  # lines containing a or b
grep "^a" text.txt                    # lines starting with a
grep "2$" text.txt                    # lines ending with 2
grep -E "ab.+" text.txt               # ab followed by one or more chars
grep -E "e+$" file                    # lines ending with one or more e
grep -E "org|kay|tuna" file           # lines containing org, kay or tuna
grep -cE "^c?ati" file                # count lines starting with optional c then ati
grep -v "[sawgtfixk]" file            # lines NOT containing those chars
grep "^...dig" file                   # 3 any chars then "dig" at line start
grep -r "error" /var/log/             # search recursively in directory
cat contents.txt | grep "^....rwx"    # grep output from another command
```

## 🧩 Regex Pattern Building Guide

| Goal                              | Pattern        |
|-----------------------------------|----------------|
| Lines starting with "root"        | `^root`        |
| Lines ending with "bash"          | `bash$`        |
| Lines ending with e (one or more) | `-E "e+$"`     |
| Any 3 characters then "dig"       | `^...dig`      |
| Optional "c" then "ati"           | `-E "^c?ati"`  |
| Lines NOT containing chars        | `-v "[chars]"` |
| Match "pot" at end of line        | `pot$`         |
| Uppercase start, a, any chars, i  | `^[A-Z]a.*i+`  |

## ⚠️ Important Notes

- Always use double quotes around patterns to prevent shell interpretation
- `+`, `?`, and `|` are extended regex — require `grep -E`
- `^` inside `[]` means NOT — outside `[]` means start of line
- Every character in a pattern counts — be precise
- grep can receive input from pipes: `cat file | grep "pattern"`

## 🔑 Key Takeaways

- grep = global regular expression print — searches files for patterns
- -i = case insensitive, -r = recursive, -c = count, -v = invert, -E = extended regex
- `.` = any single char, `[abc]` = one of set, `[^abc]` = not in set
- `^` = start of line, `$` = end of line
- `*` = zero or more, `+` = one or more (needs -E), `?` = zero or one (needs -E)
- `|` = OR — match either string (needs -E)
- sed is another useful command for find and replace within files
- Always quote complex patterns with double quotes
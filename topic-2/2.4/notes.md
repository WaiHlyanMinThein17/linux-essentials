# 📓 Topic 2.4 — Creating, Moving and Deleting Files

**Course:** LPI Linux Essentials (010-160) · **Date:** May 7, 2026 · **Status:** ✅ Complete

## ⚠️ Case Sensitivity

- Linux filenames and directories are **case sensitive** — unlike Windows
- `/etc` and `/ETC` are completely different directories
- Always be precise with capitalisation when typing paths

## 📁 Creating Directories — mkdir

```bash
mkdir documents                       # create single directory
mkdir dir1 dir2 dir3                  # create multiple at once
mkdir -p copying/files copying/dirs   # create parents automatically
mkdir -p topic-2/2.1 topic-2/2.2     # create nested structure
```

| Option | Description                             |
|--------|-----------------------------------------|
| `-p`   | Create parent directories automatically |
| `-v`   | Verbose — show what is being created    |

- Without `-p`: fails if parent directory doesn't exist
- With `-p`: creates the full path including all missing parents

## 📄 Creating Files

```bash
touch file1                    # create empty file
touch file1 file2 file3        # create multiple empty files
touch existing_file            # updates modification timestamp only
echo hello > file.txt          # create file with content "hello"
echo "more text" >> file.txt   # APPEND to file (>> not >)
cat file.txt                   # view file contents
```

- `touch` on existing file → updates timestamp, content unchanged
- `>` redirects output to file — **overwrites** if file exists ⚠️
- `>>` appends to file — safe, does not overwrite
- `cat` displays file contents — empty file = no output

## ✏️ Renaming and Moving — mv

```bash
mv oldname newname             # rename a file
mv file22 file2                # rename file22 to file2
mv file1 dir1/                 # move file1 into dir1
mv file2 file3 dir2/           # move multiple files into dir2
mv dir1 dir3                   # rename a directory
mv -i file4 file3              # prompt before overwriting
mv -n file4 file3              # never overwrite existing file
```

| Option | Description                              |
|--------|------------------------------------------|
| `-i`   | Interactive — prompt before overwriting  |
| `-n`   | No-clobber — never overwrite destination |
| `-v`   | Verbose — show what is being moved       |

- ⚠️ mv **silently overwrites** destination if it exists — use `-i` for safety
- When last argument is a directory → files are moved INTO it
- mv works on both files and directories

## 🗑️ Deleting Files and Directories — rm / rmdir

```bash
rm file1                       # delete a regular file
rm file1 file2 file3           # delete multiple files
rm -i file1                    # prompt before deleting
rm -r directory/               # delete directory and ALL contents ⚠️
rm -ri directory/              # prompt for each file before deleting
rm old*                        # delete all files starting with "old"
rmdir empty_dir                # delete empty directory only
rmdir -p a/b/c                 # delete empty directory chain
```

| Command     | What it deletes          | Non-empty dirs? |
|-------------|--------------------------|-----------------|
| `rm file`   | Regular files only       | N/A             |
| `rmdir dir` | Empty directories only   | ❌ Refuses       |
| `rm -r dir` | Directory + ALL contents | ✅ Yes ⚠️        |

- ⚠️ `rm -r` is permanent — no recycle bin, no undo
- Always use `rm -ri` when unsure — prompts before each deletion
- `-v` flag shows what is being removed (verbose)

## 📋 Copying Files and Directories — cp

```bash
cp file1 file2                 # copy file1 to file2
cp file1 file2 directory/      # copy multiple files into directory
cp -r source/ destination/     # copy directory recursively
cp -p file1 file2              # preserve permissions and timestamps
cp -u file1 file2              # copy only if source is newer
cp -i file1 file2              # prompt before overwriting
```

| Option | Description                                    |
|--------|------------------------------------------------|
| `-r`   | Recursive — copy directories and all contents  |
| `-p`   | Preserve permissions, ownership and timestamps |
| `-u`   | Copy only if source is newer than destination  |
| `-i`   | Interactive — prompt before overwriting        |
| `-v`   | Verbose — show what is being copied            |

- Without `-r`: cp refuses to copy directories
- If destination directory exists: copy is placed INSIDE it
- If destination directory doesn't exist: it is created with source contents
- ⚠️ cp silently overwrites destination files — use `-i` for safety

## 🌟 Globbing — Pattern Matching

Globbing lets you match multiple files using patterns instead of typing each name.

| Character | Matches                                   | Example                              |
|-----------|-------------------------------------------|--------------------------------------|
| `*`       | Any number of any characters (incl. zero) | `star*` → star10, star1100, star2002 |
| `?`       | Exactly ONE single character              | `question?` → question1 only         |
| `[abc]`   | Any one character from the set            | `file[1a5]` → file1, filea, file5    |
| `[1-3]`   | Any one character in the range            | `file[1-3]` → file1, file2, file3    |
| `[^a]`    | Any one character NOT in the set          | `file[^a]` → all except filea        |

## 🔤 Glob Examples

```bash
ls star*           # star10, star1100, star2002, star2013
ls star1*          # star10, star1100 (start with star1)
ls question?       # question1 (exactly one char after question)
ls question1?      # question13, question14, question15
ls file[1-3]       # file1, file2, file3
ls file[1-25-7]    # file1, file2, file5, file6, file7
ls file[^a]        # all except filea
rm old*            # delete all files starting with "old"
```

## 🔡 Character Classes in Globs

| Class       | Matches                    |
|-------------|----------------------------|
| `[:digit:]` | Numbers 0-9                |
| `[:alpha:]` | Upper or lowercase letters |
| `[:alnum:]` | Letters and numbers        |
| `[:lower:]` | Lowercase letters a-z      |
| `[:upper:]` | Uppercase letters A-Z      |
| `[:space:]` | Whitespace                 |

```bash
ls file[[:digit:]]    # file1, file2... (ending in a digit)
ls file[[:alpha:]]    # filea, fileb... (ending in a letter)
```

## 📋 Complete Command Reference

| Command             | Purpose                                   |
|---------------------|-------------------------------------------|
| `mkdir dir`         | Create directory                          |
| `mkdir -p a/b/c`    | Create directory with all parents         |
| `touch file`        | Create empty file or update timestamp     |
| `echo text > file`  | Write text to file (overwrites)           |
| `echo text >> file` | Append text to file                       |
| `cat file`          | Display file contents                     |
| `mv old new`        | Rename or move file/directory             |
| `cp src dst`        | Copy file                                 |
| `cp -r src dst`     | Copy directory recursively                |
| `rm file`           | Delete file                               |
| `rm -r dir`         | Delete directory and all contents         |
| `rmdir dir`         | Delete empty directory                    |
| `find`              | List all files/dirs from current location |

## 🔑 Key Takeaways

- Linux is case sensitive — /etc and /ETC are different directories
- mkdir -p creates full directory paths including missing parents
- touch creates empty files or updates timestamps on existing ones
- \> overwrites, >> appends — be careful with >
- mv silently overwrites destination — use -i for safety
- rm -r permanently deletes directories and all contents — no undo!
- rmdir only deletes EMPTY directories
- cp -r required to copy directories
- Use -i flag with mv, cp, rm to prompt before overwriting/deleting
- \* = any characters, ? = one character, [] = character class/range
# 📓 Topic 3.1 — Archiving Files on the Command Line

**Course:** LPI Linux Essentials (010-160) · **Date:** May 8, 2026 · **Status:** ✅ Complete

## 📦 Compression vs Archiving

| Concept        | Purpose                          | Tools             |
|----------------|----------------------------------|-------------------|
| Compression    | Reduce file size — single file   | gzip, bzip2, xz   |
| Archiving      | Bundle multiple files into one   | tar               |
| Both together  | Bundle + reduce size             | tar + gzip/bzip2/xz, zip |

## 🔁 Lossless vs Lossy Compression

| Type     | Original recoverable? | Use case              | Examples        |
|----------|-----------------------|-----------------------|-----------------|
| Lossless | ✅ Yes — perfectly    | Code, documents, data | gzip, bzip2, xz |
| Lossy    | ❌ No — data lost     | Images, video, audio  | JPEG, MP3, AAC  |

- All Linux compression tools (gzip, bzip2, xz) are **lossless**
- Original file is **deleted** after compression — compressed file takes its place
- Compressed file is **deleted** after decompression — original restored

## 🗜️ Compression Tools Comparison

| Tool  | Extension | Compress       | Decompress          | Read without decompressing|
|-------|-----------|----------------|---------------------|---------------------------|
| gzip  | .gz       | `gzip file`    | `gunzip file.gz`    | `zcat file.gz`            |
| bzip2 | .bz2      | `bzip2 file`   | `bunzip2 file.bz2`  | `bzcat file.bz2`          |
| xz    | .xz       | `xz file`      | `unxz file.xz`      | `xzcat file.xz`           |

## 📊 Compression Comparison (712K original)

| Tool  | Compressed size | Speed    | Ratio |
|-------|-----------------|----------|-------|
| gzip  | 179K            | Fastest  | Good  |
| bzip2 | 170K            | Medium   | Better|
| xz    | 144K            | Slowest  | Best  |

## 🎚️ Compression Levels

```bash
gzip -1 file    # fastest, larger output
gzip -9 file    # slowest, smallest output
xz -1 file      # fastest xz
xz -9 file      # best xz compression
zip -0 file     # no compression (store only)
zip -9 file     # maximum zip compression
```

- Higher number = smaller file but slower and more CPU
- Default level is usually 6
- Not all tools support different compression levels

## 📼 tar — Archiving Tool

tar = **tape archive** · files created are called **tarballs**

## 🔑 Core tar Options (memorize these)

| Option | Action                           | Example                       |
|--------|----------------------------------|-------------------------------|
| `c`    | Create new archive               | `tar cf archive.tar dir/`     |
| `x`    | Extract archive                  | `tar xf archive.tar`          |
| `t`    | List contents (table of contents)| `tar tf archive.tar`          |
| `u`    | Add/update files in archive      | `tar uf archive.tar newfile`  |
| `f`    | Specify filename (always needed) | `tar cf archive.tar`          |
| `v`    | Verbose — show files processed   | `tar cvf archive.tar dir/`    |
| `P`    | Preserve absolute paths          | `tar cPf archive.tar /etc/`   |

## 🗜️ tar Compression Flags

| Flag | Algorithm | Extension          | Example                        |
|------|-----------|--------------------|--------------------------------|
| `z`  | gzip      | .tar.gz or .tgz    | `tar czf archive.tar.gz dir/`  |
| `j`  | bzip2     | .tar.bz2           | `tar cjf archive.tar.bz2 dir/` |
| `J`  | xz        | .tar.xz            | `tar cJf archive.tar.xz dir/`  |

## 📋 Common tar Commands

```bash
tar cf archive.tar dir/             # create archive
tar tf archive.tar                  # list contents
tar xf archive.tar                  # extract all
tar xf archive.tar specific/file    # extract one file
tar xvf archive.tar                 # extract with verbose
tar czf archive.tar.gz dir/         # create gzip compressed archive
tar cjf archive.tar.bz2 dir/        # create bzip2 compressed archive
tar cJf archive.tar.xz dir/         # create xz compressed archive
tar xzf archive.tar.gz              # extract gzip compressed archive
tar uf archive.tar newfile          # add file to existing archive
```

## ⚠️ tar Important Notes

- The `-` before options is optional in tar (unlike most commands)
- tar preserves full directory structure inside archive
- Cannot add files to compressed archives (u only works on .tar)
- Extracting overwrites existing files without warning
- Always add second extension to show compression: .tar.gz, .tar.bz2, .tar.xz

## 🪟 ZIP Files (Windows compatibility)

```bash
zip -r zipfile.zip directory/       # create zip (recursive)
zip -9 -r zipfile.zip directory/    # max compression
unzip zipfile.zip                   # extract zip
unzip zipfile.zip -d /target/       # extract to specific directory
```

- zip and unzip may not be installed — use `apt install zip`
- Use when sharing files with Windows users
- -r required to include directory contents

## 📁 File Extension Reference

| Extension       | Archive? | Compressed? | Tool         |
|-----------------|----------|-------------|--------------|
| .tar            | ✅ Yes   | ❌ No       | tar          |
| .gz             | ❌ No    | ✅ Yes      | gzip         |
| .bz2            | ❌ No    | ✅ Yes      | bzip2        |
| .xz             | ❌ No    | ✅ Yes      | xz           |
| .tar.gz / .tgz  | ✅ Yes   | ✅ Yes      | tar + gzip   |
| .tar.bz2        | ✅ Yes   | ✅ Yes      | tar + bzip2  |
| .tar.xz         | ✅ Yes   | ✅ Yes      | tar + xz     |
| .zip            | ✅ Yes   | ✅ Yes      | zip          |

## 🔑 Key Takeaways

- Compression reduces size — archiving bundles files — often used together
- gzip, bzip2, xz are all lossless — originals deleted after compression
- xz = best compression, gzip = fastest, bzip2 = middle ground
- tar core options: c=create, x=extract, t=list, u=update, f=filename, v=verbose
- tar compression flags: z=gzip, j=bzip2, J=xz
- Cannot update compressed tar archives — decompress first
- Use zip/unzip for Windows compatibility
- zcat/bzcat/xzcat read compressed files without decompressing to disk
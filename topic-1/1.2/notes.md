# 📓 Topic 1.2 — Linux Applications and Tools

**Course:** LPI Linux Essentials (010-160) · **Date:** May 5, 2026 · **Status:** ✅ Complete

## 📦 Package Management

### Debian/Ubuntu (DEB packages)
| Command          | Purpose                                          |
|------------------|--------------------------------------------------|
| dpkg             | Low-level package management                     |
| apt-get          | High-level package management (older)            |
| apt              | High-level package management (newer, preferred) |
| apt-cache search | Search for packages                              |
| apt install      | Install a package                                |
| apt remove       | Remove package (keeps config files)              |
| apt purge        | Remove package AND config files                  |

### Red Hat/Fedora/CentOS (RPM packages)
| Command | Purpose                               |
|---------|---------------------------------------|
| rpm     | Low-level package management          |
| yum     | High-level package management (older) |
| dnf     | High-level package management (newer) |

### Dependencies
- A dependency is an auxiliary package needed by a program to function
- apt automatically downloads and installs all required dependencies

## 🏢 Office Applications
- **LibreOffice** — preferred by most distros (LGPLv3 license)
- **Apache OpenOffice** — same codebase (Apache License 2.0)
- LibreOffice can incorporate OpenOffice improvements but NOT vice versa

### LibreOffice Applications
| App     | Purpose                         |
|---------|---------------------------------|
| Writer  | Text documents (like Word)      |
| Calc    | Spreadsheets (like Excel)       |
| Impress | Presentations (like PowerPoint) |
| Draw    | Vector drawing                  |
| Math    | Math formulas                   |
| Base    | Database                        |

- Native format: **ODP/ODF** (Open Document Format — ISO standard)
- Compatible with Microsoft Office formats

## 🌐 Web Browsers
- **Firefox** — maintained by Mozilla (non-profit)
- **Chromium** — open source base for Google Chrome
- **Thunderbird** — Mozilla email client

## 🎬 Multimedia
| App         | Purpose                                             |
|-------------|-----------------------------------------------------|
| Blender     | 3D rendering and animation                          |
| GIMP        | Bitmap image editor (like Photoshop)                |
| Inkscape    | Vector graphics editor (like Illustrator), uses SVG |
| Audacity    | Audio editor                                        |
| ImageMagick | Command-line image conversion tool                  |
| VLC         | Video playback                                      |

## 🖥️ Server Programs
- **Apache, Nginx, lighttpd** — HTTP servers
- **MariaDB, PostgreSQL** — open source relational databases
- **LAMP** = Linux + Apache + MySQL/MariaDB + PHP
- **NFS** — file sharing between Linux machines
- **Samba** — file sharing between Linux AND Windows machines

## 🌐 Network Administration
| Protocol | Purpose                                       |
|----------|-----------------------------------------------|
| DHCP     | Automatically assigns IP addresses to devices |
| DNS      | Translates domain names to IP addresses       |

## 💻 Programming Languages
| Language   | Type                       | Use case                            |
|------------|----------------------------|-------------------------------------|
| C          | Compiled                   | Systems programming, OS development |
| Java       | Compiled (to bytecode/JVM) | Portable applications               |
| Python     | Interpreted                | General purpose, easy to learn      |
| JavaScript | Interpreted                | Web browser scripting               |
| PHP        | Interpreted                | Server-side web scripting           |
| Perl       | Interpreted                | Text processing, regex              |
| Shell/Bash | Interpreted                | Command line automation             |

## 🔑 Key Takeaways
- Debian = apt/dpkg, Red Hat = yum/dnf/rpm
- apt purge removes config files too; apt remove does not
- LibreOffice Impress = presentations, Calc = spreadsheets, Writer = documents
- Chrome is based on Chromium (open source)
- GIMP = Photoshop equivalent, Inkscape = Illustrator equivalent
- Samba = Linux + Windows file sharing
- DHCP assigns IPs, DNS translates domain names
- C and Java are compiled; Python, PHP, JS, Perl, Bash are interpreted
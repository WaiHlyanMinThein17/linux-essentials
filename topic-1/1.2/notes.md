# Topic 1.2 — Major Open Source Applications

**Date:** 2026-05-05  
**Status:** Complete

---

## Package Management

Linux distributions handle software installation through package managers.
The two dominant families use different package formats and tools.

Debian-based distributions use `.deb` packages. The low-level tool is
`dpkg`, but in practice most work is done through `apt`, which handles
dependency resolution automatically. `apt install` adds a package, `apt
remove` removes it but keeps configuration files, and `apt purge` removes
both the package and its configuration files.

Red Hat-based distributions use `.rpm` packages managed by `rpm` at the
low level. The higher-level tools are `yum` on older systems and `dnf` on
newer ones. Both handle dependencies the same way `apt` does on the
Debian side.

A dependency is an auxiliary package that a program requires in order
to function. High-level package managers resolve and install dependencies
automatically, which is one of the main reasons they are preferred over
the lower-level tools.

---

## Office and Productivity

LibreOffice is the standard office suite on most Linux distributions,
released under the LGPLv3 license. Its applications map closely to the
Microsoft Office equivalents: Writer for documents, Calc for spreadsheets,
Impress for presentations, Draw for vector graphics, Math for formulas,
and Base for databases. LibreOffice saves in the Open Document Format
(ODF), an ISO standard, though it can also read and write Microsoft
Office formats.

Apache OpenOffice shares the same original codebase as LibreOffice but
is released under the Apache License 2.0. The key practical difference
is that LibreOffice can incorporate improvements from OpenOffice, but
the reverse is not possible due to license incompatibility.

---

## Web and Multimedia

Firefox is the primary open source web browser on Linux, maintained by
the Mozilla Foundation. Chromium is the open source project that forms
the basis of Google Chrome. Thunderbird, also from Mozilla, is the
standard open source email client.

For creative work, GIMP is the bitmap image editor equivalent to
Photoshop, and Inkscape is the vector graphics editor equivalent to
Illustrator. It uses SVG as its native format. Blender handles 3D
modelling, rendering, and animation. Audacity covers audio editing.
For format conversion from the command line, ImageMagick processes
images and VLC handles video playback.

---

## Server Software

The most common HTTP servers on Linux are Apache, Nginx, and lighttpd.
For databases, MariaDB and PostgreSQL are the dominant open source
relational databases. The LAMP stack, Linux, Apache, MySQL or MariaDB,
and PHP, remains a widely deployed combination for web applications.

File sharing between Linux machines is handled by NFS. Samba extends
this to Windows machines, allowing Linux and Windows systems to share
files and printers across the same network.

---

## Networking Services

DHCP automatically assigns IP addresses to devices joining a network,
eliminating the need for manual configuration. DNS translates human-readable
domain names into IP addresses. Both are fundamental infrastructure
services that a Linux administrator is expected to understand.

---

## Programming Languages

The languages most relevant to Linux administration and development
fall into two categories. Compiled languages such as C and Java are
converted to machine code or bytecode before execution, which makes
them faster at runtime. Interpreted languages such as Python, PHP,
JavaScript, Perl, and Bash are executed line by line at runtime,
which makes them slower but easier to develop and debug quickly.
Shell scripting in Bash is a daily tool for any Linux administrator.
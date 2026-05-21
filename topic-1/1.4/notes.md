# Topic 1.4 — ICT Skills and Working in Linux

**Date:** 2026-05-06  
**Status:** Complete

---

## The Command Line Interface

The command line interface (CLI) is the primary way of interacting with
a Linux system, particularly in server and administrative contexts. Unlike
a graphical interface, the CLI accepts typed commands and returns text
output. This makes it well suited to automation, remote access, and
working on systems with no graphical environment installed.

The shell is the program that reads your commands and passes them to the
operating system. Bash (Bourne Again Shell) is the default shell on most
Linux distributions. Other shells exist, including Zsh, Fish, and the
original Bourne Shell (sh), but Bash is what you will encounter in the
vast majority of real environments.

A terminal emulator is the application that provides a window for the
shell to run inside. On a desktop system this might be GNOME Terminal
or Konsole. On a headless server you connect directly to a virtual
console or over SSH.

---

## Files and the Filesystem

Linux organizes everything as files. Configuration, hardware devices,
running processes, and network sockets all appear as files somewhere
in the filesystem. This consistency is one of the defining properties
of Unix-like systems.

The filesystem starts at the root directory, written as `/`. Everything
else is mounted below it. This is different from Windows, which assigns
a separate letter to each drive. On Linux, an additional drive is mounted
at a path like `/mnt/data` and appears as a directory, not a separate
letter.

Files whose names begin with a dot are hidden. They will not appear in
a standard directory listing but can be revealed with `ls -a`. This
convention is used for configuration files in home directories, such
as `.bashrc` and `.bash_profile`.

---

## Working Remotely with SSH

SSH (Secure Shell) is the standard protocol for connecting to a remote
Linux system securely over a network. It encrypts all traffic between
the client and the server. The basic command is:

```bash
ssh username@hostname
```

SSH can also transfer files using `scp` for simple copies and `sftp`
for an interactive session. Key-based authentication, where a
cryptographic key pair replaces a password, is preferred in production
environments because it is both more secure and more convenient for
automation.

---

## Privacy, Encryption, and Security Basics

Encryption converts readable data into an unreadable form that can only
be reversed with the correct key. It is used to protect data in transit
(such as HTTPS and SSH) and data at rest (such as encrypted disk
partitions).

Hashing is a related but distinct concept. A hash function converts
input data into a fixed-length string. Unlike encryption, hashing is
a one-way process: you cannot recover the original input from the hash.
Linux uses hashing to store passwords in `/etc/shadow`. The stored hash
is compared against a hash of the entered password at login time, so
the original password is never stored anywhere on the system.

Privacy on a shared system comes primarily from the permission system.
Files are owned by a user and a group, and access for owner, group, and
others is controlled separately. This prevents users from reading each
other's files without explicit permission.

---

## Industry Terminology

A few terms appear repeatedly in Linux and open source contexts and are
worth understanding precisely.

A server is a machine or process that provides a service to other
machines, called clients. The client-server model describes most network
communication, including web browsing, email, and database access.

A daemon is a background process that runs continuously without direct
user interaction. Web servers, database servers, and SSH all run as
daemons. By convention, daemon names often end in the letter d, such
as `sshd`, `httpd`, and `systemd`.

Virtualization allows multiple operating systems to run simultaneously
on a single physical machine. Each runs in a virtual machine (VM)
managed by a hypervisor. Containerization is a lighter alternative
where applications share the host OS kernel but are isolated from each
other. Docker and Podman are common container tools. Both virtualization
and containerization are fundamental to modern cloud infrastructure.
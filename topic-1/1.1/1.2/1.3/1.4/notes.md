# 📓 Topic 1.4 — ICT Skills and Working in Linux

**Course:** LPI Linux Essentials (010-160) · **Date:** May 5, 2026 · **Status:** ✅ Complete

## 🖥️ Desktop Environments
| Environment | Toolkit           | Philosophy                       |
|-------------|-------------------|----------------------------------|
| GNOME       | GTK (C language)  | KISS — Keep It Simple Stupid     |
| KDE         | Qt (C++ language) | Maximum customization, more apps |

- GNOME terminal = **GNOME Terminal**
- KDE terminal = **Konsole**
- Virtual TTY = non-graphical terminal, accessed with **Ctrl+Alt+F1-F7**

## ☁️ Cloud Computing Models
| Model | Full Name                   | What you get                              | Example             |
|-------|-----------------------------|-------------------------------------------|---------------------|
| IaaS  | Infrastructure as a Service | Virtual machines — you manage the OS      | AWS EC2             |
| PaaS  | Platform as a Service       | Platform to deploy apps, no OS management | Heroku              |
| SaaS  | Software as a Service       | Ready-to-use software via subscription    | Dropbox, Salesforce |

## 🖥️ Hypervisors (Virtualization)
| Hypervisor | Notes                                                                    |
|------------|--------------------------------------------------------------------------|
| KVM        | Most prominent Linux hypervisor, sponsored by Red Hat, built into kernel |
| Xen        | Oldest Linux hypervisor                                                  |
| VirtualBox | Oracle-owned, easiest for end users                                      |

- **OpenStack** — collection of open source software for building private IaaS cloud environments

## 🔏 Privacy
### Cookie Tracking
- Cookies = small files websites save on your computer to track you
- Ad networks use third-party cookies to track you across websites
- Solution: block third-party cookies or use a cookie manager

### Do Not Track (DNT)
- Sends HTTP header flag (DNT: 1) requesting websites not to track you
- NOT guaranteed — websites can ignore it
- Just a polite request, not technical protection

### Private/Incognito Mode
- Protects: leaves no trace on LOCAL computer (deletes history, cookies, passwords on close)
- Does NOT protect: online anonymity — websites and ISPs can still track you
- Best used on public computers

## 🔑 Passwords
- Never reuse passwords — credential stuffing attacks
- Use a password manager

| Manager   | Storage              | Notes                                 |
|-----------|----------------------|---------------------------------------|
| KeePass   | Local encrypted file | More control, open source             |
| Bitwarden | Cloud server         | Easy sync, can self-host, open source |

## 🔐 Encryption
### TLS (Transport Layer Security)
- Encrypts network connections
- Used in **HTTPS** protocol
- Look for padlock in browser = TLS is active
- Successor to SSL (deprecated)

### GnuPG (GNU Privacy Guard)
- Signs, encrypts and decrypts files, emails and directories
- Uses public-key cryptography
- Public key = share with everyone
- Private key = keep secret

### Disk Encryption
| Tool      | Method                        | Notes                                                                      |
|-----------|-------------------------------|----------------------------------------------------------------------------|
| dm-crypt  | Block device encryption       | Everything encrypted below filesystem, de-facto Linux standard, needs root |
| EncFS     | Stacked filesystem encryption | Files encrypted on top of existing filesystem, no root needed              |
| VeraCrypt | Block encryption              | Cross-platform (Linux, macOS, Windows)                                     |

## 🎯 Presentation Tools
| Tool                | Type               | Notes                               |
|---------------------|--------------------|-------------------------------------|
| LibreOffice Impress | GUI                | Default, compatible with PowerPoint |
| Beamer              | Code (LaTeX)       | For scientific/math presentations   |
| Reveal.js           | Code (HTML/CSS/JS) | Beautiful web-based presentations   |

## 🔑 Key Takeaways
- GNOME = GTK = simple; KDE = Qt = customizable
- Virtual TTY = Ctrl+Alt+F1-F7
- IaaS = VMs, PaaS = platform, SaaS = software subscription
- KVM = most prominent Linux hypervisor (Red Hat)
- OpenStack = private IaaS cloud platform
- Private mode = local privacy only, NOT online anonymity
- DNT = unreliable, just a request
- dm-crypt = block encryption (everything), EncFS = file encryption (stacked)
- TLS = network encryption (HTTPS), GnuPG = file/email encryption
- Use a password manager — never reuse passwords
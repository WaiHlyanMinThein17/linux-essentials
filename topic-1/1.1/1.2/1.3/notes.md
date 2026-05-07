# 📓 Topic 1.3 — Open Source Software and Licensing

**Course:** LPI Linux Essentials (010-160) · **Date:** May 5, 2026 · **Status:** ✅ Complete

## 🕊️ Free Software — The Four Freedoms
Richard Stallman's definition — "free as in free speech, not free beer"

| Freedom   | Description                                  |
|-----------|----------------------------------------------|
| Freedom 0 | Run the program as you wish, for any purpose |
| Freedom 1 | Study and modify the source code             |
| Freedom 2 | Redistribute copies to help others           |
| Freedom 3 | Distribute modified versions to others       |

- Freedoms 1 and 3 both require access to the source code
- Software without these freedoms = **proprietary software**

## 📖 Free Software vs Open Source
|              | Free Software                            | Open Source                             |
|--------------|------------------------------------------|-----------------------------------------|
| Focus        | Social/political movement — user freedom | Pragmatic/technical — visible code      |
| Founded by   | Richard Stallman (GNU Project, 1985)     | Eric Raymond & Bruce Perens (OSI, 1998) |
| Abbreviation | FOSS or FLOSS                            | OSS                                     |

- **FOSS** = Free and Open Source Software
- **FLOSS** = Free/Libre and Open Source Software (adds "Libre" to clarify freedom, not price)

## 📜 Licenses

### Copyleft Licenses
- Require modified versions to be distributed under the same free license
- Called "viral" — the license spreads to all derivatives
- Examples:
  - **GNU GPL** (General Public License) — used by Linux kernel
  - **GNU LGPL** (Lesser GPL) — allows linking with non-free components
  - **GNU AGPL** (Affero GPL) — covers hosted/cloud software
  - **CC BY-SA** — Creative Commons ShareAlike

### Permissive Licenses
- Allow modified versions to be released under ANY license including proprietary
- Maximum freedom for users of the code
- Examples:
  - **2-Clause BSD License** (Simplified BSD / FreeBSD License)
  - **MIT License**
  - **Apache License 2.0**
  - **CC BY** — Creative Commons Attribution only

## 🎨 Creative Commons Licenses
| License     | Permissions                                                    |
|-------------|----------------------------------------------------------------|
| CC BY       | Attribution only — most permissive                             |
| CC BY-SA    | Attribution + ShareAlike (copyleft-like)                       |
| CC BY-ND    | Attribution + No Derivatives                                   |
| CC BY-NC    | Attribution + NonCommercial                                    |
| CC BY-NC-SA | Attribution + NonCommercial + ShareAlike                       |
| CC BY-NC-ND | Attribution + NonCommercial + NoDerivatives — most restrictive |

- Wikipedia uses **CC BY-SA**

## 💰 FOSS Business Models
| Model                 | Description                                      | Example              |
|-----------------------|--------------------------------------------------|----------------------|
| Professional services | Sell enterprise support, consulting, maintenance | Canonical, Red Hat   |
| Dual licensing        | Free license + paid proprietary license          | MySQL, ownCloud      |
| SaaS                  | Pay to use software via subscription             | Dropbox, Salesforce  |
| Crowdfunding          | Collect donations for development                | Kickstarter projects |
| Merchandising         | Sell branded products/certifications             | Moodle               |

## 🔑 Key Takeaways
- "Free" = freedom, not price — you can sell free software
- Four freedoms numbered 0-3 (starts at zero!)
- Freedoms 1 and 3 require source code access
- Copyleft = license spreads to derivatives (GPL)
- Permissive = no restrictions on derivatives (BSD, MIT)
- Linux kernel uses GNU GPL
- FLOSS adds "Libre" to clarify freedom across languages
- Canonical's business model = professional services
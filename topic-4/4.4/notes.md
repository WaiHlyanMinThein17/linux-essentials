# 📓 Topic 4.4 — Your Computer on the Network

**Course:** LPI Linux Essentials (010-160) · **Date:** May 8, 2026 · **Status:** ✅ Complete

## 🌐 Network Layers

| Layer             | Purpose                                                    |
|-------------------|------------------------------------------------------------|
| Link Layer        | Communication between directly connected devices — MAC addresses |
| Network Layer     | Routing between networks — IP addresses (globally unique)  |
| Application Layer | Programs connecting to each other — ports and sockets      |

- **Packet switching** — data grouped with a header (source + destination), shared across links
- **Circuit switching** — old method, dedicated link between two devices (like telephone)

## 🔗 Link Layer — MAC Addresses

- MAC (Media Access Control) = 48-bit hardware address for each network interface
- Used to identify devices on the same local network (link)
- Cannot be used to route packets between different networks
- Broadcast packets (to all devices on local network) are always accepted

```bash
ip link show    # show all network interfaces and MAC addresses
# lo  = loopback, MAC = 00:00:00:00:00:00
# ens33 = ethernet interface, MAC = 00:0c:29:33:3b:25
```

## 🌍 IPv4 Networking

- IPv4 = 32-bit addresses, ~4.3 billion total
- Written as 4 decimal numbers separated by dots: `192.168.0.1`
- Each number = 8 bits (0–255)

## 🔢 Subnets and Subnet Masks

| Notation | Example          | Meaning                               |
|----------|------------------|---------------------------------------|
| Decimal  | 255.255.255.0    | First 24 bits = network, last 8 = host|
| CIDR     | 192.168.0.1/24   | 24 bits set in subnet mask            |

- `192.168.0.0/24` = network range 192.168.0.0 → 192.168.0.255

## 🏠 Private IPv4 Address Ranges

| Range                              | CIDR            |
|------------------------------------|-----------------|
| 10.0.0.0 – 10.255.255.255          | 10.0.0.0/8      |
| 172.16.0.0 – 172.31.255.255        | 172.16.0.0/12   |
| 192.168.0.0 – 192.168.255.255      | 192.168.0.0/16  |

- Private addresses cannot be routed on the public internet
- **NAT** = Network Address Translation — maps private addresses to one public IP
- **Masquerading** = special NAT where all internal devices share one external IP
- **DHCP** = Dynamic Host Configuration Protocol — automatically assigns IP addresses

## ⚙️ IPv4 Configuration Commands

```bash
ip link show                               # show interfaces and MAC addresses
ip addr show                               # show IP addresses on all interfaces
sudo ip addr add 192.168.0.5/24 dev ens33  # add IPv4 address to interface
ip route show                              # show routing table
sudo ip route add default via 192.168.0.1  # set default gateway
ping -c 3 192.168.0.1                      # test connectivity (3 pings)
```

## 🌐 IPv6 Networking

- IPv6 = 128-bit addresses — vastly more than IPv4
- Written as 8 groups of 4 hex digits separated by colons
- Leading zeros in groups can be removed
- Consecutive all-zero groups replaced with `::` (only once per address)

```
Full:      2001:0db8:0000:abcd:0000:0000:0000:7334
Shortened: 2001:db8:0:abcd::7334
```

## 📍 IPv6 Address Types

| Type          | Prefix      | Scope                                      |
|---------------|-------------|--------------------------------------------|
| Global Unique | Various     | Entire internet — globally routable        |
| Unique Local  | fc or fd    | Organization-internal (like IPv4 private)  |
| Link Local    | fe80        | Single link only — every interface has one |

- First 64 bits = routing prefix (which network)
- Last 64 bits = interface identifier (which device)
- **SLAAC** = Stateless Address Autoconfiguration — built-in IPv6 auto-config
- **DHCPv6** = updated DHCP for IPv6 — finer control over addresses

## ⚙️ IPv6 Configuration Commands

```bash
sudo ip addr add 2001:db8:0:abcd::7334/64 dev ens33    # add IPv6 address
ip addr show                                            # verify assignment
ping 2001:db8:0:abcd::1                                # ping IPv6 address
ping6 -c 1 fe80::010c:29ff:fe33:3b25%ens33             # ping link-local
sudo ip -6 route add default via 2001:db8:0:abcd::1    # set IPv6 default gateway
```

## 🔍 DNS — Domain Name System

- Translates human-readable domain names to IP addresses
- DNS resolver config: `/etc/resolv.conf`
- Local hostname overrides: `/etc/hosts` — checked before DNS

```bash
host learning.lpi.org     # simple DNS lookup
dig learning.lpi.org      # detailed DNS query info
```

| DNS Record Type | Purpose                                       |
|-----------------|-----------------------------------------------|
| A               | IPv4 address for a domain                     |
| AAAA            | IPv6 address for a domain                     |
| CNAME           | Alias — points to another domain              |
| MX              | Mail server for a domain                      |
| TXT             | Textual data                                  |
| PTR             | Reverse lookup — IP address to domain name    |

## 🔌 Sockets and Ports

| Type         | Description                                            |
|--------------|--------------------------------------------------------|
| Unix Sockets | Connect processes on the same device only              |
| UDP Sockets  | Fast, no guaranteed delivery — good for gaming, video  |
| TCP Sockets  | Reliable, ordered delivery — confirms receipt          |

| Service | Port |
|---------|------|
| HTTP    | 80   |
| HTTPS   | 443  |
| SSH     | 22   |

```bash
ss -t           # show all TCP sockets
ss -u           # show all UDP sockets
ss -p           # include process info
ss -s           # summary of all sockets
ss -4           # IPv4 sockets only
ss -6           # IPv6 sockets only
ss -l           # listening sockets only
```

## 🔑 Key Takeaways

- Link layer uses MAC addresses (48-bit) — local only, cannot route between networks
- Network layer uses IP addresses — globally unique, used for routing
- IPv4 = 32-bit, written as 4 decimal numbers (e.g. 192.168.0.1)
- Subnet mask splits IP into network + host — CIDR notation uses /N
- Private ranges: 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16
- NAT/masquerading maps private IPs to one public IP
- DHCP automatically assigns IP addresses
- IPv6 = 128-bit, :: replaces consecutive zero groups
- Link-local IPv6 addresses start with fe80 — every interface has one
- DNS translates domain names to IPs — /etc/resolv.conf configures resolvers
- /etc/hosts is checked before DNS for name lookups
- TCP = reliable ordered delivery, UDP = fast no guarantee
- HTTP=80, HTTPS=443, SSH=22
- `ip link show` = MAC, `ip addr show` = IPs, `ip route show` = routing table
- `ping` tests connectivity, `ss` investigates sockets

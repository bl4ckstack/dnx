# DNX: Domain Explorer

> A production-ready subdomain enumeration tool for security researchers and penetration testers

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Perl](https://img.shields.io/badge/Perl-5.10%2B-blue.svg)](https://www.perl.org/)
[![Version](https://img.shields.io/badge/version-1.0.0-green.svg)](https://github.com/yourusername/dnx)

DNX is a powerful, feature-rich subdomain enumeration tool that combines passive reconnaissance with active DNS brute-forcing to discover subdomains. With support for 40 different data sources and advanced features like recursive discovery, HTTP probing, and subdomain takeover detection, DNX is your go-to tool for comprehensive attack surface mapping.

---

## 🚀 Key Features

### Passive Enumeration
- **40 Data Sources**: Query 27 free and 13 premium APIs
- **Smart Caching**: 24-hour cache to reduce API load
- **Rate Limiting**: Configurable request throttling
- **Parallel Queries**: Efficient concurrent API requests

### Active Enumeration
- **DNS Brute-Force**: Wordlist-based subdomain discovery
- **Parallel Resolution**: Multi-threaded DNS queries (1-1000 threads)
- **Wildcard Detection**: Automatic filtering of false positives
- **Resolver Rotation**: Distribute queries across multiple DNS servers
- **Multiple Record Types**: A, AAAA, CNAME, MX, NS, TXT, SOA

### Advanced Features
- **Recursive Discovery**: Find subdomains of subdomains
- **DNS Zone Transfer**: Attempt AXFR on misconfigured servers
- **HTTP Probing**: Test service availability and extract titles
- **Takeover Detection**: Identify vulnerable subdomains (GitHub, AWS, Azure, etc.)
- **Signal Handling**: Graceful exit with Ctrl+C saves partial results

---

## 📦 Installation

```bash
# Install dependencies
make deps

# Test installation
make test

# Install system-wide (optional)
sudo make install
```

---

## 🎯 Quick Start

```bash
# Basic passive enumeration
./dnx -d example.com --passive

# Passive + brute-force
./dnx -d example.com -w subdomains.txt

# Comprehensive scan
./dnx -d example.com -w subdomains.txt --recursive --http-probe --takeover-check
```

---

## 📖 Usage

### Command-Line Options

| Option | Description | Default |
|--------|-------------|---------|
| `-d, --domain` | Target domain (required) | - |
| `-w, --wordlist` | Wordlist file | - |
| `-t, --threads` | Concurrent threads | 20 |
| `--timeout` | DNS timeout (seconds) | 5 |
| `-o, --output` | Output file | stdout |
| `-f, --format` | Format (text/json/csv) | text |
| `-p, --passive` | Passive only | false |
| `-q, --quiet` | Minimal output | false |
| `-v, --verbose` | Detailed output | false |
| `-r, --recursive` | Recursive discovery | false |
| `-z, --zone-transfer` | Attempt AXFR | false |
| `--http-probe` | Probe HTTP services | false |
| `--takeover-check` | Check takeovers | false |

---

## 🌐 Data Sources

**40 APIs** for maximum coverage:

### Free (27)
crt.sh, HackerTarget, ThreatCrowd, AlienVault OTX, Riddler.io, BufferOver, URLScan, CertSpotter, Anubis, ThreatMiner, DNSDumpster, RapidDNS, Sublist3r, CertDB, LeakIX, Wayback Machine, CommonCrawl, Sonar, Omnisint, ProjectDiscovery, and more...

### Premium (13)
VirusTotal, Shodan, SecurityTrails, Chaos, Spyse, BinaryEdge, Censys, FullHunt, Netlas, Fofa, ZoomEye, Hunter, GitHub

---

## 🔑 API Keys

```bash
export VIRUSTOTAL_API_KEY="your_key"
export SHODAN_API_KEY="your_key"
export SECURITYTRAILS_API_KEY="your_key"
```

---

## 💡 Examples

```bash
# Recursive discovery
./dnx -d example.com --recursive --recursion-depth 2

# Zone transfer
./dnx -d example.com --zone-transfer

# HTTP probing
./dnx -d example.com --http-probe --takeover-check

# Save to JSON
./dnx -d example.com -o results.json -f json

# High-speed scan
./dnx -d example.com -w wordlist.txt --threads 100
```

---

## 📊 Output Formats

- **Text**: Simple list with IPs
- **JSON**: Structured data with metadata
- **CSV**: Spreadsheet-compatible format

---

## 🛠️ Advanced Features

### Recursive Discovery
```bash
./dnx -d example.com --recursive --recursion-depth 2
```

### Zone Transfer
```bash
./dnx -d example.com --zone-transfer
```

### HTTP Probing
```bash
./dnx -d example.com --http-probe
```

### Takeover Detection
```bash
./dnx -d example.com --takeover-check
```

Detects: GitHub Pages, Heroku, AWS S3, Azure, CloudFront

---

## 🚦 Performance

| Scan Type | Time | Notes |
|-----------|------|-------|
| Passive | 30-60s | 40 APIs |
| Small wordlist (1K) | 1-2 min | 20 threads |
| Large wordlist (100K) | 30-60 min | 100 threads |

---

## 🐛 Troubleshooting

```bash
# Install missing modules
make deps

# Verbose mode
./dnx -d example.com -v

# Slower scan
./dnx -d example.com --threads 10 --timeout 10
```

---

## 🔒 Security & Ethics

- Only scan domains you own or have permission to test
- Respect rate limits and API terms
- Use responsibly and ethically

---

## 📄 License

MIT License - see LICENSE file

---

## 👤 Author

**bl4ckstack**

---

**Made with ❤️ for the security community**

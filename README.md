# DNX: Domain Explorer

A production-ready subdomain enumeration tool written in Perl for security researchers and penetration testers.

## Features

### Core Capabilities
- **Passive Enumeration**: Query multiple public APIs without touching the target
  - crt.sh (Certificate Transparency logs)
  - HackerTarget
  - ThreatCrowd
  - AlienVault OTX
  - Riddler.io
  - VirusTotal (requires API key)
  - Shodan (requires API key)
- **Active Brute-Force**: Parallel DNS resolution with wordlist support
- **Wildcard Detection**: Automatically detect and filter wildcard DNS responses
- **DNS Resolver Rotation**: Distribute queries across multiple resolvers
- **Smart Caching**: Cache API results for 24 hours to reduce load
- **Rate Limiting**: Configurable API rate limiting

### Output & Usability
- **Multiple Formats**: Text, JSON, CSV
- **Colorized Output**: Easy-to-read terminal output with color coding
- **Progress Indicators**: Real-time progress bars for both passive and active enumeration
- **Flexible Configuration**: CLI arguments and config file support
- **Quiet/Verbose Modes**: Control output verbosity
- **Graceful Exit**: Signal handling (Ctrl+C) saves partial results
- **Enhanced Input Validation**: Automatic URL parsing and domain validation
- **DNS Record Types**: Support for A, AAAA, CNAME, MX, NS, TXT, SOA records

## Installation

### Prerequisites

DNX requires Perl 5.10+ and several CPAN modules.

### Quick Install

```bash
# 1. Install dependencies
make deps

# 2. Test installation
make test

# 3. Install system-wide (optional)
sudo make install
```

### Installation Methods

#### Method 1: Using Makefile (Recommended)

```bash
# Install dependencies
make deps

# Install system-wide to /usr/local/bin
sudo make install

# Or install to custom location
sudo make PREFIX=/usr install
```

#### Method 2: Using cpanm

```bash
# Install cpanminus if not already installed
curl -L https://cpanmin.us | perl - App::cpanminus

# Install dependencies from cpanfile
cpanm --installdeps .

# Make executable and install
chmod +x dnx
sudo cp dnx /usr/local/bin/
```

#### Method 3: Manual Installation

```bash
# Install required CPAN modules
cpan install LWP::UserAgent JSON Net::DNS Term::ANSIColor

# Make executable
chmod +x dnx

# Optionally move to PATH
sudo cp dnx /usr/local/bin/

# Create config directory
mkdir -p ~/.dnx/cache
```

### Makefile Targets

```bash
make              # Check syntax (default)
make deps         # Install Perl dependencies
make install      # Install system-wide (requires sudo)
make uninstall    # Remove from system
make test         # Run basic tests
make check        # Check Perl syntax
make clean        # Clean cache and output files
make help         # Show all targets
```

## Usage

### Basic Examples

```bash
# Simple passive enumeration
./dnx --domain example.com

# Passive + brute-force with wordlist
./dnx -d example.com --wordlist subdomains.txt

# High-speed brute-force with 50 threads
./dnx -d example.com --wordlist subdomains.txt --threads 50

# Passive only (no brute-force)
./dnx -d example.com --passive

# Save results to JSON
./dnx -d example.com --output results.json --format json

# Quiet mode with CSV output
./dnx -d example.com -q --output results.csv --format csv

# Verbose mode for debugging
./dnx -d example.com -v --wordlist subdomains.txt
```

### Advanced Usage

```bash
# Custom DNS resolvers
./dnx -d example.com --resolvers 8.8.8.8,1.1.1.1,9.9.9.9

# Adjust timeout for slow networks
./dnx -d example.com --timeout 10

# Lower rate limit for API-friendly scanning
./dnx -d example.com --rate-limit 5

# Skip brute-force, passive only
./dnx -d example.com --no-bruteforce

# Query multiple DNS record types
./dnx -d example.com --record-types A,AAAA,MX,NS

# Domain with URL (auto-parsed)
./dnx -d https://example.com/path --passive

# Use API keys for enhanced results
./dnx -d example.com --shodan-key YOUR_KEY --virustotal-key YOUR_KEY
```

## Command-Line Options

| Option | Description | Default |
|--------|-------------|---------|
| `-d, --domain` | Target domain (required) | - |
| `-w, --wordlist` | Wordlist file for brute-force | - |
| `-t, --threads` | Concurrent threads | 20 |
| `--timeout` | DNS timeout (seconds) | 5 |
| `-o, --output` | Output file path | stdout |
| `-f, --format` | Output format (text/json/csv) | text |
| `-p, --passive` | Passive enumeration only | false |
| `--no-bruteforce` | Skip brute-force | false |
| `-q, --quiet` | Minimal output | false |
| `-v, --verbose` | Detailed output | false |
| `--resolvers` | Comma-separated DNS resolvers | 8.8.8.8,8.8.4.4,1.1.1.1,1.0.0.1 |
| `--rate-limit` | API requests per second | 10 |
| `--record-types` | DNS record types (A,AAAA,CNAME,MX,NS,TXT,SOA) | A |
| `--shodan-key` | Shodan API key | - |
| `--virustotal-key` | VirusTotal API key | - |
| `-h, --help` | Show help message | - |
| `--version` | Show version | - |

## Configuration File

Create `~/.dnx/config.ini` for persistent settings:

```ini
# Default configuration for DNX
threads = 30
timeout = 5
rate_limit = 10
format = text

# Custom DNS resolvers (comma-separated)
# resolvers = 8.8.8.8,1.1.1.1,9.9.9.9

# API Keys (optional)
# shodan_api_key = YOUR_KEY_HERE
# virustotal_api_key = YOUR_KEY_HERE
```

## API Keys (Optional)

For enhanced enumeration, you can use API keys from:

### VirusTotal
1. Sign up at https://www.virustotal.com/
2. Get your API key from https://www.virustotal.com/gui/my-apikey
3. Set via environment variable or config file:
```bash
export VIRUSTOTAL_API_KEY="your_key_here"
# Or use --virustotal-key flag
./dnx -d example.com --virustotal-key "your_key_here"
```

### Shodan
1. Sign up at https://account.shodan.io/register
2. Get your API key from https://account.shodan.io/
3. Set via environment variable or config file:
```bash
export SHODAN_API_KEY="your_key_here"
# Or use --shodan-key flag
./dnx -d example.com --shodan-key "your_key_here"
```

## Output Formats

### Text (Default)
```
www.example.com                                    93.184.216.34
mail.example.com                                   93.184.216.34
ftp.example.com                                    93.184.216.34
```

### JSON
```json
{
  "domain": "example.com",
  "timestamp": "2025-11-19 12:34:56",
  "count": 3,
  "subdomains": [
    {
      "subdomain": "www.example.com",
      "ip": "93.184.216.34"
    }
  ]
}
```

### CSV
```csv
subdomain,ip
www.example.com,93.184.216.34
mail.example.com,93.184.216.34
```

## Performance & Benchmarks

### Typical Performance
- **Passive enumeration**: 5-15 seconds (depends on API response times)
- **Brute-force (1000 words, 20 threads)**: 30-60 seconds
- **Brute-force (10000 words, 50 threads)**: 5-10 minutes

### Optimization Tips
1. **Increase threads** for faster brute-force: `--threads 50`
2. **Use caching**: Results are cached for 24 hours automatically
3. **Custom resolvers**: Use fast, reliable DNS resolvers
4. **Smaller wordlists**: Focus on high-value subdomains first

## Features in Detail

### Progress Tracking
DNX shows real-time progress for both passive and active enumeration:
- Passive: Shows current API being queried (e.g., "Querying APIs: 3/7")
- Active: Shows percentage and progress bar for wordlist brute-force

### Signal Handling
Press `Ctrl+C` to gracefully stop DNX:
- Saves partial results automatically
- Shows elapsed time
- Exits cleanly without data loss

### Input Validation
DNX automatically handles various input formats:
```bash
# All these work the same:
./dnx -d example.com
./dnx -d https://example.com
./dnx -d http://example.com/path
./dnx -d example.com:443
```

Validates:
- Domain format (RFC 1035 compliant)
- Maximum domain length (253 characters)
- Label length (63 characters per label)
- Wordlist file existence and readability
- Thread count (1-1000)
- Timeout (1-60 seconds)
- DNS record types

### DNS Record Types
Query multiple DNS record types simultaneously:
```bash
./dnx -d example.com --record-types A,AAAA,MX,NS,TXT
```

Supported types:
- **A**: IPv4 addresses
- **AAAA**: IPv6 addresses
- **CNAME**: Canonical names
- **MX**: Mail exchange servers
- **NS**: Name servers
- **TXT**: Text records
- **SOA**: Start of authority

## Troubleshooting

### Common Issues

**Problem**: "Cannot locate LWP/UserAgent.pm"
```bash
# Solution: Install missing Perl module
cpan install LWP::UserAgent
```

**Problem**: Slow DNS resolution
```bash
# Solution: Increase threads and use faster resolvers
./dnx -d example.com --threads 50 --resolvers 1.1.1.1,8.8.8.8
```

**Problem**: API rate limiting
```bash
# Solution: Reduce rate limit
./dnx -d example.com --rate-limit 5
```

**Problem**: Too many false positives
```bash
# Solution: DNX automatically detects wildcards, but you can verify with verbose mode
./dnx -d example.com -v
```

### Debug Mode

Use verbose mode to see detailed operation:
```bash
./dnx -d example.com -v --wordlist subdomains.txt
```

## Wordlists

A sample wordlist (`subdomains.txt`) is included with common subdomain names. For comprehensive scanning, consider:

- **SecLists**: https://github.com/danielmiessler/SecLists
- **Subdomains-Top1Million**: https://github.com/rbsec/dnscan
- **All.txt**: https://gist.github.com/jhaddix/86a06c5dc309d08580a018c66354a056

## API Sources

DNX queries the following APIs:

### Free (No API Key Required)
1. **crt.sh** - Certificate Transparency logs
2. **HackerTarget** - Free API (limited requests)
3. **ThreatCrowd** - Threat intelligence
4. **AlienVault OTX** - Open Threat Exchange
5. **Riddler.io** - DNS database

### Premium (API Key Required)
6. **VirusTotal** - Comprehensive subdomain data
7. **Shodan** - Internet-wide scanning data

### API Rate Limiting

To be respectful of public APIs:
- Default rate limit: 10 requests/second
- Results are cached for 24 hours
- Failed requests are logged but don't stop execution

## Security & Ethics

### Responsible Use
- Only scan domains you own or have permission to test
- Respect rate limits and API terms of service
- Be aware of your local laws regarding security testing
- Use responsibly and ethically

### Legal Notice
This tool is provided for educational and authorized security testing purposes only. Users are responsible for complying with all applicable laws and regulations.

## Contributing

Contributions are welcome! Areas for improvement:
- Additional passive sources
- AXFR zone transfer attempts
- IPv6 support
- Database export options
- Integration with other tools

## License

MIT License - see LICENSE file for details

## Author

**bl4ckstack**

## Version

1.0.0

## Changelog

### v1.0.0 (2025-11-19)
- Initial release
- Passive enumeration via 5 public APIs
- Parallel DNS brute-force
- Wildcard detection
- Multiple output formats
- Caching layer
- Configuration file support

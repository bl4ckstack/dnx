# DNX Makefile
# Domain Explorer - Subdomain Enumeration Tool

PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
INSTALL = install
PERL = perl

# Directories
CONFIG_DIR = $(HOME)/.dnx
CACHE_DIR = $(CONFIG_DIR)/cache

.PHONY: all install uninstall test clean deps check help

all: check
	@echo "DNX is ready to use!"
	@echo "Run 'make install' to install system-wide"
	@echo "Run 'make deps' to install Perl dependencies"

# Check syntax
check:
	@echo "Checking Perl syntax..."
	@$(PERL) -c dnx
	@echo "✓ Syntax OK"

# Install dependencies
deps:
	@echo "Installing Perl dependencies..."
	@if command -v cpanm >/dev/null 2>&1; then \
		cpanm --installdeps .; \
	elif command -v cpan >/dev/null 2>&1; then \
		cpan LWP::UserAgent JSON Net::DNS Term::ANSIColor; \
	else \
		echo "Error: Neither cpanm nor cpan found. Please install cpanminus or cpan."; \
		exit 1; \
	fi
	@echo "✓ Dependencies installed"

# Install system-wide
install: check
	@echo "Installing DNX to $(BINDIR)..."
	@$(INSTALL) -d $(BINDIR)
	@$(INSTALL) -m 755 dnx $(BINDIR)/dnx
	@echo "✓ DNX installed to $(BINDIR)/dnx"
	@echo ""
	@echo "Creating config directory..."
	@mkdir -p $(CONFIG_DIR)
	@mkdir -p $(CACHE_DIR)
	@if [ ! -f $(CONFIG_DIR)/config.ini ]; then \
		$(INSTALL) -m 644 config.ini.example $(CONFIG_DIR)/config.ini; \
		echo "✓ Config file created at $(CONFIG_DIR)/config.ini"; \
	else \
		echo "✓ Config file already exists"; \
	fi
	@echo ""
	@echo "Installation complete! You can now run: dnx --help"

# Uninstall
uninstall:
	@echo "Uninstalling DNX..."
	@rm -f $(BINDIR)/dnx
	@echo "✓ DNX removed from $(BINDIR)"
	@echo ""
	@echo "Config directory $(CONFIG_DIR) was NOT removed."
	@echo "To remove it manually: rm -rf $(CONFIG_DIR)"

# Run tests
test: check
	@echo "Running basic tests..."
	@echo "Testing help output..."
	@./dnx --help > /dev/null
	@echo "✓ Help works"
	@echo "Testing version..."
	@./dnx --version > /dev/null
	@echo "✓ Version works"
	@echo ""
	@echo "All tests passed!"

# Clean cache and temporary files
clean:
	@echo "Cleaning cache..."
	@rm -rf $(CACHE_DIR)/*
	@echo "✓ Cache cleaned"
	@rm -f *.txt *.json *.csv 2>/dev/null || true
	@echo "✓ Output files cleaned"

# Show help
help:
	@echo "DNX Makefile - Available targets:"
	@echo ""
	@echo "  make              - Check syntax (default)"
	@echo "  make deps         - Install Perl dependencies"
	@echo "  make install      - Install DNX system-wide (requires sudo)"
	@echo "  make uninstall    - Remove DNX from system"
	@echo "  make test         - Run basic tests"
	@echo "  make check        - Check Perl syntax"
	@echo "  make clean        - Clean cache and output files"
	@echo "  make help         - Show this help message"
	@echo ""
	@echo "Installation paths:"
	@echo "  PREFIX=$(PREFIX)"
	@echo "  BINDIR=$(BINDIR)"
	@echo "  CONFIG_DIR=$(CONFIG_DIR)"
	@echo ""
	@echo "Examples:"
	@echo "  make deps                    # Install dependencies"
	@echo "  sudo make install            # Install to /usr/local/bin"
	@echo "  sudo make PREFIX=/usr install # Install to /usr/bin"
	@echo "  make test                    # Run tests"

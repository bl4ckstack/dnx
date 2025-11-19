# DNX Dependencies
# Install with: cpanm --installdeps .

requires 'perl', '5.010';

# Core dependencies
requires 'LWP::UserAgent';
requires 'JSON';
requires 'Net::DNS';
requires 'Term::ANSIColor';
requires 'Getopt::Long';
requires 'Time::HiRes';
requires 'File::Path';
requires 'File::Spec';
requires 'Digest::MD5';
requires 'Socket';
requires 'POSIX';

# Optional but recommended
recommends 'LWP::Protocol::https';
recommends 'Mozilla::CA';

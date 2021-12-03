# osx-setup
Automates setup and configuration for OSX (assuming network access is already set up).

Packages and configuration settings are personal preferences, feel free to fork and modify as applicable. 

## Homebrew 🍺 
The script will first install the [Homebrew](https://brew.sh/) package manager, if not already installed.

Upon completion, it will install various packages:
- `git` (Distributed revision control system)
- `wget` (Internet file retriever)
- `python` (Python)
- `pylint` (It's not just a linter that annoys you!)
- `figlet` (Banner-like program prints strings as ASCII art)
- `magic-wormhole` (Securely transfers data between computers)
- `ffmpeg` (Play, record, convert, and stream audio and video)
- `imagemagick` (Tools and libraries to manipulate images in many formats)
- `cowsay` (Configurable talking characters in ASCII art)
- `irssi` (Modular IRC client)
- `sqlcipher` (SQLite extension providing 256-bit AES encryption)
- `sqlite` (Command-line interface for SQLite)
- `sl` (Prints a steam locomotive if you type sl instead of ls)
- `little-snitch` (Host-based application firewall) 
- `firefox` (Web browser)
- `gimp` (Free and open-source image editor)
- `libreoffice` (Office suite)
- `adium` (Instant messaging application)
- `macfuse` (File system integration)
- `veracrypt` (Disk encryption software focusing on security based on TrueCrypt)
- `signal` (Instant messaging application focusing on security)
- `visual-studio-code` (Open-source code editor)

To change what is installed, edit the package names in the `homebrew_formulae` and `homebrew_casks` variables.

## OSX Config
pass


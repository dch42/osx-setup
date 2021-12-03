# osx-setup
Automates setup and configuration for OSX (assuming network access is already set up).

Packages and configuration settings are personal preferences, feel free to fork and modify as applicable. 

## Homebrew 🍺 
The script will first install the [Homebrew](https://brew.sh/) package manager, if not already installed.

Upon completion, it will install various packages:
- [`git`](https://git-scm.com/) (Distributed revision control system)
- [`wget`](https://www.gnu.org/software/wget/) (GNU internet file retriever)
- [`python`](https://www.python.org/) (Python)
- [`pylint`](https://pylint.org/) (It's not just a linter that annoys you!)
- [`figlet`](http://www.figlet.org/figlet_history.html) (Banner-like program prints strings as ASCII art)
- [`magic-wormhole`](https://magic-wormhole.readthedocs.io/en/latest/welcome.html) (Securely transfers data between computers)
- [`ffmpeg`](https://ffmpeg.org/about.html) (Play, record, convert, and stream audio and video)
- [`imagemagick`](https://imagemagick.org/script/index.php) (Tools and libraries to manipulate images in many formats)
- [`cowsay`](https://web.archive.org/web/20071026043648/http://www.nog.net/~tony/warez/cowsay.shtml) (Configurable talking characters in ASCII art)
- [`irssi`](https://irssi.org/) (Modular IRC client)
- [`sqlcipher`](https://www.zetetic.net/sqlcipher/) (SQLite extension providing 256-bit AES encryption)
- [`sqlite`](https://sqlite.org/index.html) (Command-line interface for SQLite)
- [`sl`](https://github.com/mtoyoda/sl) (Prints a steam locomotive if you type sl instead of ls)
- [`little-snitch`](https://www.obdev.at/products/littlesnitch/index.html) (Host-based application firewall) 
- [`firefox`](https://www.mozilla.org/en-US/firefox/new/) (Web browser)
- [`gimp`](https://www.gimp.org/about/) (Free and open-source image editor)
- [`libreoffice`](https://www.libreoffice.org/discover/libreoffice/) (Office suite)
- [`adium`](https://adium.im/) (Instant messaging application)
- [`macfuse`](https://osxfuse.github.io/) (File system integration)
- [`veracrypt`](https://www.veracrypt.fr/en/Home.html) (Disk encryption software focusing on security based on TrueCrypt)
- [`signal`](https://www.signal.org/) (Instant messaging application focusing on security)
- [`visual-studio-code`](https://code.visualstudio.com/docs) (Open-source code editor)

To change what is installed, edit the package names in the `homebrew_formulae` and `homebrew_casks` variables.

## OSX Config
pass


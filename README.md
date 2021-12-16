# osx-setup
Automates OS-X setup and configuration.

Packages and configuration settings are personal preferences, feel free to fork and modify as applicable. 

Written with High Sierra in mind, but most of the script will probably work with other releases as well.

## Usage
Clone the repo and change to project directory:
~~~
git clone https://github.com/dch42/osx-setup.git && cd osx-setup
~~~

Add executable permissions to script and run: 
~~~
chmod +x setup.sh && ./setup.sh
~~~

## Homebrew 🍺 
The script will first install the [Homebrew](https://brew.sh/) package manager, if not already installed.

Upon completion, it will install various packages:
- [`git`](https://git-scm.com/) (Distributed revision control system)
- [`wget`](https://www.gnu.org/software/wget/) (GNU internet file retriever)
- [`coreutils`](https://www.gnu.org/software/coreutils/coreutils.html) (GNU File, Shell, and Text utilities)
- [`node`](https://nodejs.org/en/about/) (Node.js & NPM)
- [`python`](https://www.python.org/) (Python)
- [`pylint`](https://pylint.org/) (Python linter)
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

*To change what packages are installed, edit the package names in the `homebrew_formulae` and `homebrew_casks` variables.*

## Other Packages
### Xcode
The script will install [Xcode Command Line Tools](https://developer.apple.com/library/archive/technotes/tn2339/_index.html#//apple_ref/doc/uid/DTS40014588-CH1-WHAT_IS_THE_COMMAND_LINE_TOOLS_PACKAGE_).

### Pip Packages
The script will also install some useful python packages:
- [`tqdm`](https://tqdm.github.io/)
- [`pyfiglet`](https://github.com/pwaller/pyfiglet)
- [`pandas`](https://pandas.pydata.org)
- [`numpy`](https://numpy.org/)
- [`beautifulsoup4`](https://beautiful-soup-4.readthedocs.io/en/latest/)

*Packages can be modified by editing the `pip_packages` variable.*

### NPM Packages
...and some useful node modules:
- [`walk`](https://www.npmjs.com/package/walk)
- [`eslint`](https://www.npmjs.com/package/eslint)
- [`prettier`](https://www.npmjs.com/package/prettier)
- [`musicmetadata`](https://www.npmjs.com/package/musicmetadata)
- [`sqlite3`](https://www.npmjs.com/package/sqlite3)

*Packages can be modified by editing the `npm_packages` variable.*

## OSX Config 
The script configures various OS settings and preferences mainly using [`defaults`](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPRuntimeConfig/Articles/UserPreferences.html) and [`systemsetup`](https://ss64.com/osx/systemsetup.html).

The script will verify the success of configuration changes by reading values with `defaults read` or piping command output to `grep`.

- enable firewall
- disable remote login
- disable guest login
- disable bluetooth
- require password on sleep/screen saver
- set password delay to 0
- set display sleep to 10 mins
- enable network time
- set hdd sleep 20 mins
- set computer sleep 20 mins
- don't wake on network access
- disable remote apple events
- show all file extensions
- show status and path bars in finder
- show folders on top when sorting by name
- avoid creating .ds_store files on usb/network drives
- don't prompt for time machine backup on new disks
- disable mail send/reply animations 

Takes heavy inspiration from Kristov Atlas' [osx-config-check](https://github.com/kristovatlas/osx-config-check) and Mathias Bynens' [dotfiles](https://github.com/mathiasbynens/dotfiles).

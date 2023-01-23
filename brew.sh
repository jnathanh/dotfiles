#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install -q coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install -q moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install -q findutils
# Install GNU `sed`, (overwrites the built-in `sed` via earlier PATH insertion, see .path file).
brew install -q gnu-sed
# Install a modern version of Bash.
brew install -q bash
brew install -q bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Install `wget` with IRI support.
brew install -q wget

# Install GnuPG to enable PGP-signing commits.
brew install -q gnupg

# Install more recent versions of some macOS tools.
brew install -q vim
brew install -q grep
brew install -q openssh
brew install -q screen
# brew install -q php
# brew install -q gmp

# Install font tools.
# brew tap bramstein/webfonttools
# brew install -q sfnt2woff
# brew install -q sfnt2woff-zopfli
# brew install -q woff2

# Install some CTF tools; see https://github.com/ctfs/write-ups.
# brew install -q aircrack-ng
# brew install -q bfg
# brew install -q binutils
# brew install -q binwalk
# brew install -q cifer
# brew install -q dex2jar
# brew install -q dns2tcp
# brew install -q fcrackzip
# brew install -q foremost
# brew install -q hashpump
# brew install -q hydra
# brew install -q john
# brew install -q knock
# brew install -q netpbm
# brew install -q nmap
# brew install -q pngcheck
# brew install -q socat
# brew install -q sqlmap
# brew install -q tcpflow
# brew install -q tcpreplay
# brew install -q tcptrace
# brew install -q ucspi-tcp # `tcpserver` etc.
# brew install -q xpdf
# brew install -q xz

# Install other useful binaries.
brew install -q ack
brew install -q git
brew install -q tree
brew install -q jq          # cli json manipulation/formatting
brew install -q dependency-check # OWASP cli tool for scanning a dir for CVE vulnerabilities
brew install -q postgresql@14
brew install -q go
brew install -q awscli
brew install -q parquet-tools
brew install -q exiftool # cli for photo metadata read/write in most metadata/image formats
brew install -q wireshark # cli for wireshark
brew install -q pandoc # convert between file types (dependency of typora)



# brew install -q exiv2       # read metadata from images
# brew install -q git-lfs     # large file storage, store repo large files as pointers instead of content
# brew install -q gs          # ghost script, pdf manipulation
# brew install -q imagemagick
# brew install -q lua         # lang, used mostly for plugins I think (ex: lightroom)
# brew install -q lynx        # terminal web browser
# brew install -q p7zip
# brew install -q pigz        # gzip, but parallelized so it processes faster
# brew install -q pv          # pipe viewer, shows stats on data streaming through terminal pipes
# brew install -q rename      # file renaming utility
# brew install -q rlwrap      # readline wrapper, adds readline functionality to inputs that don't support it (editing/history on inputs)
# brew install -q ssh-copy-id # Add a public key to a remote machine's authorized_keys file
# brew install -q vbindiff    # diff binary files, shows hex and text representations


brew install -q hugo

# azure tools
brew install -q azure-cli
brew tap azure/bicep
brew install -q bicep
brew tap azure/functions
brew install -q azure-functions-core-tools@4
brew install -q --cask powershell
brew install -q --cask azure-data-studio


# Install Casks (GUI binaries)
brew install -q --cask typora    # markdown editor/browser
brew install -q --cask mark-text # the original typora was branched from, but performs better where typora has bugs
brew install -q --cask todotxt   # todo.txt GUI
brew install -q --cask dropbox
brew install -q --cask adobe-dng-converter # required by lrtimelapse
brew install -q --cask lrtimelapse         # time lapse app with lightroom integration
brew install -q --cask sublime-text
brew install -q --cask rectangle
brew install -q --cask google-chrome
brew install -q --cask vuescan   # scanning software compatible with all scanners (since brother doesn't support my model anymore)
brew install -q --cask quicken
brew install -q --cask docker
brew install -q --cask visual-studio-code
brew install -q --cask raspberry-pi-imager
# brew install -q --cask intellij-idea-ce
brew install -q --cask qlmarkdown # adds preview/quicklook support for markdown files
brew install -q --cask arq # file backup client (backs up to s3 glacier), todo: how to auto-setup backups?
brew install -q --cask paragon-ntfs # ntfs driver (allows writing to seagate backup drive... and maybe faster reads?)
brew install -q --cask wireshark # for inspecting network traffic

# Remove outdated versions from the cellar.
brew cleanup

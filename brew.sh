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
#brew install -q php
#brew install -q gmp

# Install font tools.
#brew tap bramstein/webfonttools
#brew install -q sfnt2woff
#brew install -q sfnt2woff-zopfli
#brew install -q woff2

# Install some CTF tools; see https://github.com/ctfs/write-ups.
#brew install -q aircrack-ng
#brew install -q bfg
#brew install -q binutils
#brew install -q binwalk
#brew install -q cifer
#brew install -q dex2jar
#brew install -q dns2tcp
#brew install -q fcrackzip
#brew install -q foremost
#brew install -q hashpump
#brew install -q hydra
#brew install -q john
#brew install -q knock
#brew install -q netpbm
#brew install -q nmap
#brew install -q pngcheck
#brew install -q socat
#brew install -q sqlmap
#brew install -q tcpflow
#brew install -q tcpreplay
#brew install -q tcptrace
#brew install -q ucspi-tcp # `tcpserver` etc.
#brew install -q xpdf
#brew install -q xz

# Install other useful binaries.
brew install -q ack
#brew install -q exiv2
brew install -q git
brew install -q git-lfs
brew install -q gs
brew install -q imagemagick
brew install -q lua
brew install -q lynx
brew install -q p7zip
brew install -q pigz
brew install -q pv
brew install -q rename
brew install -q rlwrap
brew install -q ssh-copy-id
brew install -q tree
brew install -q vbindiff
brew install -q zopfli

# Install Casks (GUI binaries)
brew install -q --cask typora    # markdown editor/browser
brew install -q --cask mark-text # the original typora was branched from, but performs better where typora has bugs
brew install -q --cask todotxt   # todo.txt GUI
brew install -q --cask dropbox
brew install -q --cask adobe-dng-converter # required by lrtimelapse
brew install -q --cask lrtimelapse         # time lapse app with lightroom integration
brew install -q --cask sublime-text

# Remove outdated versions from the cellar.
brew cleanup

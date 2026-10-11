#!/usr/bin/env bash

# Install command-line tools using pip.

# Make sure we’re using the latest pip.
 brew update

# Upgrade any already-installed packages.
 brew upgrade

# install pygments (required for json function)
pip install pygments

# headless browser automation; used to measure rendered SVG geometry (text
# extents, overlaps) for the diagram linter. The browser itself is a separate
# ~95MB download that pip does not fetch.
pip install playwright
python3 -m playwright install chromium

#!/usr/bin/env bash

# ruby version manager #############################################################################################

# Check if frum is installed
if ! command -v frum &> /dev/null
then
    echo "'frum' ruby version manager could not be found. Install with `brew install frum`"
    exit 1
fi

# install latest if no versions are installed
installed_versions=$(frum versions)

if [ -z "$installed_versions" ]
then
    latest_published_version=$(frum install --list | sort | tail -n 1)

    echo "found no frum-managed ruby versions installed, installing ruby version $latest_published_version"
    frum install $latest_published_version

    echo "setting global ruby version to $latest_published_version"
    frum global $latest_published_version
fi

# update ruby gems package ############################################################################
# also includes bundler by default in the latest versions
gem update --system

# setup dependencies for vscode ruby debugger
gem install ruby-debug-ide # proxy/translater between ruby debugger and IDE debug protocols
gem install debase --pre # fast implementation of ruby debugger; requires --pre because it needs the v0.2.5.beta2 version (pre-release) that solves a missing C headers issue

# setup dependencies for vscode solargraph plugin (intellisense that works)
gem install solargraph
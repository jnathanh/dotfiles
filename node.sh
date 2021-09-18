#!/usr/bin/env bash

# node version manager
brew install -q nvm

# create NVM_DIR (declared in exports file)
mkdir -p ~/.nvm

# initialize nvm in current shell
source ~/.bash_profile

# latest version of node
nvm install node
#!/usr/bin/env bash

# ensure NVM_DIR exists
mkdir -p ~/.nvm

# node version manager
export NVM_DIR="$HOME/.nvm"

# init nvm
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
# [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion (I don't actually think this is necessary)

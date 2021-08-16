#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
UNDERLINE='\033[4m'
UNFMT='\033[0m'

# log the command and location of failures
set -eE -o functrace
failure() {
  local lineno=$1
  local msg=$2
  echo "Failed at $3:$lineno: $msg"
  echo "Failed at $3:$lineno: $msg" > $HOME/Desktop/dotfiles_bootstrap_error.txt
}
trap 'failure ${LINENO} "$BASH_COMMAND" "$BASH_SOURCE"' ERR

# homebrew (this is the primary method of managing packages)
echo -e "${UNDERLINE}installing homebrew${UNFMT}"

if ! (brew -v >/dev/null 2>&1); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    case $? in
        0) echo -e "${GREEN}installed homebrew${UNFMT}";;
        *) echo -e "${RED}error installing homebrew${UNFMT}";exit 1;;
    esac
else
    echo -e "${GREEN}homebrew already installed${UNFMT}";
fi

# make sure github is a trusted host (avoid auth failure on first execution)
if ! grep -q "^github.com" ${HOME}/.ssh/known_hosts; then
    echo -e "${UNDERLINE}adding github.com to known hosts${UNFMT}"

    sudo ssh-keyscan -t rsa github.com >> ${HOME}/.ssh/known_hosts

    case $? in
        0) echo -e "${GREEN}done${UNFMT}";;
        *) echo -e "${RED}${ERROR}${UNFMT}";exit 1;;
    esac
fi

# download latest dotfiles
echo -e "${UNDERLINE}downloading latest dotfiles${UNFMT}"

DOTFILES_DIR="${HOME}/src"
DOTFILES_PATH="${DOTFILES_DIR}/dotfiles"

mkdir -p ${DOTFILES_DIR}

if [[ -d ${DOTFILES_PATH} ]]; then
    ERROR=$(
        set -e
        cd ${DOTFILES_PATH} 2>&1 >/dev/null
        git checkout main  2>&1 >/dev/null
        git pull origin main 2>&1 >/dev/null
    )

    case $? in
        0) echo -e "${GREEN}updated local dotfiles (${DOTFILES_PATH}) from origin${UNFMT}";;
        *) echo -e "${RED}${ERROR}${UNFMT}";exit 1;;
    esac
else
    ERROR=$(
        cd ${DOTFILES_DIR}
        git clone git@github.com:jnathanh/dotfiles.git
    )

    case $? in
        0) echo -e "${GREEN}downloaded to ${DOTFILES_PATH}${UNFMT}";;
        *) echo -e "${RED}${ERROR}${UNFMT}";exit 1;;
    esac
fi

cd ${DOTFILES_PATH}

# configure mac settings
./macos.sh

# update homebrew state
./brew.sh

# sync dotfiles to ~
function doIt() {
        rsync -avh --no-perms home_files ~;
        source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;

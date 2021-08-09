#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
UNDERLINE='\033[4m'
UNFMT='\033[0m'

# homebrew (this is the primary method of managing packages)
echo "${UNDERLINE}installing homebrew${UNFMT}"

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
    echo "${UNDERLINE}adding github.com to known hosts${UNFMT}"

    sudo ssh-keyscan -t rsa github.com >> ${HOME}/.ssh/known_hosts

    case $? in
        0) echo -e "${GREEN}done${UNFMT}";;
        *) echo -e "${RED}${ERROR}${UNFMT}";exit 1;;
    esac
fi

# download latest dotfiles
echo "${UNDERLINE}downloading latest dotfiles${UNFMT}"

DOTFILES_DIR="${HOME}/src"
DOTFILES_PATH="${DOTFILES_DIR}/dotfiles"

mkdir -p ${DOTFILES_DIR}

if [[ -d ${DOTFILES_PATH} ]]; then
    ERROR=$(
        set -e
        cd ${DOTFILES_PATH} 2>&1 >/dev/null
        git checkout main  2>&1 >/dev/null
        git pull 2>&1 >/dev/null
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

# continue with bootstrap.sh
${DOTFILES_PATH}/bootstrap.sh

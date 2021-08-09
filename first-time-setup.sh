#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
UNCOLOR='\033[0m'

## xcode command line tools (required in order to use git
#echo -n installing xcode command line tools
#
#ERROR=$(xcode-select --install 2>&1 >/dev/null) # save stderr to $ERROR var instead of printing
#
#case $? in
#    1) echo -e "\t${GREEN}already installed${UNCOLOR}";;
#    0) echo -e "\t${GREEN}Done${UNCOLOR}";;
#    *) echo -e "\n\t${RED}${ERROR}${UNCOLOR}";;
#esac

# homebrew (this is the primary method of managing packages)
echo -n installing homebrew

if ! (brew -v >/dev/null 2>&1); then
     echo; # so brew install output doesn't start on same line

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    case $? in
        0) echo -e "\n\t${GREEN}Done${UNCOLOR}";;
        *) echo -e "\n${RED}Error installing Homebrew${UNCOLOR}";;
    esac
else
    echo -e "\t\t\t${GREEN}already installed${UNCOLOR}";
fi

# download latest dotfiles
echo -n "downloading latest dotfiles"

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
        0) echo -e "\t\t${GREEN}updated local dotfiles (${DOTFILES_PATH}) from origin${UNCOLOR}";;
        *) echo -e "\n\t${RED}${ERROR}${UNCOLOR}";;
    esac
else
    ERROR=$(
        set -e
        cd ${DOTFILES_DIR} 2>&1 >/dev/null
        git clone git@github.com:jnathanh/dotfiles.git 2>&1 >/dev/null
    )

    case $? in
        0) echo -e "\t\t${GREEN}downloaded to ${DOTFILES_PATH}${UNCOLOR}";;
        *) echo -e "\n\t${RED}${ERROR}${UNCOLOR}";;
    esac
fi

# continue with bootstrap.sh
${DOTFILES_PATH}/bootstrap.sh

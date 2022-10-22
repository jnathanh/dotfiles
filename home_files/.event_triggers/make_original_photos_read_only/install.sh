#!/usr/bin/env bash

RED='\033[0;31m'
UNFMT='\033[0m'

SCRIPT_NAME="set-raw-photos-to-readonly"

# log the command and location of failures
set -eE -o functrace
failure() {
  local lineno=$1
  local msg=$2
  >&2 echo -e "${RED}Error:${UNFMT} Failed at $3:$lineno: $msg"
  echo "Failed at $3:$lineno: $msg" > $HOME/Desktop/install_${SCRIPT_NAME}_error.txt
}
trap 'failure ${LINENO} "$BASH_COMMAND" "$BASH_SOURCE"' ERR

# get current location to reference project-relative files
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# link plist in user launch path so it is loaded on login
PLIST_SOURCE_PATH="$SCRIPT_DIR/main.plist"
LABEL=$(defaults read $PLIST_SOURCE_PATH Label)
LAUNCH_PATH=$HOME/Library/LaunchAgents/$LABEL.plist
[ -f "$LAUNCH_PATH" ] && rm $LAUNCH_PATH
ln -s $PLIST_SOURCE_PATH $LAUNCH_PATH

# add main.sh to user bin folder (not dependent on repo location)
BIN_PATH="$HOME/bin/$SCRIPT_NAME"
[ -f "$BIN_PATH" ] && rm $BIN_PATH
ln -s $SCRIPT_DIR/main.sh $BIN_PATH

# unload previously installed versions of plist from launchd
launchctl list | grep $LABEL > /dev/null && launchctl unload $LAUNCH_PATH

# load current version to launchd
launchctl load $LAUNCH_PATH


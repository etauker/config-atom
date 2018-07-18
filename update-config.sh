#!/bin/bash

##
# This script installs packages and imports backed up user configuration.
# Current setup assumes atom config is stored in ~/.atom.
##

# Script variables
RESET="$(tput sgr0)"
GREEN="${RESET}\033[38;5;10m"
YELLOW="${RESET}\033[38;5;11m"
read -p 'Install packages (may take a while)? (y/n): ' install
configDir="~/.atom"

# Install packages
if [ $install = "y" ]
then
    echo -e "${YELLOW}Installing Atom packages...${RESET}"
    apm install --packages-file packages.list
    echo -e "${GREEN}Atom package install complete.${RESET}"
fi

# Copy config files to ~/.atom
echo -e "${YELLOW}Atom config import in progress...${RESET}"
echo "-- Importing ${configDir}/config.cson"
eval "cp ./atom/config.cson ${configDir}/config.cson "
echo "-- Importing ${configDir}/helpers.js"
eval "cp ./atom/helpers.js ${configDir}/helpers.js "
echo "-- Importing ${configDir}/init.coffee"
eval "cp ./atom/init.coffee ${configDir}/init.coffee "
echo "-- Importing ${configDir}/keymap.cson"
eval "cp ./atom/keymap.cson ${configDir}/keymap.cson "
echo "-- Importing ${configDir}/snippets.cson"
eval "cp ./atom/snippets.cson ${configDir}/snippets.cson "
echo "-- Importing ${configDir}/styles.less"
eval "cp ./atom/styles.less ${configDir}/styles.less "
echo -e "${GREEN}Atom config import complete.${RESET}"

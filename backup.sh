#!/bin/bash

# This script creates a list of installed packages and
# backs up user configuration files from ~/.atom

# Script variables
RESET="$(tput sgr0)"
GREEN="${RESET}\033[38;5;10m"
YELLOW="${RESET}\033[38;5;11m"
read -p 'Commit files after backup? (y/n): ' commit
configDir="~/.atom"
currentDate=`date '+%d-%m-%Y %H:%M'`
commitMessage="Configuration backup on $currentDate"

# Begin backup
echo -e "${YELLOW}Atom configuration backup in progress...${RESET}"

# Make a list of installed packages
echo "-- Exporting installed package list"
apm list --installed --bare > packages.list

# Copy config files from ~/.atom
echo "-- Backing up ${configDir}/config.cson"
eval "cp ${configDir}/config.cson ./atom/config.cson"
echo "-- Backing up ${configDir}/helpers.js"
eval "cp ${configDir}/helpers.js ./atom/helpers.js"
echo "-- Backing up ${configDir}/init.coffee"
eval "cp ${configDir}/init.coffee ./atom/init.coffee"
echo "-- Backing up ${configDir}/keymap.cson"
eval "cp ${configDir}/keymap.cson ./atom/keymap.cson"
echo "-- Backing up ${configDir}/snippets.cson"
eval "cp ${configDir}/snippets.cson ./atom/snippets.cson"
echo "-- Backing up ${configDir}/styles.less"
eval "cp ${configDir}/styles.less ./atom/styles.less"

echo -e "${GREEN}Atom configuration backup complete.${RESET}"

# Commit the changes made to source control
if [ $commit = "y" ]
then
    echo -e "${YELLOW}Committing to source control...${RESET}"
    git add ./
    git commit -m "$commitMessage"
    echo -e "${GREEN}Committed with message: $commitMessage ${RESET}"
fi

#!/bin/bash

# Styling variables
RESET="$(tput sgr0)"
GREEN="${RESET}\033[38;5;10m"
YELLOW="${RESET}\033[38;5;11m"
GREY="${RESET}\e[37m"

# Prints help page
if [[ $@ = *"-h"* || $@ = *"--help"* ]]; then
    echo -e "   ${GREY}"
    echo -e "   This script creates a list of installed packages and backs up user configuration files from ~/.atom."
    echo -e "   ${RESET}"

    echo -e "   ${YELLOW}   -h, --help ${RESET}     Prints this message."
    echo -e "   ${YELLOW}   -c, --commit ${RESET}   Commits the files after a backup."
    echo -e "   ${YELLOW}   -p, --push ${RESET}     Pushes the files after a backup. Only works if -c option is also given."
fi

# Begin backup
if [[ $@ != *"-h"* ]]; then
    echo -e "${YELLOW}Atom configuration backup in progress...${RESET}"

    # Script variables
    configDir="~/.atom"
    currentDate=`date '+%d-%m-%Y %H:%M'`
    commitMessage="Configuration backup on $currentDate"
    remote="origin"
    branch="master"

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
fi

# Commit the changes made to source control
if [[ $@ = *"-c"* || $@ = *"--commit"* ]]; then
    echo -e "${YELLOW}Committing to source control...${RESET}"
    git add ./
    git commit -m "$commitMessage"
    echo -e "${GREEN}Committed with message: $commitMessage ${RESET}"

    # Push changes to a remote
    if [[ $@ = *"-p"* || $@ = *"--push"* ]]; then
        echo -e "${YELLOW}Pushing to remote...${RESET}"
        git push ${remote} ${branch}
        echo -e "${GREEN}Pushed to ${remote} ${branch}.${RESET}"
    fi
fi

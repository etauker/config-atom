#!/bin/bash

# Styling variables
RESET="$(tput sgr0)"
GREEN="${RESET}\033[38;5;10m"
YELLOW="${RESET}\033[38;5;11m"
GREY="${RESET}\e[37m"

# Prints help page
if [[ $@ = *"-h"* || $@ = *"--help"* ]]; then
    echo -e "   ${GREY}"
    echo -e "   This script installs packages and imports backed up user configuration."
    echo -e "   Current setup assumes atom config is stored in ~/.atom."
    echo -e "   ${RESET}"

    echo -e "   ${YELLOW}   -h, --help ${RESET}       Prints this message."
    echo -e "   ${YELLOW}   -i, --install ${RESET}    Installs packages from package.list."
    echo -e "   ${RESET}"
fi

# Begin update
if [[ $@ != *"-h"* && $@ != *"--help"* ]]; then

    # Script variables
    RESET="$(tput sgr0)"
    GREEN="${RESET}\033[38;5;10m"
    YELLOW="${RESET}\033[38;5;11m"
    configDir="~/.atom"

    # Install packages
    if [[ $@ = *"-i"* || $@ = *"--install"* ]]; then
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
fi

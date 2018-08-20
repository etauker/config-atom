#!/bin/bash

# Styling variables
RESET="$(tput sgr0)"
RED="${RESET}\033[38;5;1m"
GREEN="${RESET}\033[38;5;10m"
YELLOW="${RESET}\033[38;5;11m"
GREY="${RESET}\e[37m"

# Prints help page
if [[ $@ = *"-h"* || $@ = *"--help"* ]]; then
    echo -e "   ${GREY}"
    echo -e "   This script installs atom and apm."
    echo -e "   ${RESET}"

    echo -e "   ${YELLOW}   -h, --help ${RESET}    Prints this message."
    echo -e "   ${RESET}"

    echo -e "   ${YELLOW}   --os ${RESET}   The operating system of the computer on which to install atom."
    echo -e "               Accepted options: "
    echo -e "                  --os=Windows [WIP] (default)"
    echo -e "                  --os=Ubuntu [WIP]"
    echo -e "                  --os=Debian [WIP]"
    echo -e "                  --os=MacOS [WIP]"
    echo -e "   ${RESET}"

# Windows (or no os option provided)
elif [[ $@ = *"--os=Windows"* || $@ != *"--os="* ]]; then
    echo -e "${RED}Atom installation on Windows is currently not supported.${RESET}"

    # echo -e "${YELLOW}Atom download in progress...${RESET}"
    # echo -e "${GREEN}Atom download complete.${RESET}"

    # echo -e "${YELLOW}Atom installation in progress...${RESET}"
    # echo -e "${GREEN}Atom installation complete.${RESET}"

# Debian or Ubuntu
elif [[ $@ = *"--os=Debian"* || $@ = *"--os=Ubuntu"* ]]; then
    echo -e "${YELLOW}Atom download in progress...${RESET}"
    eval "curl -sL https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -"
    eval "sudo sh -c 'echo \"deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main\" > /etc/apt/sources.list.d/atom.list'"
    eval "sudo apt-get update"
    echo -e "${GREEN}Atom download complete.${RESET}"

    echo -e "${YELLOW}Atom installation in progress...${RESET}"
    eval "sudo DEBIAN_FRONTEND=noninteractive apt-get -yq install atom"
    echo -e "${GREEN}Atom installation complete.${RESET}"

# MacOS
elif [[ $@ = *"--os=macOS"* ]]; then
    echo -e "${RED}Atom installation on macOS is currently not supported.${RESET}"

    # echo -e "${YELLOW}Atom download in progress...${RESET}"
    # echo -e "${GREEN}Atom download complete.${RESET}"

    # echo -e "${YELLOW}Atom installation in progress...${RESET}"
    # echo -e "${GREEN}Atom installation complete.${RESET}"

# Unsupported platform provided
else
    echo -e "${RED}Atom installation is currently not supported on the provided os.${RESET}"
fi

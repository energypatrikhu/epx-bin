#!/bin/bash

source "${EPX_HOME}/helpers/colorize.sh"
source "${EPX_HOME}/helpers/colors.sh"

# check if Python is installed
if ! command -v python3 &>/dev/null; then
  echo -e "[$(_c LIGHT_BLUE "Python - Install")] $(_c LIGHT_RED "Python is not installed")"
  return 1
fi

# if no arguments are provided, install from requirements.txt
if [ -z ${1} ]; then
  # check if requirements.txt exists
  if [ ! -f requirements.txt ]; then
    echo -e "[$(_c LIGHT_BLUE "Python - Install")] $(_c LIGHT_YELLOW "requirements.txt") $(_c LIGHT_RED "not found")"
    return 1
  fi

  # install dependencies
  echo -e "[$(_c LIGHT_BLUE "Python - Install")] Installing dependencies"
  pip install -r requirements.txt
  return 0
fi

# install package
packages=$(printf "%s, " "${@}" | sed 's/, $//')
echo -e "[$(_c LIGHT_BLUE "Python - Install")] Installing $(_c LIGHT_YELLOW "${packages}")"
pip install "${@}"

# check if installation was successful, then add to requirements.txt, line by line
if [ $? -eq 0 ]; then
  for package in "${@}"; do
    echo "${package}" >>requirements.txt
  done
fi

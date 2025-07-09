#!/bin/bash

source "${EPX_HOME}/helpers/colorize.sh"
source "${EPX_HOME}/helpers/colors.sh"

echo -e "[$(_c LIGHT_BLUE "Python - Help")]"
echo -e "  $(_c CYAN "Commands:")"
echo -e "    $(_c LIGHT_CYAN "py.create") - Create a new Python project or environment"
echo -e "    $(_c LIGHT_CYAN "py.install") - Install Python packages"
echo -e "    $(_c LIGHT_CYAN "py.pm2") - Manage Python processes with PM2"
echo -e "    $(_c LIGHT_CYAN "py.remove") - Remove Python packages or environments"
echo -e "    $(_c LIGHT_CYAN "py.venv") - Manage Python virtual environments"
echo -e "    $(_c LIGHT_CYAN "py.help") - Display this help message"
echo -e "  $(_c CYAN "Aliases:")"
echo -e "    $(_c LIGHT_CYAN "py") - Python"
echo -e "    $(_c LIGHT_CYAN "py3") - Python3"

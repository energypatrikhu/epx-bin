#!/bin/bash

source "$EPX_HOME/helpers/colorize.sh"
source "$EPX_HOME/helpers/colors.sh"

echo -e "[$(_c LIGHT_BLUE "Common - Help")]"
echo -e "  $(_c CYAN "Commands:")"
echo -e "    $(_c LIGHT_CYAN "archive") - Archive files or directories"
echo -e "    $(_c LIGHT_CYAN "unarchive") - Unarchive files or directories"
echo -e "    $(_c LIGHT_CYAN "zst") - Zstandard compression commands"
echo -e "    $(_c LIGHT_CYAN "unzst") - Zstandard decompression commands"
echo -e "    $(_c LIGHT_CYAN "copy") - Copy files or directories"
echo -e "    $(_c LIGHT_CYAN "move") - Move files or directories"
echo -e "    $(_c LIGHT_CYAN "du-all") - Docker update all containers"
echo -e "    $(_c LIGHT_CYAN "dcu") - Docker Compose up command"

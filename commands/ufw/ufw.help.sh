#!/bin/bash

source "$EPX_HOME/helpers/colorize.sh"
source "$EPX_HOME/helpers/colors.sh"

echo -e "[$(_c LIGHT_BLUE "UFW - Help")]"
echo -e "  $(_c CYAN "Commands:")"
echo -e "    $(_c LIGHT_CYAN "ufw.add") - Add a firewall rule"
echo -e "    $(_c LIGHT_CYAN "ufw.del") - Delete a firewall rule"
echo -e "    $(_c LIGHT_CYAN "ufw.list") - List firewall rules"
echo -e "    $(_c LIGHT_CYAN "ufw.help") - Display this help message"

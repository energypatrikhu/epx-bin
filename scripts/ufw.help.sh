#!/bin/bash

# source: /storage/scripts/shell/epx-bin/helpers/colorize.sh
_c() {
  local color="$1"
  local text="$2"

  for key in "${!EPX_COLORS[@]}"; do
    if [[ "$color" == "$key" ]]; then
      text="${EPX_COLORS[$key]}$text${EPX_COLORS[NC]}"
      break
    fi
  done

  echo -e "$text"
}

# source: /storage/scripts/shell/epx-bin/helpers/colors.sh
declare -A EPX_COLORS
EPX_COLORS=(
  ["LIGHT_BLUE"]="\033[1;34m"
  ["LIGHT_GREEN"]="\033[1;32m"
  ["LIGHT_RED"]="\033[1;31m"
  ["LIGHT_YELLOW"]="\033[1;33m"
  ["LIGHT_CYAN"]="\033[1;36m"
  ["LIGHT_PURPLE"]="\033[1;35m"
  ["LIGHT_GRAY"]="\033[1;30m"
  ["DARK_GRAY"]="\033[0;30m"
  ["RED"]="\033[0;31m"
  ["GREEN"]="\033[0;32m"
  ["BROWN"]="\033[0;33m"
  ["BLUE"]="\033[0;34m"
  ["PURPLE"]="\033[0;35m"
  ["CYAN"]="\033[0;36m"
  ["WHITE"]="\033[0;37m"
  ["NC"]="\033[0m" # No color
)


echo -e "[$(_c LIGHT_BLUE "UFW - Help")]"
echo -e "  $(_c CYAN "Commands:")"
echo -e "    $(_c LIGHT_CYAN "ufw.add") - Add a firewall rule"
echo -e "    $(_c LIGHT_CYAN "ufw.del") - Delete a firewall rule"
echo -e "    $(_c LIGHT_CYAN "ufw.list") - List firewall rules"
echo -e "    $(_c LIGHT_CYAN "ufw.help") - Display this help message"

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


echo -e "[$(_c LIGHT_BLUE "Docker - Help")]"
echo -e "  $(_c CYAN "Commands:")"
echo -e "    $(_c LIGHT_CYAN "d.attach") - Attach to a running container"
echo -e "    $(_c LIGHT_CYAN "d.compose") - Docker Compose commands"
echo -e "    $(_c LIGHT_CYAN "d.exec") - Execute a command in a container"
echo -e "    $(_c LIGHT_CYAN "d.help") - Display this help message"
echo -e "    $(_c LIGHT_CYAN "d.inspect") - Inspect a container or image"
echo -e "    $(_c LIGHT_CYAN "d.list") - List all containers"
echo -e "    $(_c LIGHT_CYAN "d.logs") - View logs of a container"
echo -e "    $(_c LIGHT_CYAN "d.make") - Build images or containers"
echo -e "    $(_c LIGHT_CYAN "d.network") - Manage Docker networks"
echo -e "    $(_c LIGHT_CYAN "d.prune") - Prune unused Docker objects"
echo -e "    $(_c LIGHT_CYAN "d.remove") - Remove containers or images"
echo -e "    $(_c LIGHT_CYAN "d.restart") - Restart a container"
echo -e "    $(_c LIGHT_CYAN "d.shell") - Open a shell in a container"
echo -e "    $(_c LIGHT_CYAN "d.start") - Start a container"
echo -e "    $(_c LIGHT_CYAN "d.stats") - Display stats of a container"
echo -e "    $(_c LIGHT_CYAN "d.stop") - Stop a container"
echo -e "    $(_c LIGHT_CYAN "d.up") - Start services with Docker Compose"
echo -e "  $(_c CYAN "Aliases:")"
echo -e "    $(_c LIGHT_CYAN "d") - Docker"
echo -e "    $(_c LIGHT_CYAN "dc") - Docker Compose"

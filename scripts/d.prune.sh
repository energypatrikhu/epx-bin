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


if [[ -z $1 ]]; then
  echo -e "[$(_c LIGHT_BLUE "Docker - Prune")] $(_c LIGHT_YELLOW "Usage: d.prune <all / images / containers / volumes / networks> [options]")"
  exit
fi

args=("$@")

case $1 in
all)
  echo -e "[$(_c LIGHT_BLUE "Docker - Prune")] $(_c LIGHT_CYAN "Pruning all unused Docker resources...")"
  docker system prune --all --volumes ${args[@]:1}
  ;;
images)
  echo -e "[$(_c LIGHT_BLUE "Docker - Prune")] $(_c LIGHT_CYAN "Pruning unused Docker images...")"
  docker image prune --all ${args[@]:1}
  ;;
containers)
  echo -e "[$(_c LIGHT_BLUE "Docker - Prune")] $(_c LIGHT_CYAN "Pruning stopped Docker containers...")"
  docker container prune ${args[@]:1}
  ;;
volumes)
  echo -e "[$(_c LIGHT_BLUE "Docker - Prune")] $(_c LIGHT_CYAN "Pruning unused Docker volumes...")"
  docker volume prune ${args[@]:1}
  ;;
networks)
  echo -e "[$(_c LIGHT_BLUE "Docker - Prune")] $(_c LIGHT_CYAN "Pruning unused Docker networks...")"
  docker network prune ${args[@]:1}
  ;;
*)
  echo -e "[$(_c LIGHT_BLUE "Docker - Prune")] $(_c LIGHT_RED "Unknown option: $1")"
  exit 1
  ;;
esac

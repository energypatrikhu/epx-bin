# source: /storage/scripts/shell/epx-bin/commands/docker/d.remove.sh
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
  echo -e "[$(_c LIGHT_BLUE "Docker - Remove")] $(_c LIGHT_YELLOW "Usage: d.rm <all / container>")"
  exit
fi

if [[ $1 == "all" ]]; then
  echo -e "[$(_c LIGHT_BLUE "Docker - Remove")] $(_c LIGHT_RED "Removing all containers...")"
  docker rm -f $(docker ps -aq) >/dev/null 2>&1
  echo -e "[$(_c LIGHT_BLUE "Docker - Remove")] $(_c LIGHT_RED "All containers removed")"
else
  if [ $# -eq 1 ]; then
    container_text="Container"
  else
    container_text="Containers"
  fi
  containers=$(printf "%s, " "$@" | sed 's/, $//')

  echo -e "[$(_c LIGHT_BLUE "Docker - Remove")] $container_text $(_c LIGHT_BLUE "$containers") $(_c LIGHT_RED "removing...")"
  docker rm -f "$@" >/dev/null 2>&1
  echo -e "[$(_c LIGHT_BLUE "Docker - Remove")] $container_text $(_c LIGHT_BLUE "$containers") $(_c LIGHT_RED "removed")"
fi


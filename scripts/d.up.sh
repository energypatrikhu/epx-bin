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


pull=false

if [[ $1 = "--help" ]] || [[ $1 = "-h" ]]; then
  echo -e "[$(_c LIGHT_BLUE "Docker - Up")] $(_c LIGHT_YELLOW "Usage: d.up [all / [container1, container2, ...]]")"
  exit
fi

if [[ $1 = "--pull" ]] || [[ $1 = "-p" ]]; then
  pull=true
fi

if [ "$1" = "all" ]; then
  if [[ ! -f "$EPX_HOME/.config/d.up.config" ]]; then
    echo -e "[$(_c LIGHT_BLUE "Docker - Up")] $(_c LIGHT_RED "Config file not found, please create one at $EPX_HOME/.config/d.up.config")"
    exit
  fi

  . "$EPX_HOME/.config/d.up.config"

  for d in "$CONTAINERS_DIR"/*; do
    if [ -d "$d" ]; then
      if [[ -f "$d/docker-compose.yml" ]]; then
        d.up "$(basename -- "$d")"
      fi
    fi
  done
  exit
fi

# check if container name is provided
if [[ -n $* ]]; then
  if [[ ! -f "$EPX_HOME/.config/d.up.config" ]]; then
    echo -e "[$(_c LIGHT_BLUE "Docker - Up")] $(_c LIGHT_RED "Config file not found, please create one at $EPX_HOME/.config/d.up.config")"
    exit
  fi

  . "$EPX_HOME/.config/d.up.config"

  for c in "$@"; do
    dirname="$CONTAINERS_DIR/$c"

    if [[ ! -f "$dirname/docker-compose.yml" ]]; then
      echo -e "[$(_c LIGHT_BLUE "Docker - Up")] $(_c LIGHT_RED "docker-compose.yml not found in $dirname")"
      exit
    fi

    if [ "$pull" = true ]; then
      docker compose -f "$dirname/docker-compose.yml" pull
    fi
    docker compose -p "$c" -f "$dirname/docker-compose.yml" up -d
    echo -e ""
  done
  exit
fi

# if nothing is provided, just start compose file in current directory
if [[ ! -f "docker-compose.yml" ]]; then
  echo -e "[$(_c LIGHT_BLUE "Docker - Up")] $(_c LIGHT_RED "docker-compose.yml not found in current directory")"
  exit
fi

fbasename=$(basename -- "$(pwd)")

if [ "$pull" = true ]; then
  docker compose -f docker-compose.yml pull
fi
docker compose -p "$fbasename" -f docker-compose.yml up -d
echo -e ""

# if [[ -f "$EPX_HOME/.config/d.up.config" ]]; then
#   _d.up_autocomplete() {
#     . "$EPX_HOME/.config/d.up.config"
#     . "$EPX_HOME/commands/docker/_autocomplete.sh"

#     container_dirs=()
#     for d in "$CONTAINERS_DIR"/*; do
#       if [ -d "$d" ]; then
#         if [[ -f "$d/docker-compose.yml" ]]; then
#           container_dirs+=("$(basename -- "$d")")
#         fi
#       fi
#     done

#     _autocomplete "${container_dirs[@]}"
#   }
#   complete -F _d.up_autocomplete d.up
# fi

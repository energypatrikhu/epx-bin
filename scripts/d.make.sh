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
  echo -e "[$(_c LIGHT_BLUE "Docker - Make")] $(_c LIGHT_YELLOW "Usage: d.mk <interpreter>")"
  exit
fi

interpreter="$1"

if [[ ! -f "$EPX_HOME/.templates/docker/dockerfile/$interpreter.template" ]]; then
  echo -e "[$(_c LIGHT_RED "Docker - Make")] $(_c LIGHT_YELLOW "Template for interpreter '$interpreter' not found.")"
  exit
fi

if [[ -f Dockerfile ]]; then
  echo -e "[$(_c LIGHT_RED "Docker - Make")] $(_c LIGHT_YELLOW "Dockerfile already exists. Please remove it before creating a new one.")"
  exit
fi

if ! cp -f "$EPX_HOME/.templates/docker/dockerfile/$interpreter.template" Dockerfile >/dev/null 2>&1; then
  echo -e "[$(_c LIGHT_RED "Docker - Make")] $(_c LIGHT_YELLOW "Failed to copy template for interpreter '$interpreter'.")"
  exit
fi

echo -e "[$(_c LIGHT_BLUE "Docker - Make")] $(_c LIGHT_GREEN "Dockerfile created from template for interpreter '$interpreter'.")"

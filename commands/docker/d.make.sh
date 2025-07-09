#!/bin/bash

source "$EPX_HOME/helpers/colorize.sh"
source "$EPX_HOME/helpers/colors.sh"

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

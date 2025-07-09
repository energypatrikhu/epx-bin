#!/bin/bash

source "$EPX_HOME/helpers/colorize.sh"
source "$EPX_HOME/helpers/colors.sh"

if [[ -z $1 ]]; then
  echo -e "[$(_c LIGHT_BLUE "Docker - Inspect")] $(_c LIGHT_YELLOW "Usage: d.inspect <container>")"
  exit
fi

docker inspect "$@"

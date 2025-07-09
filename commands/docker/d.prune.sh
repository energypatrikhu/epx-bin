#!/bin/bash

source "$EPX_HOME/helpers/colorize.sh"
source "$EPX_HOME/helpers/colors.sh"

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

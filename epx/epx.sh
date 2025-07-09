#!/bin/bash

source "$EPX_HOME/helpers/colorize.sh"
source "$EPX_HOME/helpers/colors.sh"

EPX_COMMANDS=()
for file in "$EPX_HOME"/commands/epx/utils/*.sh; do
  EPX_COMMANDS+=("$(basename "$file" .sh)")
done

declare -A EPX_UTILS
EPX_UTILS["self-update"]="Update the EPX CLI to the latest version"
EPX_UTILS["update-bees"]="Update bees to the latest version"
EPX_UTILS["backup"]="Backup files or directories | <input path> <output path> <backups to keep> [excluded directories,files separated with (,)]"

COMMAND=$1
ARGS=("${@:2}")

for cmd in "${EPX_COMMANDS[@]}"; do
  if [[ "_$COMMAND" == "$cmd" ]]; then
    source "$EPX_HOME/commands/epx/utils/${cmd}.sh" "${ARGS[@]}"
    exit
  fi
done

echo -e "[$(_c LIGHT_BLUE "EPX")] $(_c LIGHT_YELLOW "Usage: epx <command> [args]")"
echo -e "  $(_c CYAN "Commands:")"
for cmd in "${!EPX_UTILS[@]}"; do
  entry="${EPX_UTILS[$cmd]}"
  desc=$(echo "$entry" | awk -F'|' '{print $1}' | xargs)
  usage=$(echo "$entry" | awk -F'|' '{print $2}' | xargs)
  echo -e "    $(_c LIGHT_CYAN "$cmd") - $desc"
  if [[ -n "$usage" ]]; then
    echo -e "      $(_c LIGHT_YELLOW "Usage:") epx $cmd $usage"
  fi
done

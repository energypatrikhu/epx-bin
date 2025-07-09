#!/bin/bash

. "$EPX_HOME"/helpers/autocomplete.sh

_d_autocomplete() {
  _autocomplete "$(docker ps -a --format '{{.Names}}')"
}
complete -F _d_autocomplete d.attach
complete -F _d_autocomplete d.exec
complete -F _d_autocomplete d.inspect
complete -F _d_autocomplete d.i
complete -F _d_autocomplete d.logs
complete -F _d_autocomplete d.log
complete -F _d_autocomplete d.shell

_d_autocomplete_all() {
  _autocomplete "all $(docker ps -a --format '{{.Names}}')"
}
complete -F _d_autocomplete_all d.remove
complete -F _d_autocomplete_all d.rm
complete -F _d_autocomplete_all d.restart
complete -F _d_autocomplete_all d.start
complete -F _d_autocomplete_all d.stats
complete -F _d_autocomplete_all d.stat
complete -F _d_autocomplete_all d.stop

_d_autocomplete_list() {
  _autocomplete "created restarting running removing paused exited dead"
}
complete -F _d_autocomplete_list d.list
complete -F _d_autocomplete_list d.ls

_d_autocomplete_prune() {
  _autocomplete "all images containers volumes networks"
}
complete -F _d_autocomplete_prune d.prune

_d_autocomplete_templates() {
  local available_templates="$(find "$EPX_HOME"/.templates/docker/dockerfile -maxdepth 1 -type f -name '*.template' -exec basename {} .template \; | tr '\n' ' ')"
  _autocomplete "$available_templates"
}
complete -F _d_autocomplete_templates d.make
complete -F _d_autocomplete_templates d.mk

_d.up_autocomplete() {
  . "$EPX_HOME/.config/d.up.config"

  container_dirs=()
  for d in "$CONTAINERS_DIR"/*; do
    if [ -d "$d" ]; then
      if [[ -f "$d/docker-compose.yml" ]]; then
        container_dirs+=("$(basename -- "$d")")
      fi
    fi
  done

  _autocomplete "${container_dirs[@]}"
}
if [[ -f "$EPX_HOME/.config/d.up.config" ]]; then
  complete -F _d.up_autocomplete d.up
fi

#!/bin/bash

. "$EPX_HOME"/helpers/autocomplete.sh

_load_autocomplete() {
  for element in "$1"/*; do
    if [[ -d "$element" ]]; then
      _load_autocomplete "$element"
      continue
    fi

    if [[ -f "$element" ]] && [[ "$element" == *.sh ]]; then
      if [[ "$element" == *"_autocomplete.sh" ]]; then
        source "$element"
      fi
    fi
  done
}
_load_autocomplete "$EPX_HOME/commands"

_epx_completions() {
  _autocomplete "self-update update-bees backup"
}
complete -F _epx_completions epx

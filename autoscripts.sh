#!/bin/bash

_load_auto() {
  for element in "${1}"/*; do
    if [[ -d "${element}" ]]; then
      _load_auto "${element}"
      continue
    fi

    if [[ -f "${element}" ]] && [[ "${element}" == *.sh ]]; then
      if [[ "${element}" == *"_auto."*.sh ]]; then
        source "${element}"
      fi
    fi
  done
}
_load_auto "${EPX_HOME}/commands"

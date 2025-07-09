#!/bin/bash

_load_aliases() {
  for element in "${1}"/*; do
    if [[ -d "${element}" ]]; then
      _load_aliases "${element}"
      continue
    fi

    if [[ -f "${element}" ]] && [[ "${element}" == *.sh ]]; then
      if [[ "${element}" == *"_alias.sh" ]]; then
        source "${element}"
      fi
    fi
  done
}
_load_aliases "${EPX_HOME}/commands"

alias ff='fastfetch'

alias c='clear'

alias gtop='nvidia-smi'

alias ls='ls -lah'
alias rm='rm -rfvI'
alias cp='cp -fvir'
alias mv='mv -fvi'

alias lock='chattr +i'
alias unlock='chattr -i'

alias freeze='chattr +a'
alias unfreeze='chattr -a'

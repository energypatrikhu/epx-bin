#!/bin/bash

source "$EPX_HOME/commands/game-servers/minecraft/_helpers.sh"

__epx-mc-list-configs() {
  _autocomplete "$(__epx-mc-get-configs "$1")"
}
complete -F __epx-mc-list-configs mc

__epx-mc-list-configs-examples() {
  _autocomplete "$(__epx-mc-get-configs-examples "$1")"
}
complete -F __epx-mc-list-configs-examples mc.create

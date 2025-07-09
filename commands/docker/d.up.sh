#!/bin/bash

source "${EPX_HOME}/helpers/colorize.sh"
source "${EPX_HOME}/helpers/colors.sh"

if [[ ${1} = "--help" ]] || [[ ${1} = "-h" ]]; then
  echo -e "[$(_c LIGHT_BLUE "Docker - Up")] $(_c LIGHT_YELLOW "Usage: d.up [all / [container1, container2, ...]]")"
  exit
fi

pull=false
if [[ ${1} = "--pull" ]] || [[ ${1} = "-p" ]]; then
  pull=true
fi

if [ ${1} = "all" ]; then
  if [[ ! -f "${EPX_HOME}/.config/d.up.config" ]]; then
    echo -e "[$(_c LIGHT_BLUE "Docker - Up")] $(_c LIGHT_RED "Config file not found, please create one at ${EPX_HOME}/.config/d.up.config")"
    exit
  fi

  . "${EPX_HOME}/.config/d.up.config"

  for d in "${CONTAINERS_DIR}"/*; do
    if [ -d "${d}" ]; then
      if [[ -f "${d}/docker-compose.yml" ]]; then
        d.up "$(basename -- "${d}")"
      fi
    fi
  done
  exit
fi

# check if container name is provided
if [[ -n $* ]]; then
  if [[ ! -f "${EPX_HOME}/.config/d.up.config" ]]; then
    echo -e "[$(_c LIGHT_BLUE "Docker - Up")] $(_c LIGHT_RED "Config file not found, please create one at ${EPX_HOME}/.config/d.up.config")"
    exit
  fi

  . "${EPX_HOME}/.config/d.up.config"

  for c in "${@}"; do
    dirname="${CONTAINERS_DIR}/${c}"

    if [[ ! -f "${dirname}/docker-compose.yml" ]]; then
      echo -e "[$(_c LIGHT_BLUE "Docker - Up")] $(_c LIGHT_RED "docker-compose.yml not found in ${dirname}")"
      exit
    fi

    if [ "${pull}" = true ]; then
      docker compose -f "${dirname}/docker-compose.yml" pull
    fi
    docker compose -p "${c}" -f "${dirname}/docker-compose.yml" up -d
    echo -e ""
  done
  exit
fi

# if nothing is provided, just start compose file in current directory
if [[ ! -f "docker-compose.yml" ]]; then
  echo -e "[$(_c LIGHT_BLUE "Docker - Up")] $(_c LIGHT_RED "docker-compose.yml not found in current directory")"
  exit
fi

fbasename=$(basename -- "$(pwd)")

if [ "${pull}" = true ]; then
  docker compose -f docker-compose.yml pull
fi
docker compose -p "${fbasename}" -f docker-compose.yml up -d
echo -e ""

# if [[ -f "${EPX_HOME}/.config/d.up.config" ]]; then
#   _d.up_autocomplete() {
#     . "${EPX_HOME}/.config/d.up.config"
#     . "${EPX_HOME}/commands/docker/_autocomplete.sh"

#     container_dirs=()
#     for d in "${CONTAINERS_DIR}"/*; do
#       if [ -d "${d}" ]; then
#         if [[ -f "${d}/docker-compose.yml" ]]; then
#           container_dirs+=("$(basename -- "${d}")")
#         fi
#       fi
#     done

#     _autocomplete "${container_dirs[@]}"
#   }
#   complete -F _d.up_autocomplete d.up
# fi

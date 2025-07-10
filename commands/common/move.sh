#!/bin/bash

if [ $# -eq 0 ]; then
  echo -e "No input files"
  exit 1
fi

time rsync -rxzvuahP --remove-source-files --stats "${@}" && find "${1}" -type d -empty -delete

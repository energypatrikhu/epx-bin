#!/bin/bash

[ "$#" -eq 0 ] && echo -e "No input files" && return

time rsync -rxzvuahP --remove-source-files --stats "${@}" && find ${1} -type d -empty -delete

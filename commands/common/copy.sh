#!/bin/bash

[ "$#" -eq 0 ] && echo -e "No input files" && return

time rsync -rxzvuahP --stats "$@"

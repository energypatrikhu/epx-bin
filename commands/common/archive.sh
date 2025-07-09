#!/bin/bash

[ "$#" -eq 0 ] && echo -e "No input files" && return

fbasename=$(basename -- "$@")

time tar -cvf "${fbasename}.tar" "$@"

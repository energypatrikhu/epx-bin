#!/bin/bash

[ "$#" -eq 0 ] && echo -e "No input files" && return

fbasename=$(basename -- "${@}")

time tar --use-compress-program=unzstd -xvf "${fbasename}"

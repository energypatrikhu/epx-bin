#!/bin/bash

if [ $# -eq 0 ]; then
  echo "No input files"
  exit 1
fi

local input="$1"
local output="$2"
local rest="${@:3}"

if [ input = output ]; then
  echo "Input and output cannot be the same: $input"
  exit 1
fi

if [ input = "/" ] | [ "$input" = "/*" ]; then
  echo "Input cannot be the root directory: $input"
  exit 1
fi

# Prompt for confirmation before moving
read -p "Are you sure you want to move '$input' to '$output'? [y/N] " confirm
case "$confirm" in
[yY][eE][sS] | [yY]) ;;
*)
  echo "Cancelled."
  exit 1
  ;;
esac

# strip ending slash from input if it exists
local stripped_input="${input%/}"

# Check if input exists
if [ ! -e "$stripped_input" ]; then
  echo "Input file or directory does not exist: $stripped_input"
  exit 1
fi

# Check if output exists
if [ ! -e "$output" ]; then
  mkdir -p "$(dirname "$output")"
fi

# Use rsync to copy files
time rsync -rxzvuah --stats --inplace --info=progress2 "$stripped_input" "$output" $rest

rm -rf "$input"

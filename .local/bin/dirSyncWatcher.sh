#!/usr/bin/env bash

SRC_DIR=$1
DST_DIR=$2

#Functions
validate_dir() {
  if [ ! -d "$1" ]; then
    echo "Invalid directory '$1'"
    exit 9999
  fi
}
validate_bin() {
  if ! command -v $1 &> /dev/null; then
    echo "Missing command '$1'"
    exit 9999
  fi
}
#############

#Validate Dirs
validate_dir "$SRC_DIR"
validate_dir "$DST_DIR"

#Test if dependencies exist
validate_bin "inotifywait"
validate_bin "rsync"

#Trailing slashes
SRC_BASE=$(realpath -s "${SRC_DIR}")
DST_BASE=$(realpath -s "${DST_DIR}")

#Initial sync
rsync -av --delete "${SRC_BASE}/" "${DST_BASE}"

#Wait loop
while true; do
  inotifywait -r -e modify,create,delete,move "${SRC_BASE}"
  sleep 1s

  validate_dir "$SRC_BASE"
  validate_dir "$DST_BASE"
  rsync -av --delete "${SRC_BASE}/" "${DST_BASE}"
done



#!/bin/bash


# get the basename of all files/dirs in the config-files dir (and not deeper), exclude 'config-files' itself from results
FIND_CMD='find ./config-files -maxdepth 1 ! -name config-files -exec basename {} ;'
NOW=$(date +'%Y-%m-%d-%H-%M-%S')
BACKUP_DIR="$HOME/.dotfiles-backup/$NOW"

mkdir -p $BACKUP_DIR
for file in $($FIND_CMD)
do
  # backup existing config files
  FILE_TO_BACKUP="$HOME/$file"
  if [ -e "$FILE_TO_BACKUP" ]; then
    mv $FILE_TO_BACKUP $BACKUP_DIR
  fi;

  # copy config-files in the home directory
  CONFIG_FILE="config-files/$file"
  cp -R $CONFIG_FILE $HOME 
done;


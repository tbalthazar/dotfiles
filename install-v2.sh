#!/bin/bash

# the directory where the dotfiles will be copied
DEST_DIR="$HOME/Downloads/tmpdotfiles"

# create a directory to backup dotfiles before copying them
NOW=$(date +'%Y-%m-%d-%H-%M-%S')
BACKUP_DIR="$DEST_DIR/.dotfiles-backup/$NOW"
mkdir -p $BACKUP_DIR

# find each file/dir in config-files
FIND_CMD='find ./config-files -maxdepth 1 ! -name config-files -exec basename {} ;'

for file in $($FIND_CMD)
do
  # backup existing config files
  FILE_TO_BACKUP="$DEST_DIR/$file"
  if [ -e "$FILE_TO_BACKUP" ]; then
    cp -R $FILE_TO_BACKUP $BACKUP_DIR
  fi;
done;

# copy all the dotfiles to the DEST_DIR
CP_CMD="cd config-files && find . -type f -exec cp --parents \{\} $DEST_DIR \;"
eval $CP_CMD

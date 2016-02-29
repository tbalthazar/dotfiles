#!/bin/bash

SESSION=$1
SOURCE_FILE=$2

tmux attach -t $SESSION || tmux new -s $SESSION \; source-file $SOURCE_FILE

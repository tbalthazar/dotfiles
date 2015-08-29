#!/bin/bash

session_name=$1
config_file_path=$2

tmux has-session -t $session_name

if [ $? != 0 ]
then
  # create
  tmux -f $config_file_path attach
else
  # attach
  tmux attach -t $session_name
fi

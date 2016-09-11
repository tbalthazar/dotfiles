#!/bin/bash

duplicity --no-encryption --exclude-filelist /home/tb/.duplicity/exclude.txt /home/tb file:///media/tb/black/backup

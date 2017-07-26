#!/bin/sh

folders="INBOX"
folders="$folders,INBOX.Sent Items"

/usr/local/bin/offlineimap -o \
                           -a Fastmail \
                           -f "$folders" \
                           -u quiet

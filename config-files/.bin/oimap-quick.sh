#!/bin/sh

folders="INBOX"
folders="$folders,Drafts"
folders="$folders,Sent Items"
folders="$folders,Archive.2018"

/usr/local/bin/offlineimap -o \
                           -a Fastmail \
                           -f "$folders" \
                           -u quiet

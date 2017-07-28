#!/bin/sh

folders="INBOX"
folders="$folders,INBOX.Drafts"
folders="$folders,INBOX.Sent Items"
folders="$folders,INBOX.Archive.2017"

/usr/local/bin/offlineimap -o \
                           -a Fastmail \
                           -f "$folders" \
                           -u quiet

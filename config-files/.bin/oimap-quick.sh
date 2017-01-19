#!/bin/sh

folders="INBOX"
folders="$folders,INBOX.Sent Items"
folders="$folders,INBOX.Rules.Lists.Neutrinet.Cube"
folders="$folders,INBOX.Rules.Lists.Neutrinet.Tech"
folders="$folders,INBOX.Rules.Lists.Neutrinet.Admin"
folders="$folders,INBOX.Rules.Lists.Neutrinet.General"
folders="$folders,INBOX.Rules.GitHub"

/usr/local/bin/offlineimap -o \
                           -a Fastmail \
                           -f "$folders" \
                           -u quiet

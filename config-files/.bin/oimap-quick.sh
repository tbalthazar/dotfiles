#!/bin/sh

folders="INBOX"
folders="$folders,INBOX.Rules.Lists.Neutrinet.Cube"
folders="$folders,INBOX.Rules.Lists.Neutrinet.Tech"

/usr/local/bin/offlineimap -o \
                           -a Fastmail \
                           -f $folders \
                           -u quiet

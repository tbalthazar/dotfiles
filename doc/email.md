# Email Setup

## GNUPG

It is used to encrypt/decrypt email credentials found in `.email-config.gpg`.
Export keys:
```
$ gpg --output new-gpg-public-key.asc --armor --export 998A50DA1D589650
$ gpg --output new-gpg-private-key.asc --armor --export-secret-key 998A50DA1D589650
```

Import keys to new system:
```
$ gpg --import new-gpg-public-key.asc
$ gpg --allow-secret-key-import --import new-gpg-private-key.asc
```

## OfflineIMAP

It syncs an IMAP inbox with local Maildirs.
It is configured in `.offlineimaprc`.
It uses a method in `.offlineimap.py` to read email config and creds from `.email-config.gpg`.

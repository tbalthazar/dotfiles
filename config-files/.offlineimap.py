#! /usr/bin/env python2
from subprocess import check_output

def get_property(path, account, property):
    # gpg -dq ~/.email-config.gpg | grep my_email_fastmail | awk '{print $4}' | tr -d '"'
    cmd = "gpg -dq " + path + " | grep my_" + property + "_" + account.lower() + " | awk '{print $4}' | tr -d '\"'"
    return check_output(cmd, shell=True).strip("\n")

# print(get_property("~/.email-config.gpg", "Perso", "email"))

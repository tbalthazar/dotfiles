#! /usr/bin/env python2
from subprocess import check_output

def get_property(path, account, property):
    # gpg2 -dq ~/.email-pwds.gpg | grep my_email_fastmail | awk '{print $4}' | tr -d '"'
    cmd = "gpg2 -dq " + path + " | grep my_" + property + "_" + account + " | awk '{print $4}' | tr -d '\"'"
    return check_output(cmd, shell=True).strip("\n")

# print(get_property("~/.email-pwds.gpg", "gandi", "email"))

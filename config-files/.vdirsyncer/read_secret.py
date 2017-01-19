#! /usr/bin/env python2

import sys
from subprocess import check_output

def get_property(path, account, property):
    # gpg2 -dq ~/.email-pwds.gpg | grep my_email_fastmail | awk '{print $4}' | tr -d '"'
    cmd = "gpg2 -dq " + path + " | grep my_" + property + "_" + account + " | awk '{print $4}' | tr -d '\"'"
    return check_output(cmd, shell=True).strip("\n")

path = sys.argv[1]
account = sys.argv[2]
property = sys.argv[3]

sys.stdout.write(get_property(path, account, property))

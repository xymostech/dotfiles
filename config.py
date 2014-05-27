#!/usr/bin/env python3

import argparse
import csv
import platform
import os 
import os.path
import subprocess

LINKS_FILE = "links.csv"

class GitError(Exception):
    pass

def git(*args, raise_on_fail=True):
    command = ["git"] + list(args)
    debug("Calling '{}'".format(" ".join(command)))
    ret = subprocess.call(command, stdout=None if VERBOSE else subprocess.DEVNULL, stderr=None if VERBOSE else subprocess.DEVNULL)
    if ret != 0:
        debug("Got error: {} calling '{}'".format(ret, " ".join(command)))
        if raise_on_fail:
            raise GitError("Git error: {} calling '{}'".format(ret, " ".join(command)))
    return ret

def get_hostname():
    hostname = platform.node()
    if hostname == "":
        raise OSError("Unknown Hostname")
    return hostname

def get_links():
    links = []
    with open(LINKS_FILE, 'r') as f:
        linksreader = csv.reader(f)
        next(linksreader, None)
        for link in linksreader:
            links.append((link[0], link[1])) 
    return links

def git_new_branch(branch):
    git("branch", branch, raise_on_fail=False)

def git_checkout_branch(branch):
    git("checkout", branch)

def git_commit_all(message):
    git("add", ".")
    git("commit", "-a", "-m", message)

def make_links():
    links = get_links()
    debug("Got links: " + str(links))
    for (src, dest) in links:
        abssrc = os.path.abspath(src)
        absdest = os.path.expanduser(dest)
        done = False
        if os.path.lexists(absdest):
            if os.stat(absdest) == os.stat(abssrc):
                done = True
                debug("'{}' already linked into place".format(absdest))
            else:
                debug("'{}' already exists!".format(absdest))
                if os.path.lexists(absdest + ".old"):
                    print("Both '{}' and '{}' exist, remove '{}' first".format(
                        absdest, absdest + ".old", absdest + ".old"))
                else:
                    print("Moving '{}' to '{}'".format(absdest, absdest + ".old"))
                    os.replace(absdest, absdest + ".old")
        if not done:
            print("Linking '{}' to '{}'".format(abssrc, absdest))
            os.symlink(abssrc, absdest)

parser = argparse.ArgumentParser(description="Manage the configuration files")
parser.add_argument('method', choices=['init'], help="Which action to take")
parser.add_argument('-v', action='store_true', help="Verbosity level")

args = parser.parse_args()

VERBOSE = args.v
debug = print if VERBOSE else lambda x: None

if args.method == 'init':
    # make new branch
    # symlink things into place
    hostname = get_hostname()
    debug("Got hostname: " + hostname)
    git_checkout_branch("master")
    git_new_branch(hostname)
    git_checkout_branch(hostname)
    debug("Made new branch: {}".format(hostname))
    make_links()

# vim: set sts=4 et sw=4:

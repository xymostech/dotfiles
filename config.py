#!/usr/bin/env python3

import argparse
import csv
import platform
import os.path
import subprocess

LINKS_FILE = "links.csv"

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
    ret = subprocess.call(["git", "branch", branch])
    if ret != 0:
        debug("Got error: {} making branch: '{}'".format(ret, branch))

def git_checkout_branch(branch):
    ret = subprocess.call(["git", "checkout", branch])
    if ret != 0:
        debug("Got error: {} checking out branch: '{}'".format(ret, branch))

def git_commit_all(message):
    subprocess.call(["git", "add", "."])
    subprocess.call(["git", "commit", "-a", "-m", message])

def make_links():
    links = get_links()
    debug("Got links: " + str(links))
    for (src, dest) in links:
        abssrc = os.path.abspath(src)
        absdest = os.path.expanduser("~/" + dest)
        debug("Linking '{}' to '{}'".format(abssrc, absdest))

parser = argparse.ArgumentParser(description="Manage the configuration files")
parser.add_argument('method', choices=['init'], help="Which action to take")
parser.add_argument('-v', action='store_true', help="Verbosity level")

args = parser.parse_args()

debug = lambda x: None
if args.v:
    debug = print

if args.method == 'init':
    # make new branch
    # symlink things into place
    hostname = get_hostname()
    debug("Got hostname: " + hostname)
    git_new_branch(hostname)
    git_checkout_branch(hostname)
    debug("Made new branch: {}".format(hostname))

# vim: set sts=4 et sw=4:

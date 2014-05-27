#!/usr/bin/env python3

import argparse
import csv
import os 
import os.path

LINKS_FILE = "links.csv"

def get_links():
    links = []
    with open(LINKS_FILE, 'r') as f:
        linksreader = csv.reader(f)
        next(linksreader, None)
        for link in linksreader:
            links.append((link[0], link[1])) 
    return links

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
parser.add_argument('-v', action='store_true', help="Verbosity level")

args = parser.parse_args()

VERBOSE = args.v
debug = print if VERBOSE else lambda x: None

make_links()

# vim: set sts=4 et sw=4:

#!/usr/bin/python
import shutil
import sys
import os
import argparse

JSON_INVENTORY = "inventory.json"


def print_list():
    if os.path.isfile(JSON_INVENTORY):
        with open(JSON_INVENTORY, "r") as f:
            shutil.copyfileobj(f, sys.stdout)
    else:
        print '{}'


def print_host(host):
    print '{}'


parser = argparse.ArgumentParser()
parser.add_argument("--list", help="print inventory in json format", action="store_true")
parser.add_argument("--host", help="print host vars in json format")
args = parser.parse_args()

if args.list:
    print_list()
elif args.host:
    print_host(args.host)

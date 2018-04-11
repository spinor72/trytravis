#!/usr/bin/python
import sys
import os
import argparse
import json
from subprocess import Popen, PIPE

# set bucket and prefix as in terrafrom gcp backend config
BUCKET = "storage-bucket-spinor-test"
PREFIX = "terraform/stage"
# out var where json stored
INVENTORY_OUT = "inventory_json"

DEBUG = False

URL_TEMPLATE = "gs://{}/{}/default.tfstate"

def print_list():
    try:
        state_loader = Popen(["gsutil", "cp", URL_TEMPLATE.format(BUCKET, PREFIX), "-"], stdout=PIPE, stderr=PIPE)
        error = state_loader.stderr.read()
        if error:
            # print error
            sys.stderr.write(error)
            sys.exit(os.EX_DATAERR)
        data = json.loads(state_loader.stdout.read())
        state_loader.stdout.close()
        outputs = next((i for i in data['modules'] if i.get('outputs') and i.get('outputs').get(INVENTORY_OUT)),
                       None)
        inventory = outputs.get('outputs').get(INVENTORY_OUT).get('value')
        inventory = json.loads(inventory)
        print json.dumps(inventory, sort_keys=True, indent=4, separators=(',', ': '))

    except ValueError:
        if DEBUG:
            sys.stderr.write("No JSON object could be decoded")
            sys.exit(os.EX_DATAERR)
        else:
            print "{}"

    except AttributeError:
        if DEBUG:
            sys.stderr.write("Inventory data invalid")
            sys.exit(os.EX_DATAERR)
        else:
            print "{}"

    except OSError:
        if DEBUG:
            sys.stderr.write("Gsutill not installed or other system error")
            sys.exit(os.EX_DATAERR)
        else:
            print "{}"



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

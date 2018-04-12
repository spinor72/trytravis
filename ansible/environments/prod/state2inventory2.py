#!/usr/bin/python
import sys
import os
import argparse
import json
from subprocess import Popen, PIPE
import ConfigParser

BUCKET = "storage-bucket-spinor-test"
PREFIX = "terraform/stage"
config = ConfigParser.SafeConfigParser({'bucket': BUCKET, 'prefix': PREFIX})
config.read(os.path.join(os.path.dirname(os.path.realpath(sys.argv[0])),'state2inventory2.cfg'))

# NoSectionError

# Set the third, optional argument of get to 1 if you wish to use raw mode.
prefix = config.get('gs', 'prefix')
bucket = config.get('gs', 'bucket')


URL_TEMPLATE = "gs://{}/{}/default.tfstate"
DEBUG = False

def load_state():
    try:
        state_loader = Popen(["gsutil", "cp", URL_TEMPLATE.format(bucket, prefix), "-"], stdout=PIPE, stderr=PIPE)
        error = state_loader.stderr.read()
        if error:
            print error
            sys.stderr.write(error)
            sys.exit(os.EX_DATAERR)
        data = json.loads(state_loader.stdout.read())
        return data

    except ValueError:
        if DEBUG:
            sys.stderr.write("No JSON object could be decoded")
            sys.exit(os.EX_DATAERR)
        else:
            return "{}"
    except OSError:
        if DEBUG:
            sys.stderr.write("Gsutill not installed or other system error")
            sys.exit(os.EX_DATAERR)
        else:
            return "{}"


def print_list(data):
    try:
        inventory = {"_meta": {"hostvars": {}}}
        hosts = (i for i in data.get('modules',[]) if i.get('resources') and i.get('resources').get('null_resource.ansible'))
        for _ in hosts:
            host = _.get('outputs')

            if host.get('name'):
                name = host.get('name').get('value')
            else:
                raise ValueError("Host name not present")
            vars = host.get('vars', {}).get('value', {})
            inventory["_meta"]["hostvars"][name] = vars

            if host.get('host'):
                ansible_host = host.get('host').get('value', '')
                inventory["_meta"]["hostvars"][name]['ansible_host'] = ansible_host
            else:
                raise ValueError("Host address not present")

            if host.get('groups'):
                for g in host.get('groups').get('value', []):
                    if g not in inventory:
                        inventory[g] = {'hosts': [], "vars": {}}
                    inventory[g]['hosts'].append(name)

        print json.dumps(inventory, sort_keys=True, indent=4, separators=(',', ': '))
    except ValueError as e:
        if DEBUG:
            sys.stderr.write(e.message)
            sys.exit(os.EX_DATAERR)
        else:
            print "{}"
    except AttributeError:
        if DEBUG:
            sys.stderr.write("Inventory data invalid")
            sys.exit(os.EX_DATAERR)
        else:
            print "{}"


def print_host(host):
    print '{}'


parser = argparse.ArgumentParser()
parser.add_argument("--list", help="print inventory in json format", action="store_true")
parser.add_argument("--host", help="print host vars in json format")
args = parser.parse_args()

state = load_state()
if args.list:
    print_list(state)
elif args.host:
    print_host(args.host)

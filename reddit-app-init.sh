#!/bin/bash
# create VM
gcloud compute instances create reddit-app \
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=./startup-script.sh

# create firewall rule
gcloud compute firewall-rules create default-puma-server \
   --allow=tcp:9292 \
   --description="Access puma server from external network" \
   --source-ranges=0.0.0.0/0 \
   --target-tags=puma-server

#!/bin/bash
# create VM
gcloud compute instances create reddit-app \
  --boot-disk-size=10GB \
  --image-family reddit-full \
  --image-project=infra-197919 \
  --machine-type=g1-small \
  --restart-on-failure \
  --tags puma-server 

# create firewall rule
gcloud compute firewall-rules create default-puma-server \
   --allow=tcp:9292 \
   --description="Access puma server from external network" \
   --source-ranges=0.0.0.0/0 \
   --target-tags=puma-server

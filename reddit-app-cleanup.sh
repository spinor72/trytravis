#!/bin/bash
# delete firewall rule and VM silently
gcloud compute firewall-rules delete default-puma-server --quiet
gcloud compute instances delete reddit-app --quiet

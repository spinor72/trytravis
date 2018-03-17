#!/bin/bash
# test reddit-app
#address=35.204.145.242
address=$(gcloud --format="value(networkInterfaces[0].accessConfigs[0].natIP)" compute instances list --filter="name=('reddit-app')")
port=9292
echo "Checking $address:$port"
ret=$(curl -sL -w "%{http_code}\\n"  "http://$address:$port/" -o /dev/null  --connect-timeout 3  --max-time 5)

if [ $ret = "200" ] ; 
then
   echo "OK" ;
else
   echo "ERROR" ;
fi

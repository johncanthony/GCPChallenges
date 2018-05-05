#!/bin/bash
gcloud -v >/dev/null || exit

VPCNAME="myprivatenetwork"
GCENAME="myprivateinstance"
IPNAME="mystaticip"
FWNAME="http-https"
MACHINETYPE="f1-micro"
ZONE="us-east1-b"
REGION="us-east1"

gc="gcloud compute"

$gc addresses create $IPNAME --region=$REGION

$gc instances create $GCENAME\
	--machine-type=$MACHINETYPE\
	--zone=$ZONE\
	--network=$VPCNAME\
	--address=$IPNAME

$gc firewall-rules create $FWNAME\
	--allow tcp:80,tcp:443\
	--network=$VPCNAME

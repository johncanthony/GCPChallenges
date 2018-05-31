#!/bin/bash

PROJECT="$(gcloud config get-value project)"
VPC_NAME="myprivatenetwork"
GCE_NAME="myprivateinstance"
IP_NAME="mystaticip"
FW_NAME="ssh-http-https"
SERVICE_ACCOUNT="sshuser"
ZONE_NAME="tgb"

ZONE="us-east1-b"
REGION="us-east1"

gc="gcloud compute --quiet"

$gc addresses delete $IP_NAME\
	--region $REGION

$gc firewall-rules delete $FW_NAME

$gc instances delete $GCE_NAME\
	--zone $ZONE

$gc networks delete $VPC_NAME

gcloud iam service-accounts delete\
	$SERVICE_ACCOUNT@$PROJECT.iam.gserviceaccount.com\
	--quiet

touch tmpfile
gcloud dns record-sets import tmpfile\
	--zone $ZONE_NAME\
	--delete-all-existing
rm -f tmpfile

gcloud dns managed-zones delete $ZONE_NAME

#if [ -n "$($gc addresses list --region=$REGION 2>/dev/null | grep -q $IPNAME)" ]; then $gc addresses delete $IPNAME --region=$REGION; fi
#if [ -n "$($gc networks list 2>/dev/null | grep -q $VPCNAME)" ]; then $gc networks delete $VPCNAME; fi
#if [ -n "$($gc instances list 2>/dev/null | grep -q $GCENAME)" ]; then $gc instances delete $GCENAME --zone=$ZONE; fi
#if [ -n "$($gc firewall-rules list 2>/dev/null | grep -q $FWNAME)" ]; then $gc firewall-rules delete $FWNAME; fi
#if [ -n "$($gc firewall-"

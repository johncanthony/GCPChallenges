#!/bin/bash
gcloud -v >/dev/null || exit

PROJECT="$(gcloud config get-value project)"
VPC_NAME="myprivatenetwork"
GCE_NAME="myprivateinstance"
IP_NAME="mystaticip"
FW_NAME="ssh-http-https"
MACHINE_TYPE="f1-micro"
ZONE="us-east1-b"
REGION="us-east1"
SERVICE_ACCOUNT="sshuser"

gc="gcloud compute --quiet"

gcloud iam service-accounts create $SERVICE_ACCOUNT

$gc addresses create $IP_NAME\
	--region=$REGION

$gc instances create $GCE_NAME\
	--machine-type=$MACHINE_TYPE\
	--zone=$ZONE\
	--network=$VPC_NAME\
	--address=$IP_NAME\
	--service-account=$SERVICE_ACCOUNT@$PROJECT.iam.gserviceaccount.com

$gc firewall-rules create $FW_NAME\
	--allow tcp:80,tcp:443,tcp:22\
	--network=$VPC_NAME

SERVER_IP="$($gc instances list\
		--format='value(EXTERNAL_IP)')"

echo "[webserver]\n$GCE_NAME.$ZONE.$PROJECT" > hosts

$gc config-ssh

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
ZONE_DOMAIN="thegreekbrit.com"
ZONE_NAME="tgb"

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

gcloud dns managed-zones create $ZONE_NAME\
	--dns-name=$ZONE_DOMAIN\
	--description="this is a zone"

gcloud dns record-sets transaction start\
	--zone=$ZONE_NAME

gcloud dns record-sets transaction add $SERVER_IP\
	--name=$ZONE_DOMAIN\
	--ttl=300\
	--type=A\
	--zone=$ZONE_NAME

gcloud dns record-sets transaction execute\
	--zone=$ZONE_NAME

gcloud dns record-sets transaction abort\
	--zone $ZONE_NAME

NS="$(gcloud dns managed-zones describe $ZONE_NAME | egrep -o 'ns.*googledomains.*\w' | tr '\n' ' ')"
NS1=$(echo $NS | cut -d\  -f1)
NS2=$(echo $NS | cut -d\  -f2)
NS3=$(echo $NS | cut -d\  -f3)
NS4=$(echo $NS | cut -d\  -f4)

echo $NS1 $NS2 $NS3 $NS4

$gc config-ssh

#todofbust up NS into NS1/2/3/4
sh associate_domain.sh $DOMAIN $NS1 $NS2 $NS3 $NS4


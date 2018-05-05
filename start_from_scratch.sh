#!/bin/bash

VPCNAME="myprivatenetwork"
GCENAME="myprivateinstance"
IPNAME="mystaticip"
FWNAME="http-https"

ZONE="us-east1-b"
REGION="us-east1"

gc="gcloud compute"

if [ -n "$($gc addresses list --region=$REGION 2>/dev/null | grep -q $IPNAME)" ]; then $gc addresses delete $IPNAME --region=$REGION; fi
if [ -n "$($gc networks list 2>/dev/null | grep -q $VPCNAME)" ]; then $gc networks delete $VPCNAME; fi
if [ -n "$($gc instances list 2>/dev/null | grep -q $GCENAME)" ]; then $gc instances delete $GCENAME --zone=$ZONE; fi
if [ -n "$($gc firewall-rules list 2>/dev/null | grep -q $FWNAME)" ]; then $gc firewall-rules delete $FWNAME; fi

#!/bin/bash
gcloud -v >/dev/null || exit

VPCNAME="myprivatenetwork"

gcloud compute networks create $VPCNAME

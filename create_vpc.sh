#!/bin/bash
gcloud -v >/dev/null || exit

VPC_NAME="myprivatenetwork"

gcloud compute networks create $VPC_NAME

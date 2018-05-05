# GCPChallenges

The goal of this week is to learn more about GCE and VPC. Setting up and configuring a VPC and a GCE instance with a web server should help you become more familiar with VPC, Security groups, and launching and accessing GCP instances.

This week's project, which is due by our next session:

* Setup a VPC in GCP. Try to do this using gcloud instead of the web ui. There are a bunch of pieces that the wizard does in the web ui without telling you. Setting up manually will help you to learn about the various components needed for a VPC to work. Most of these are components that only need to be set up once for the lifetime of the VPC, so you probably won't encounter them often, but knowing about them can help with troubleshooting later on.

* Launch a GCE instance (you can and should use whichever instance type is included in the GCP free tier) inside the VPC you created. Allow both http and https traffic. Ensure you have set the ip as a static ip.

* Write an ansible playbook to install and configure nginx on an instance, including fetching a certificate from Let's Encrypt. The playbook should be able to take a fresh-out-of-the-wrapper GCE instance, and when it is done, have nginx serving HTTP and HTTPS with a Let's Encrypt certificate.


Deliverables:

Bash script containing all of the GCloud Commands for VPC creation

Bash Script containing all of the GCloud Commands for GCE creation and attaching
to VPC

Ansible Playbook for nginx with TLS configuration

How To Deliver:

Fork this repo
Create a branch with your username and challenge number (userName_challenge_X)
add a directory containing the deliverable files
Create a pull request to submit to the new branch


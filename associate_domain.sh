#!/bin/bash
# 
# Updates $DOMAIN nameservers via Namecheap API
# $API_USER, $API_KEY, and $NAMECHEAP_USER are stored in 'config.txt'
## $DOMAIN is read from CLI
## Two (2) nameservers are read from command line, or in the file 'nameservers.txt'
### NOTE: only the first two nameservers will be parsed
# 
# SYNTAX:
# ./associate_domain domain.tld nameserver1.tld nameserver2.tld
#

API_USER=""
API_KEY=""
NAMECHEAP_USER=""
DOMAIN=""
NS1=""
NS2=""

CONFIG_FILE="config.txt"
NS_FILE="nameservers.txt"

IP_ADDR="$(curl 

function help() {
	echo "SYNTAX"
	echo "	./associate_domain domain.tld nameserver1.tld nameserver2.tld"
}

# read $NS1 and $NS2 from CLI args or from nameservers.txt
function read_ns(args) {
	#todo fix this
	if [ $args.length -eq 2]
		then
		NS1=$args[0]
		NS2=$args[1]
	elif [ -f nameservers.txt ]
		#todo fix this hack
		source nameservers.txt
		
	else
		echo "reading nameservers from file..."
		source $NS_FILE
		if [ ! -z $NS1 -and ! -z $NS2 ]
			then
		echo "INVALID NUMBER OF NAMESERVERS" >&2
		exit 99
	fi
}

#global variables ftw
read_ns($ARGV)

# split domain into second- and top-level pieces
function split_domain($DOMAIN) {
	garbage=""
	
	IFS=. \
		read DOMAIN_SLD DOMAIN_TLD garbage <<< $DOMAIN
		
		# exit if subdomains are included
		if [ ! -z $garbage ]
			then
			echo "DOMAIN TOO LONG. MUST INCLUDE ONLY SECOND-LEVEL AND TOP-LEVEL DOMAINS" >&2
			echo "EXAMPLE: google.com *NOT* www.google.com" >&2
			exit 50
		fi
}

split_domain($DOMAIN)

# Update $DOMAIN custom nameservers at namecheap
# REQUIRED:
## API_USER - namecheap api user
## API_KEY - namecheap api key
## DOMAIN_SLD - second-level domain of $DOMAIN (google, github, thegreekbrit)
## DOMAIN_TLD - top-level domain of $DOMAIN (net, com, gov, ninja)
## NS1 - nameserver 1
## NS2 - nameserver 2
function update_nameservers(api_user,api_key,username,ip,sld,tld,ns1,ns2) {
	api_command="namecheap.domains.dns.setCustom"
	URL="https://api.namecheap.com/xml.response"
	
	# gross redundant cleanup
	f_api_user="ApiUser=$api_user"
	f_api_key="ApiKey=$api_key"
	f_username="UserName=$api_user"
	f_sld="SLD=$sld"
	f_tld="TLD=$tld"
	f_ip="ClientIp=$IP_ADDR"
	f_ns="NameServers=$ns1,$ns2"
	f_api_command="Command=$api_command"
	
	
	resp=$(curl "URL?$f_api_user&$f_api_key&f_command&f_sld&f_tld&f_ns")
	
	#todo check for STATUS="ERROR"
	echo $resp
}

update_nameservers($API_USER, $API_KEY, $NAMECHEAP_USER, $IP_ADDR, $SLD, $TLD, $NS1, $NS2)

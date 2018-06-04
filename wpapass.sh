#!/usr/bin/env bash

# AUTHOR:		Trevor Bautista
# CREATED:		5 March 2018
# LAST UPDATED:	4 June 2018
# VERSION:		0.1
# DESCRIPTION:
# 	This script generates a hashed password for WPA-PEAP
# 	networks using MSCHAPv2 phase2 authentication.
###############################################################

echo "Enter password:"
read -s PASS
echo -n "$PASS" | iconv -t UTF-16LE | openssl md4

#!/usr/bin/env bash

# AUTHOR:		Trevor Bautista
# CREATED:		21 May 2018
# LAST UPDATED:	4 June 2018
# VERSION:		0.1
# DESCRIPTION:
# 	This script is used to print out Xorg device
# 	events, filtered for mouse and keyboard; intended
# 	for Lenovo Thinkpad x220t
###############################################################

xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'

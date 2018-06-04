#!/usr/bin/env bash

# AUTHOR:		Trevor Bautista
# CREATED:		23 May 2018
# LAST UPDATED:	4 June 2018
# VERSION:		0.1
# DESCRIPTION:
# 	This script is used to help the script "backlightctl.sh" by
# 	directly setting the screen brightness; intended for 
# 	Lenovo Thinkpad x220t
#
# 	NOTE: Not used anymore
###############################################################

DEVICE=$(ls /sys/class/backlight)




echo $1 | sudo tee /sys/class/backlight/$DEVICE/brightness

#!/usr/bin/env bash

# AUTHOR:		Trevor Bautista
# CREATED:		4 June 2018
# LAST UPDATED:	4 June 2018
# VERSION:		0.1
# DESCRIPTION:
# 	This script is used to mass compare any "file.gz" with its
# 	checksum "file.gz.<checksum>" where <checksum> could be,
# 	for example, 'sha256' or 'md5'.
###############################################################

CHECKSUM=sha256
CHECKSUM_CMD="$CHECKSUM"sum



USAGE="Usage: \
	checksum-cmp <gz_dir> <checksum_dir>"

CHECKSUM_DIR=$2
GZ_DIR=$1

if [ $# -lt 2 ]; then
	echo "Too few arguments supplied."
	echo $USAGE
elif [ -x $1 ]; then
	if [ -x $2 ]; then
		#diff <(cd $GZ_DIR && ls | egrep "*.gz$" | sort | xargs -I {} $CHECKSUMsum {} | awk '{print $1}') <(cd $SHA256_DIR && ls | egrep ".gz.$CHECKSUM$" | sort | xargs -I {} awk 1 {})
		#diff <(cd $GZ_DIR && ls | egrep "*.gz$" | sort | xargs -I {} $CHECKSUM_CMD {}) <(cd $CHECKSUM_DIR && for file in $(ls | egrep "*.gz.$CHECKSUM$"); do echo "$(cat ./$file)  $(echo $file | sed 's/\.'"$CHECKSUM"'//g')";done)
		echo "Getting list of archives..."

		GZ_FILES=($(ls $GZ_DIR | egrep "*.gz$" | sort))

		echo "Checking for checksums..."

		for file in ${GZ_FILES[@]}; do 
			[[ -f $CHECKSUM_DIR"/"$file"."$CHECKSUM  ]] || { echo "Checksum file '"$CHECKSUM_DIR"/"$file"."$CHECKSUM"' doesn't exist." 1>&2; exit 1; }
		done

		GZ_CHECKSUM_FILES=($(for file in $GZ_FILES; do echo "$file"."$CHECKSUM"; done | sort))
		#GZ_FILES="$(for file in $GZ_FILES; do echo $file; done)"

		echo "Comparing Checksums for "$CHECKSUM"..."
		
		diff <(cd $GZ_DIR && for file in $GZ_FILES; do echo $file; done | xargs -I {} $CHECKSUM_CMD {}) <(cd $CHECKSUM_DIR && for file in $GZ_CHECKSUM_FILES; do echo "$(cat ./$file)  $(echo $file | sed 's/\.'"$CHECKSUM"'//g')";done)
	else
		echo "Directory '$2' does not exist."
		echo $USAGE
	fi
else
	echo "Directory '$1' does not exist."
	echo $USAGE
fi

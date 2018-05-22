#!/bin/bash

# Get last folder from directory listing
LAST=$(ls -1 updates/ | sort -V | tail -n 1)

# retrieve padded number from: 00014-CBO-20180520173900
padIndex=$(echo $LAST | cut -d '-' -f 1)

# Remove padded Zeros, needed to increament next update
nozero=$(echo $padIndex | sed 's/^0*//')

# Increment number
k=$(($nozero + 1))

# Format new folder name to represent database update request
REQ=$(TIMESTAMP=`date '+%Y%m%d%H%M%S'` ; printf -v j "%05d" $k ; echo $j-CBO-$TIMESTAMP)

echo $REQ

# mkdir -p updates/$REQ/DEPLOY_SCRIPTS/
# mkdir -p updates/$REQ/BACKOUT_SCRIPTS/
# touch updates/$REQ/README.md

#!/bin/bash 

REQ_BRANCH=$(./bin/nextReq.sh)
TS=$(echo $REQ_BRANCH | cut -d'-' -f 3)

git checkout -b "REQ-${REQ_BRANCH}"
mkdir -p updates/${REQ_BRANCH}/DEPLOY_SCRIPTS/
mkdir -p updates/${REQ_BRANCH}/BACKOUT_SCRIPTS/
touch updates/${REQ_BRANCH}/READMD.md

# Generate sample files
touch updates/${REQ_BRANCH}/DEPLOY_SCRIPTS/001-$TS.sql
touch updates/${REQ_BRANCH}/DEPLOY_SCRIPTS/002-$TS.sql

touch updates/${REQ_BRANCH}/BACKOUT_SCRIPTS/001-$TS.sql
touch updates/${REQ_BRANCH}/BACKOUT_SCRIPTS/002-$TS.sql

cd updates/${REQ_BRANCH}/DEPLOY_SCRIPTS/ 
echo '# Sample SQL file filename is the order in which scripts are executed' > 001-$TS.sql
echo '# Sample SQL file filename is the order in which scripts are executed' > 002-$TS.sql

cd ../../../
cd updates/${REQ_BRANCH}/BACKOUT_SCRIPTS/
echo '# Sample SQL file filename is the order in which scripts are executed' > 001-$TS.sql
echo '# Sample SQL file filename is the order in which scripts are executed' > 002-$TS.sql

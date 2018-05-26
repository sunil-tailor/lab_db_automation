#!/bin/bash 

REQ_BRANCH=$(./bin/stateNextReq.sh)
echo $REQ_BRANCH >> ./state/requests.txt
git add ./state/requests.txt
git commit -am "updated requests.txt with new REQ  ${REQ_BRANCH}"
git push origin master

# Timestamp for SQL script
TS=$(echo $REQ_BRANCH | cut -d'-' -f 3)

SCM_BRANCHNAME=$(echo "REQ-${REQ_BRANCH}")

echo "log: REQ Branch Name - ${REQ_BRANCH}"
echo "log: TimeStamp - ${TS}"
echo "log: SCM Branch Name - ${SCM_BRANCHNAME}"

git checkout -b ${SCM_BRANCHNAME}

mkdir -p ${BUILD_HOME}/updates/${REQ_BRANCH}/DEPLOY_SCRIPTS/
mkdir -p ${BUILD_HOME}/updates/${REQ_BRANCH}/BACKOUT_SCRIPTS/
touch ${BUILD_HOME}/updates/${REQ_BRANCH}/READMD.md

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
echo ${REQ_BRANCH}

git add updates/${REQ_BRANCH}/*
git commit 'First Commit for Branch REQ-${REQ_BRANCH}'
git push --set-upstream origin "REQ-${REQ_BRANCH}"
 
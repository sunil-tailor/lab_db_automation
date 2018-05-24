#!/bin/bash

if [ ! -f state/initalised ]; then
    TIMESTAMP=`date '+%Y%m%d%H%M%S'` ; printf -v j "%05d" $k ; echo $j-CBO-$TIMESTAMP > state/requests.txt
    touch state/initalised
    git add state/*
    git commit -am 'System initalised'
    git push origin master
else
    echo 'System already initalised'
fi
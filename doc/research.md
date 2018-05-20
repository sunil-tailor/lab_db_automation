# 



# Research 


```
# Get last folder from directory listing 
ls -1 updates/ | sort -V | tail -n 1


# retrieve padded number from: 00014-CBO-20180520173900
echo $LAST | cut -d '-' -f 1

# Remove padded Zeros
nozero=$(echo $z | sed 's/^0*//')

# Increment number
k=$(($nozero + 1))

# Format new folder name
TICKET=$(TIMESTAMP=`date '+%Y%m%d%H%M%S'` ; i=$k ; printf -v j "%05d" $i ; echo $j-CBO-$TIMESTAMP)

mkdir -p updates/$TICKET
```
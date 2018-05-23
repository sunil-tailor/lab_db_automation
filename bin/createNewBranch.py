#!/usr/bin/python

import os, time, datetime

PAD_SIZE=5

l = os.listdir('./updates')
l.sort()

'''
for filename in l:
    if filename[0].isdigit():
        print filename[0:5]
'''

# remove leading zeros
n = l[-1][0:5].lstrip('0')
# increment count
k =  int(n) + 1 
 
# add string padding of leading zeros
code = str(k).zfill(PAD_SIZE)
# print code

# add timestamp
ts = time.time()
st = datetime.datetime.fromtimestamp(ts).strftime('%Y%m%d%H%M%S')
print "%s-CBO-%s" % (code, st)




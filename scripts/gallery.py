#!/usr/bin/env python3

import os
import sys
import time
import fnmatch
import pprint
from exifread import process_file

gallery="nc_082016"

def traverse(dir):
    list = []
    for fn in os.listdir(dir):
        if fnmatch.fnmatch(fn, "IMG*.JPG"):
            list.append(fn)
    return sorted(list)

def exif_info2time(ts):
    tpl = time.strptime(str(ts) + 'UTC', '%Y:%m:%d %H:%M:%S%Z')
    return time.mktime(tpl)

   
list = traverse(sys.argv[1])
for l in list:
    origfn = "./o{}".format(l)
    date=""
    with open(origfn, 'rb') as imgfile:
        data = process_file(imgfile)
        if (data):
            #pprint.pprint(data)
            tm = exif_info2time(data['EXIF DateTimeOriginal'].printable)
            date = time.strftime("%Y/%m/%d", time.gmtime(tm))
            
    print(".. figure:: phoo/{}/{}".format(gallery, l))
    print("   :align: center")
    print("   :alt:")
    print("")
    print("   *({})*".format(date))
    print("")
    print("----")
    print("")
    print("")

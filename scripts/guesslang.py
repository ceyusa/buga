#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re
import os
import sys
import codecs
import fnmatch
import fileinput
from guess_language import guess_language

def detectlang(file):
    with codecs.open(file, 'r', 'utf-8') as file:
        return guess_language(file.read());

def setlang(f, l):
    lang = u"\n:lang: " + l
    try:
        for line in fileinput.input(f, inplace=True):
            print(re.sub('^:slug:.*', unicode(line.rstrip(), errors='ignore') + lang, line.rstrip()))
    except OSError as e:
        print "OSError [%d]: %s at %s" % (e.errno, e.strerror, f)
        pass


def traverse(dir):
    list = []
    for fn in os.listdir(dir):
            if fnmatch.fnmatch(fn, "*.rst"):
                f = os.path.join(dir, fn)
                lang = detectlang(f)
                if lang == u'en' or lang == u'fr':
                    list.append((f, lang))
    return sorted(list, key=lambda t: t[0])
   
list = traverse(sys.argv[1])
for l in list:
    print(l)
    setlang(l[0], l[1])

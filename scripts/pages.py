#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import csv
import os

with open(sys.argv[1], 'r') as fp:
    reader = csv.reader(fp, delimiter=',', quotechar='|')
    for row in reader:
        slug = row[0]
        title = row[2]
        content = row[3]

        filename = os.path.join('pages', slug + '.rst');
        with open(filename, 'w') as rst:
            # title
            rst.write('{}\n'.format(title))
            rst.write('{}\n\n'.format('#' * len(title)))
            # metadata
            rst.write(':author: Víctor Jáquez\n')
            rst.write(':date: {}\n'.format(row[1]))
            rst.write(':slug: {}\n\n'.format(slug))
            # content
            rst.write(content)
            

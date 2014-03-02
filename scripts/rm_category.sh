#!/bin/sh

files=$(git grep ":slug:" | awk -F : '{print $1}')
for file in $files; do
    sed '/:category:/d' $file > tmp.rst
    mv tmp.rst $file
done


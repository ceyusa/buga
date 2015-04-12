#!/bin/sh

process() {
    image=$1
    echo "processing ${image}"
    mv ${image} "o${image}"
    convert "o${image}" -scale 30% -strip -quality 86 -interlace Plane ${image}
}

for i in *.jpg
do
    process $i
done

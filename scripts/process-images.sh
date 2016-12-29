#!/bin/sh

process() {
    image=$1
    echo "processing ${image}"
    mv ${image} "o${image}"
    convert "o${image}" -scale 20% -strip -quality 86 -interlace Plane ${image}
}

for i in $( find . -maxdepth 1 -iname "*.JPG" -printf '%f\n' )
do
    process $i
done

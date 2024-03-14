#!/bin/bash

wget https://burakarslan.com/inf333/tp/tp1.tar.gz

mkdir tp2
cd tp2

tar -xzf ../tp1.tar.gz

ls -1 | wc -l
ls -1 | sha256sum
du --bytes

find . -type f -exec stat -c "%i %n" {} \;

# 1.1
find . -type f -name "*.bin" -exec sha256sum {} + | sort | uniq --all-repeated=separate -w 64 | {
    read -r hash file
    original="$file"
    while read -r hash file; do
        if [ "$prev" = "$hash" ]; then
            ln -f "$original" "$file.tmp" && mv -f "$file.tmp" "$file"
        else
            original="$file"
        fi
        prev="$hash"
    done
}

# 1.2 
ls -1 | wc -l
ls -1 | sha256sum
du --bytes

find . -type f -exec stat -c "%i %n" {} \;


# Explanation: The inodes of the duplicate files are changed with the original file.
# Since we don't hold the same data under different file names in the memory, disk
# usage went down significantly. For me it went down from 16896 bytes to 5504 bytes. 

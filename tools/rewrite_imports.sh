#!/bin/bash

IFS=' ' read -r -a filepaths <<< "$2"

filenames=()
for input in "${filepaths[@]}"; do
    filename="$(basename "$input")"
    filenames+=("$filename")
done

for i in "${!filenames[@]}"; do
    filename="${filenames[$i]}"
    input="${filepaths[$i]}"

    tmp1="$(mktemp)"
    cp "$input" "$tmp1"
    # This is the actual change that I need to make, rewriting imports as requires
    sed -i -e 's/^import\(.*\)from \("@.*\)"/const\1= require(\2")/g' "$tmp1"

    echo "Copying from $input to $1/$filename"
    cp "$tmp1" "$1/$filename"
done

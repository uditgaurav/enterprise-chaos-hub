#!/bin/bash

# Check if the version argument is passed
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <new-version>"
    exit 1
fi

NEW_VERSION=$1

# Directory to search in
DIR="experiments"

# Loop over each file in the experiments folder
find "$DIR" -type f | while read -r file; do
    echo "Updating $file ..."

    # Use sed to replace the image versions
    sed -i.bak -E "s,(chaosnative/go-runner|chaosnative/chaos-go-runner):[0-9]+\.[0-9]+\.[0-9]+,\1:$NEW_VERSION,g" "$file"

    # Remove the backup files created by sed
    rm -f "${file}.bak"
done

echo "Update complete!"


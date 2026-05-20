#!/bin/dash

output_file="$1"
url="$2"
brave --headless --print-to-pdf="$output_file" "$url"

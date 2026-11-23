#!/bin/bash
# rofi -preview-cmd thumbnail generator -- renders a PDF's first page via
# pdftoppm. Used by rofi/launchers/rofi-books for PDF previews.
# Usage: pdf-thumbnail.sh <input> <output> <size>
#
# Non-PDF inputs exit without producing output, so rofi falls back to its
# normal icon-theme lookup for those entries instead of showing nothing.
input=$1
output=$2
size=${3:-128}

case "$input" in
    *.pdf | *.PDF) ;;
    *) exit 0 ;;
esac

tmp=$(mktemp -u)
pdftoppm -f 1 -l 1 -singlefile -scale-to "$size" -png "$input" "$tmp" 2>/dev/null \
    && mv "$tmp.png" "$output"

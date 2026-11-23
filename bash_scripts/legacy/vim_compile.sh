#!/bin/bash

path="$@"
base="$(basename -- "$path")"
basewoext="${base%.*}"
extension="${base##*.}"
dir="${path%${base}}"

cd "$dir" || exit 1

case $extension in
    md) pandoc --standalone --to man "$base" | man /dev/stdin ;;
    tex)latexmk -pdf && latexmk -pdf -c;;
    py) python "$base" ;;
    #m) echo "waitfor(gcf)" >> "$base" && octave "$base" && sed -i '/waitfor(gcf)/d' "$base" ;;
    m) octave "$base" ;;
    c) gcc "$base" -o "$basewoext" && ./"$basewoext" ;;
    sh) bash "$base";;
    cpp) g++ "$base" -o "$basewoext" && ./"$basewoext" ;;
    h) sudo make clean install ;; 
    ms) preconv "$base" | tbl |eqn -Tpdf| groff -Tpdf -P-e -ms -P-pa4 > "${basewoext}.pdf";;
    mm) preconv "$base" | tbl |eqn -Tpdf| groff -Tpdf -P-e -mm -P-pa4 > "${basewoext}.pdf";;
    msh) /usr/heirloom/bin/ucb/tbl "$base" | /usr/heirloom/bin/ucb/eqn | /usr/heirloom/bin/ucb/troff -mpictures -Tps -ms | /usr/heirloom/bin/ucb/dpost -P-e > "${base%.*}.ps" &;;
    mmh) /usr/heirloom/bin/ucb/tbl "$base" | /usr/heirloom/bin/ucb/eqn | /usr/heirloom/bin/ucb/troff -mpictures -Tps -mm | /usr/heirloom/bin/ucb/dpost -P-e > "${base%.*}.ps" &;;
    *) echo "Not a valid file extension for compilation script";;
esac

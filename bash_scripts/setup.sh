#! /bin/sh

for pkg in $(pacman -Q | cut -d' ' -f1); do
    pacman -S --noconfirm $pkg
done



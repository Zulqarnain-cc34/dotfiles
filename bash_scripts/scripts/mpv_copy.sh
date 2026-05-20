#!/bin/bash

url="$(xclip -out -selection clipboard)"

mpv "$url"

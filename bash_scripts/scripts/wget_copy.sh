#!/bin/bash

input=$(xclip -out -selection clipboard)

konsole -e wget -cr -P ~/Downloads ${input}

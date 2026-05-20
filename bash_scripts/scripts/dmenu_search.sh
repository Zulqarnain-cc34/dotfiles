#!/bin/dash

set -e

stdbuf -o0 locate --regex "^$HOME/(Videos|Pictures|Music|Documents|Downloads|build)" | dmenu -i -p 'Find:' -l 15 -fn xos4terminus-10 -nb '#3e3e3e' -nf '#aaaaaa' -sb '#5e5e5e' -sf '#dedede'| xargs -r -I{} xdg-open "{}"

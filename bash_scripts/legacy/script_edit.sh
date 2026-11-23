#!/bin/bash 

script_path="$(whereis $1| cut -d ' ' -f2)"

/usr/bin/nvim $script_path

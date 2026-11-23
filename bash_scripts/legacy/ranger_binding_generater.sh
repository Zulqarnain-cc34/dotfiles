#!/bin/bash

list=($(cat ~/bin/bash_scripts/personal/directory.list))

commands_generator () {
    echo -e "map gv. cd $1
map tv. tab_new $1
map mv. shell mv %s $1/
map cv. shell cp %s $1/\n"
}

for i in ${list[@]}; do
    commands_generator $i
done

# Defined in /home/jojo/.config/fish/functions/mkcd.fish @ line 2
function mkcd --description 'Make directory and change to it'
    mkdir -p $argv
    cd $argv
end

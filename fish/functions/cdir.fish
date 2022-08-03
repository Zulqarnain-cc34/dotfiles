# Defined in /home/jojo/.config/fish/functions/cdir.fish @ line 2
function cdir --description Change\ working\ directory\ to\ file\'s\ parent
    cd (dirname $argv)
end

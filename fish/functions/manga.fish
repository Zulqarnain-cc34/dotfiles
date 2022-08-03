# Defined in /home/jojo/.config/fish/functions/manga.fish @ line 2
function manga --description 'Display manga folder with reading tracking'
    if test -n "$argv"; cd $argv; else; cd .; end
    set -l imv_tracker $HOME/.cache/imv/(echo $PWD | base64 -w0)
    if test -f "$imv_tracker"
        and test -r "$imv_tracker"
        imv -r . -n (grep '[[:digit:]]' "$imv_tracker")
    else
        imv -r .
    end
end

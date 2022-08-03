# Defined in /tmp/fish.PNm0Ij/display_tags.fish @ line 2
function display_tags --description 'Display files stored in tag files'
    set -l choice (ls ~/tags | rofi -dmenu -fullscreen -p " tag: ")
    if test -n "$choice"
        imv echo (cat ~/tags/$choice)
    end
end

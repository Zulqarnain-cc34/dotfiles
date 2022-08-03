# Defined in /tmp/fish.DQH69P/add_manga.fish @ line 2
function add_manga --description 'Generate desktop entries with cover of manga volumes'
    set -l DIRECTORY "$argv[1]"
    set -l APP_PATH "$HOME/.local/share/applications"

    function listnames
        find "$argv" -mindepth 1 -maxdepth 1 -type d -printf '%P\n' | sed 's#^\([^(]*\).*#\1#'
    end
    function listpaths
        find "$argv" -mindepth 1 -maxdepth 1 -type d | sed 's/ /\ /g'
    end

    set -l names (listnames $DIRECTORY)
    set -l paths (listpaths $DIRECTORY)

    for volume in (seq -w (count $paths))
        set -l slug (echo "$names[$volume]" | sed -e 's#^\([^(]*\).*#\1#' -e 's/ /-/g' -e 's/[A-Z]/\L&/g' -e 's/-$//')
        set -l cover_source (find $paths[$volume] -type f | sort | head -n1)
        set -l cover $HOME/.config/manga/$slug.jpg
        mkdir -p (dirname $cover)
        convert -resize 256 $cover_source $cover
        echo "
[Desktop Entry]
Type=Application
Name=$names[$volume]
Icon=$cover
Exec=fish -c 'manga \"$paths[$volume]\"'
Categories=Manga" > $APP_PATH/$slug.desktop
    end
end

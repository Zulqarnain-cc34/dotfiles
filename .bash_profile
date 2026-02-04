if [ -r "$HOME/.profile" ]; then . "$HOME/.profile"; fi
case "$-" in *i*) if [ -r "$HOME/.bashrc" ]; then . "$HOME/.bashrc"; fi ;; esac
if [ -r ~/.profile ]; then . /home/alpha/.profile; fi
case "$-" in *i*) if [ -r ~/.bashrc ]; then . /home/alpha/.bashrc; fi ;; esac

#!/bin/sh

tmux new-session -d
tmux new-window -n "calcurse" && tmux send-keys "calcurse" 'Enter'
tmux new-window -n "neomutt" && tmux send-keys "neomutt" 'Enter'
tmux new-window -n "newsboat" && tmux send-keys "newsboat" 'Enter'
tmux new-window -n "ncmpcpp" && tmux send-keys "ncmpcpp" 'Enter' \; split-window -v 'htop'
tmux -2 attach-session -d

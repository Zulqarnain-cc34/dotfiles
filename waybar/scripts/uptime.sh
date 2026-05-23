#!/usr/bin/env bash
# Polybar uptime module equivalent

uptime | awk -F, '{ sub(".*up ", "", $1); print $1 }'

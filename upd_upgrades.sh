#! /bin/sh -e

update_file="$HOME/.cache/available_pacman_upd.cache"
checkupdates | wc -l > "$update_file"

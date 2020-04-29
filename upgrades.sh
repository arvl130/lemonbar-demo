#! /bin/sh -e

update_file="$HOME/.cache/available_pacman_upd.cache"
find "$update_file" | entr printf 'G%s\n' "$(cat "$update_file")"

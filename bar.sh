#! /bin/sh -e

FIFO_FILE="/tmp/test.fifo"
mkfifo "$FIFO_FILE"

trap 'trap - TERM; rm -f $FIFO_FILE; kill 0' INT TERM

# from here, we background (&) everything
# so that our traps commands actually work

./clock.sh > "$FIFO_FILE" &
./uptime.sh > "$FIFO_FILE" &
./wsind.sh > "$FIFO_FILE" &
./upgrades.sh > "$FIFO_FILE" &

IFS='' # so that spaces are actually read
while read -r line; do
    case "$line" in
        C*) clock="${line#?}" ;;
        G*) upg_c="${line#?}" ;;
        S*) ws_in="${line#?}" ;;
        U*) utime="${line#?}" ;;
    esac
    final_output="%{l}$utime%{c}$ws_in|$upg_c%{r}$clock"
    echo "$final_output"
done < "$FIFO_FILE" | lemonbar | sh &

wait # so we don't background the script itself

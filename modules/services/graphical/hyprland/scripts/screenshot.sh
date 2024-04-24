#!/bin/sh

grimblast copysave $1 &
pids=$(pgrep -f "slurp" | grep -v "$!" | xargs)

[[ -z "$pids" ]] || kill $pids

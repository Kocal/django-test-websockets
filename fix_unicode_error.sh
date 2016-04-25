#!/usr/bin/env bash
tox_envname="$1"
tox_envsitepackagesdir="$2"

echo "Gonna fix unicode error for $tox_envname ($tox_envsitepackagesdir)..."

file_socketio_handler="$tox_envsitepackagesdir/socketio/handler.py"

[[ ! -f "$file_socketio_handler" ]] && echo "Can not find socketio/handler.py file" && exit 1

echo "The file socketio/handler.py exists, fixing it!"

sed -i 's/"Access-Control-Max-Age", 3600/"Access-Control-Max-Age", "3600"/g' "$file_socketio_handler"
exit_code=$?

[[ $exit_code -ne 0 ]] && echo "Something wrong happens with sed (exit code: $exit_code)" && exit 1

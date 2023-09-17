#!/bin/sh

read DURATION

if [ "$DURATION" -le 30000 ]; then
    exit 60
fi

CHCK='curl -sf http://localhost:8008/api/ping/ >/dev/null 2>&1'
eval "$CHCK"
exit_code=$?
if [ "$exit_code" -ne 0 ]; then
    echo "Initializing FreeGPT ..."  >&2
    exit 61
    sleep 5
    eval "$CHCK"
    exit_code=$?
    if [ "$exit_code" -ne 0 ]; then
        echo "FreeGPT is unreachable" >&2
        exit 1
    fi
fi

if [ -f /usr/src/app/curl.txt ]; then
    echo "Cool" > /dev/null
else
    while ! curl -sf http://localhost:8008/api/ping/ >/dev/null 2>&1; do
        sleep 5
    done

    total_memory_gb=$(awk '/MemAvailable/{print int($2 / 1024 / 1024)}' /proc/meminfo)

    if [ "$total_memory_gb" -gt 8 ]; then
        new_url="https://raw.githubusercontent.com/Start9Labs/freegpt-startos/weights/models-big.json"
    else
        new_url="https://raw.githubusercontent.com/Start9Labs/freegpt-startos/weights/models-small.json"
    fi

    curl -X POST "http://localhost:8008/api/model/refresh" \
         -H "Content-Type: multipart/form-data" \
         -F "url=$new_url"

    echo "$(date) - The curl command was executed" >> /usr/src/app/curl.txt
    sed -i "s#https://raw.githubusercontent.com/serge-chat/serge/main/api/src/serge/data/models.json#$new_url#" /usr/src/app/api/static/_app/immutable/nodes/4.*.js
    #sed -i "s#col-span-3 flex flex-col#col-span-3 flex flex-col hidden#" /usr/src/app/api/static/_app/immutable/nodes/2.*.js
    sed -i "s#Say Hi to Serge#Welcome to FreeGPT#" /usr/src/app/api/static/_app/immutable/nodes/2.*.js
    #sed -i "s#px-10 pt-2 pb-4 text-center font-light md:px-16#px-10 pt-2 pb-4 text-center font-light md:px-16 hidden#" /usr/src/app/api/static/_app/immutable/nodes/3.*.js
    sed -i "s#Message Serge#Message#" /usr/src/app/api/static/_app/immutable/nodes/3.*.js
    p_remove="Below is an instruction that describes a task. Write a response that appropriately completes the request."
    sed -i "s#$p_remove##" /usr/src/app/api/static/_app/immutable/nodes/2.*.js
fi
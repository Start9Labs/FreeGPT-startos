#!/bin/sh

printf "\n\nStarting FreeGPT\n\n"

total_memory_gb=$(awk '/MemAvailable/{print int($2 / 1024 / 1024)}' /proc/meminfo)

if [ "$total_memory_gb" -gt 16 ]; then
    export PUBLIC_MODELS_URL="https://raw.githubusercontent.com/Start9Labs/freegpt-startos/weights/models-mega.json"
elif [ "$total_memory_gb" -gt 8 ]; then
    export PUBLIC_MODELS_URL="https://raw.githubusercontent.com/Start9Labs/freegpt-startos/weights/models-big.json"
else
    export PUBLIC_MODELS_URL="https://raw.githubusercontent.com/Start9Labs/freegpt-startos/weights/models-small.json"
fi

exec /usr/src/app/deploy.sh
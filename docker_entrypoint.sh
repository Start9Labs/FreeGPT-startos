#!/bin/sh

printf "\n\nStarting FreeGPT\n\n"

total_memory_gb=$(awk '/MemAvailable/{print int($2 / 1024 / 1024)}' /proc/meminfo)

if [ "$total_memory_gb" -gt 16 ]; then
    export PUBLIC_MODELS_URL="https://raw.githubusercontent.com/Start9Labs/freegpt-startos/weights/models-big.json"
elif [ "$total_memory_gb" -gt 8 ]; then
    export PUBLIC_MODELS_URL="https://raw.githubusercontent.com/Start9Labs/freegpt-startos/weights/models-medium.json"
else
    export PUBLIC_MODELS_URL="https://raw.githubusercontent.com/Start9Labs/freegpt-startos/weights/models-small.json"
fi

export PUBLIC_CPUS=$(nproc)

initialize_models () {
    while ! curl -sf http://localhost:8008/api/ping/ > /dev/null 2>&1; do
        sleep 5
    done
    
    curl -X POST "http://localhost:8008/api/model/refresh" \
         -H "Content-Type: multipart/form-data" \
         -F "url=$PUBLIC_MODELS_URL"
}

initialize_models &
exec /usr/src/app/deploy.sh

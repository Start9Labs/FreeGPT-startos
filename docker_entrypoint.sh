#!/bin/bash

set -x

# Handle termination signals
_term() {
	echo "Received termination signal!"
	kill -TERM "$deploy_process" 2>/dev/null
}

printf "\n\nStarting FreeGPT\n\n"

total_memory_gb=$(awk '/MemAvailable/{print int($2 / 1024 / 1024)}' /proc/meminfo)

if [ "$total_memory_gb" -gt 16 ]; then
    export MODELS_URL="https://raw.githubusercontent.com/Start9Labs/freegpt-startos/weights/models-big.json"
elif [ "$total_memory_gb" -gt 8 ]; then
    export MODELS_URL="https://raw.githubusercontent.com/Start9Labs/freegpt-startos/weights/models-medium.json"
else
    export MODELS_URL="https://raw.githubusercontent.com/Start9Labs/freegpt-startos/weights/models-small.json"
fi

export CPUS=$(nproc)

initialize_models () {
    while ! curl -sf http://localhost:8008/api/ping/ > /dev/null 2>&1; do
        sleep 5
    done
    
    curl -X POST "http://localhost:8008/api/model/refresh" \
         -H "Content-Type: multipart/form-data" \
         -F "url=$MODELS_URL"
}

initialize_models &

/usr/src/app/deploy.sh
deploy_process=$!

# Set up a signal trap and wait for processes to finish
trap _term TERM
wait $deploy_process
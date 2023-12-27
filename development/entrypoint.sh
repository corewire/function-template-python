#!/bin/bash

# Function to cleanly exit the script
cleanup() {
    echo "Caught SIGINT (CTRL+C), exiting..."
    kill %1
    exit 0
}

# Set a trap to catch CTRL+C (SIGINT) and call the cleanup function
trap cleanup SIGINT

while :
do
    echo "Linting code..."
    hatch run lint:check
    echo "Running unit tests..."
    hatch run test:unit
    echo "Starting function..."
    hatch run function --insecure --debug &
    echo "Function started and serving on 0.0.0.0:9443"
    
    inotifywait \
        -r /build/function /build/tests /build/pyproject.toml \
        -e create,delete,modify \
    || break

    # Kills the background job (%1 refers to the most recent background job)
    kill %1

    # Wait for a short period before restarting the loop
    sleep 3
done

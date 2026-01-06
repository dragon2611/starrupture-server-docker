#!/bin/bash
# shellcheck source=scripts/functions.sh
source "/home/steam/server/functions.sh"

SERVER_FILES="/home/steam/server_files"

cd "$SERVER_FILES" || exit

LogAction "Starting StarRupture Dedicated Server"

# Find the server executable
if [ -f "./StarRupture/Binaries/Linux/StarRuptureServerEOS-Linux-Shipping" ]; then
    SERVER_EXEC="./StarRupture/Binaries/Linux/StarRuptureServerEOS-Linux-Shipping"
elif [ -f "./StarRupture/Binaries/Linux/StarRuptureServer" ]; then
    SERVER_EXEC="./StarRupture/Binaries/Linux/StarRuptureServer"
else
    LogError "Could not find server executable. Directory contents:"
    ls -laR "$SERVER_FILES/"
    exit 1
fi

# Build the startup command
STARTUP_CMD="${SERVER_EXEC} -Log -port=${DEFAULT_PORT}"

# Add multihome if specified
if [ -n "${MULTIHOME}" ]; then
    STARTUP_CMD="${STARTUP_CMD} -multihome=${MULTIHOME}"
fi

LogInfo "Server starting on port ${DEFAULT_PORT}"
LogInfo "Using executable: ${SERVER_EXEC}"

# Start the server
eval "$STARTUP_CMD"

#!/bin/bash
# shellcheck source=scripts/functions.sh
source "/home/steam/server/functions.sh"

cd /starrupture || exit

LogAction "Starting StarRupture Dedicated Server"

# Find the server executable (common Unreal Engine paths)
if [ -f "./StarRuptureServer.sh" ]; then
    SERVER_EXEC="./StarRuptureServer.sh"
elif [ -f "./StarRupture/Binaries/Linux/StarRuptureServer" ]; then
    SERVER_EXEC="./StarRupture/Binaries/Linux/StarRuptureServer"
elif [ -f "./StarRuptureServerEOS-Linux-Shipping" ]; then
    SERVER_EXEC="./StarRuptureServerEOS-Linux-Shipping"
else
    LogError "Could not find server executable. Please check /starrupture directory."
    ls -la /starrupture/
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

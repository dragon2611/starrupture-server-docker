#!/bin/bash
# shellcheck source=scripts/functions.sh
source "/home/steam/server/functions.sh"

SERVER_FILES="/home/steam/server-files"

cd "$SERVER_FILES" || exit

LogAction "Starting StarRupture Dedicated Server"

SERVER_EXEC="$SERVER_FILES/StarRuptureServerEOS.exe"

if [ ! -f "$SERVER_EXEC" ]; then
    LogError "Could not find server executable at: $SERVER_EXEC"
    LogError "Directory contents:"
    ls -laR "$SERVER_FILES/"
    exit 1
fi

LogInfo "Found server executable: ${SERVER_EXEC}"
LogInfo "Server starting on port ${DEFAULT_PORT}"
LogInfo "Query port: ${QUERY_PORT}"
LogInfo "Server name: ${SERVER_NAME}"

# Build the startup command with Wine and xvfb
STARTUP_CMD="xvfb-run --auto-servernum wine ${SERVER_EXEC} -Log -Port=${DEFAULT_PORT} -QueryPort=${QUERY_PORT} -ServerName=\"${SERVER_NAME}\""

# Add multihome if specified
if [ -n "${MULTIHOME}" ]; then
    STARTUP_CMD="${STARTUP_CMD} -MULTIHOME=${MULTIHOME}"
fi

LogInfo "Starting with Wine..."

# Start the server
eval "$STARTUP_CMD"
